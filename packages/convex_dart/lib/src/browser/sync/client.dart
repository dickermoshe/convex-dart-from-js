import 'dart:async';
import 'dart:convert';

import 'package:convex_dart/src/browser.dart';

import '../../common/index.dart';
import '../logging.dart';
import 'authentication_manager.dart';
import 'function_result.dart';
import 'local_state.dart';
import 'optimistic_updates_impl.dart';
import 'protocol.dart';
import 'remote_query_set.dart';
import 'request_manager.dart';
import 'session.dart';
import 'udf_path_utils.dart';
import 'web_socket_manager.dart';

/// Options for [BaseConvexClient].
class BaseConvexClientOptions {
  /// Creates base client options.
  const BaseConvexClientOptions({
    this.webSocketFactory,
    this.verbose = false,
    this.logger,
    this.reportDebugInfoToConvex = false,
    this.skipConvexDeploymentUrlCheck = false,
    this.expectAuth = false,
  });

  /// An alternate WebSocket factory for client communication with Convex.
  ///
  /// The default uses [ChannelSyncWebSocket] from `web_socket_channel`.
  final SyncWebSocketFactory? webSocketFactory;

  /// Whether to emit additional logging for debugging.
  final bool verbose;

  /// A custom logger, or `null` to use the default console logger.
  final Logger? logger;

  /// Whether to send additional metrics to Convex for debugging.
  final bool reportDebugInfoToConvex;

  /// Skip validating that the Convex deployment URL looks like
  /// `https://happy-animal-123.convex.cloud` or localhost.
  final bool skipConvexDeploymentUrlCheck;

  /// Whether query, mutation, and action requests should be held back until
  /// the first auth token can be sent.
  ///
  /// This API is experimental: it may change or disappear.
  final bool expectAuth;
}

/// State describing the client's connection with the Convex backend.
class ConnectionState {
  /// Creates a connection state snapshot.
  const ConnectionState({
    required this.hasInflightRequests,
    required this.isWebSocketConnected,
    required this.timeOfOldestInflightRequest,
    required this.hasEverConnected,
    required this.connectionCount,
    required this.connectionRetries,
    required this.inflightMutations,
    required this.inflightActions,
  });

  /// Whether the client has any inflight requests.
  final bool hasInflightRequests;

  /// Whether the WebSocket is currently connected.
  final bool isWebSocketConnected;

  /// The time of the oldest inflight request, if any.
  final DateTime? timeOfOldestInflightRequest;

  /// Whether the client has ever opened a WebSocket to the ready state.
  final bool hasEverConnected;

  /// The number of times this client has connected to the Convex backend.
  ///
  /// A high number may indicate trouble keeping a stable connection.
  final int connectionCount;

  /// The number of times this client has tried and failed to connect.
  final int connectionRetries;

  /// The number of mutations currently in flight.
  final int inflightMutations;

  /// The number of actions currently in flight.
  final int inflightActions;

  Map<String, Object?> toJsonLike() => {
    'hasInflightRequests': hasInflightRequests,
    'isWebSocketConnected': isWebSocketConnected,
    'timeOfOldestInflightRequest': timeOfOldestInflightRequest
        ?.toIso8601String(),
    'hasEverConnected': hasEverConnected,
    'connectionCount': connectionCount,
    'connectionRetries': connectionRetries,
    'inflightMutations': inflightMutations,
    'inflightActions': inflightActions,
  };
}

/// Options for [BaseConvexClient.subscribe].
class SubscribeOptions {
  /// Creates subscribe options.
  const SubscribeOptions({this.journal, this.componentPath});

  /// An optional journal produced from a previous execution of this query.
  ///
  /// If there is an existing subscription to a query with the same name and
  /// arguments, this journal has no effect.
  final QueryJournal journal;

  /// Optional component path for component-scoped queries.
  final String? componentPath;
}

/// Options for [BaseConvexClient.mutation].
class MutationOptions {
  /// Creates mutation options.
  const MutationOptions({this.optimisticUpdate});

  /// An optimistic update to apply along with this mutation.
  ///
  /// An optimistic update locally updates queries while a mutation is pending.
  /// Once the mutation completes, the update is rolled back.
  final OptimisticUpdate? optimisticUpdate;
}

/// Describes updates to queries and mutations within a transition.
class Transition {
  /// Creates a transition description.
  const Transition({
    required this.queries,
    required this.reflectedMutations,
    required this.timestamp,
  });

  final List<({QueryToken token, Map<String, Object?> modification})> queries;
  final List<({int requestId, FunctionResult result})> reflectedMutations;
  final BigInt timestamp;
}

/// Low-level client for directly integrating state management libraries with
/// Convex.
///
/// [BaseConvexClient] should not be used directly unless you need full control
/// over subscriptions and transitions. Most developers should use
/// [ConvexHttpClient] or [ConvexClient] instead.
///
/// [BaseConvexClient] is not Convex function type-aware: it deals with queries
/// as functions that return [Value], not application-specific types.
class BaseConvexClient {
  /// Creates a [BaseConvexClient] connected to [address].
  ///
  /// [onTransition] is called with query tokens whose results changed. Additional
  /// handlers can be registered via [addOnTransitionHandler].
  BaseConvexClient(
    String address,
    void Function(List<QueryToken> updatedQueries) onTransition, {
    BaseConvexClientOptions options = const BaseConvexClientOptions(),
  }) : _address = address,
       _debug = options.reportDebugInfoToConvex,
       _logger =
           options.logger ?? instantiateDefaultLogger(verbose: options.verbose),
       _sessionId = newSessionId() {
    if (!options.skipConvexDeploymentUrlCheck) validateDeploymentUrl(address);
    _state = LocalSyncState();
    _remoteQuerySet = RemoteQuerySet(
      (queryId) => _state.queryPath(queryId),
      _logger,
    );
    _requestManager = RequestManager(_logger, markConnectionStateDirty);
    _optimisticQueryResults = OptimisticQueryResults();
    addOnTransitionHandler((transition) {
      onTransition(transition.queries.map((q) => q.token).toList());
    });
    _authenticationManager = AuthenticationManager(
      _state,
      authenticate: (token) {
        final message = _state.setAuth(token);
        _webSocketManager.sendMessage(message);
        return message['baseVersion']! as int;
      },
      stopSocket: () => _webSocketManager.stop(),
      tryRestartSocket: () => _webSocketManager.tryRestart(),
      pauseSocket: () {
        _webSocketManager.pause();
        _state.pause();
      },
      resumeSocket: () => _webSocketManager.resume(),
      clearAuth: clearAuth,
      logger: _logger,
    );
    _webSocketManager = WebSocketManager(
      _wsUri(address),
      onOpen: (metadata) {
        _webSocketManager.sendMessage({
          ...metadata,
          'type': 'Connect',
          'sessionId': _sessionId,
          if (_maxObservedTimestamp != null)
            'maxObservedTimestamp': _maxObservedTimestamp,
        });
        _remoteQuerySet = RemoteQuerySet(
          (queryId) => _state.queryPath(queryId),
          _logger,
        );
        final (querySetModification, authModification) = _state.restart();
        if (authModification != null) {
          _webSocketManager.sendMessage(authModification);
        }
        _webSocketManager.sendMessage(querySetModification);
        for (final message in _requestManager.restart()) {
          _webSocketManager.sendMessage(message);
        }
      },
      onResume: () {
        final (querySetModification, authModification) = _state.resume();
        if (authModification != null) {
          _webSocketManager.sendMessage(authModification);
        }
        if (querySetModification != null) {
          _webSocketManager.sendMessage(querySetModification);
        }
        for (final message in _requestManager.resume()) {
          _webSocketManager.sendMessage(message);
        }
      },
      onMessage: _handleServerMessage,
      webSocketFactory: options.webSocketFactory ?? ChannelSyncWebSocket.new,
      logger: _logger,
      markConnectionStateDirty: markConnectionStateDirty,
      debug: _debug,
    );
    if (options.expectAuth) {
      _webSocketManager.pause();
      _state.pause();
    }
  }

  final String _address;
  late final LocalSyncState _state;
  late final RequestManager _requestManager;
  late final WebSocketManager _webSocketManager;
  late final AuthenticationManager _authenticationManager;
  late RemoteQuerySet _remoteQuerySet;
  late final OptimisticQueryResults _optimisticQueryResults;
  final bool _debug;
  final Logger _logger;
  final String _sessionId;
  int _nextRequestId = 0;
  BigInt? _maxObservedTimestamp;
  int _transitionHandlerCounter = 0;
  final Map<int, void Function(Transition)> _onTransitionFns = {};
  final Map<int, void Function(ConnectionState)> _connectionStateSubscribers =
      {};
  int _nextConnectionStateSubscriberId = 0;
  ConnectionState? _lastPublishedConnectionState;

  /// Returns the maximum observed server timestamp, if any.
  BigInt? getMaxObservedTimestamp() => _maxObservedTimestamp;

  /// Adds a handler called on each transition.
  ///
  /// External side effects (such as updating UI state) should be handled here.
  void Function() addOnTransitionHandler(void Function(Transition) fn) {
    final id = _transitionHandlerCounter++;
    _onTransitionFns[id] = fn;
    return () => _onTransitionFns.remove(id);
  }

  /// Sets authentication for subsequent queries and mutations.
  ///
  /// See [ConvexClient.setAuth] for parameter semantics.
  Future<void> setAuth(
    AuthTokenFetcher fetchToken,
    void Function(bool isAuthenticated) onChange, [
    void Function(bool isRefreshing)? onRefreshChange,
  ]) => _authenticationManager.setConfig(fetchToken, onChange, onRefreshChange);

  /// Whether an auth token is currently configured.
  bool hasAuth() => _state.hasAuth();

  /// Gets the current JWT auth token and decoded claims, if user auth is set.
  ({String token, Map<String, Object?> decoded})? getCurrentAuthClaims() {
    final auth = _state.getAuth();
    if (auth == null || auth['tokenType'] != 'User') {
      return null;
    }
    final token = auth['value'];
    if (token is! String) {
      return null;
    }

    var decoded = <String, Object?>{};
    try {
      final parts = token.split('.');
      if (parts.length >= 2) {
        final payload = utf8.decode(
          base64Url.decode(_normalizeJwtPart(parts[1])),
        );
        decoded = (jsonDecode(payload) as Map).cast<String, Object?>();
      }
    } on Object {
      decoded = {};
    }
    return (token: token, decoded: decoded);
  }

  /// Clears the current authentication token.
  void clearAuth() {
    final message = _state.clearAuth();
    _webSocketManager.sendMessage(message);
  }

  /// Sets admin auth to allow calling internal functions and acting as an
  /// identity.
  void setAdminAuth(String value, [Map<String, Object?>? actingAs]) {
    final message = _state.setAdminAuth(value, actingAs);
    _webSocketManager.sendMessage(message);
  }

  /// Subscribes to a query function.
  ///
  /// Whenever this query's result changes, [onTransition] handlers are called.
  ///
  /// [name] is the name of the query. [args] are the query arguments; if
  /// omitted, the arguments default to `{}`.
  ({QueryToken queryToken, void Function() unsubscribe}) subscribe(
    String name, [
    Map<String, Object?>? args,
    SubscribeOptions options = const SubscribeOptions(),
  ]) {
    final argsObject = parseArgs(args);
    final result = _state.subscribe(
      name,
      argsObject,
      options.journal,
      options.componentPath,
    );
    final modification = result.modification;
    if (modification != null) _webSocketManager.sendMessage(modification);
    return (
      queryToken: result.queryToken,
      unsubscribe: () {
        final modification = result.unsubscribe();
        if (modification != null) _webSocketManager.sendMessage(modification);
      },
    );
  }

  /// Returns a query result based only on current local state.
  ///
  /// Returns a value only if the client is already subscribed to the query or
  /// its value has been set optimistically.
  Object? localQueryResult(String udfPath, [Map<String, Object?>? args]) {
    final queryToken = serializePathAndArgs(udfPath, parseArgs(args));
    return _optimisticQueryResults.queryResult(queryToken);
  }

  /// Returns a query result by [queryToken] from current local state.
  Object? localQueryResultByToken(QueryToken queryToken) =>
      _optimisticQueryResults.queryResult(queryToken);

  /// Whether a local query result is available for [queryToken].
  ///
  /// This method does not throw if the result is an error.
  bool hasLocalQueryResultByToken(QueryToken queryToken) =>
      _optimisticQueryResults.hasQueryResult(queryToken);

  /// Returns log lines forwarded from the server for a query, if available.
  List<String>? localQueryLogs(String udfPath, [Map<String, Object?>? args]) {
    final queryToken = serializePathAndArgs(udfPath, parseArgs(args));
    return _optimisticQueryResults.queryLogs(queryToken);
  }

  /// Returns the current [QueryJournal] for a query, if a result has been
  /// received.
  QueryJournal queryJournal(String name, [Map<String, Object?>? args]) =>
      _state.queryJournal(serializePathAndArgs(name, parseArgs(args)));

  /// Returns the current [ConnectionState] with the Convex backend.
  ConnectionState connectionState() {
    final wsState = _webSocketManager.connectionState();
    return ConnectionState(
      hasInflightRequests: _requestManager.hasInflightRequests(),
      isWebSocketConnected: wsState['isConnected']! as bool,
      hasEverConnected: wsState['hasEverConnected']! as bool,
      connectionCount: wsState['connectionCount']! as int,
      connectionRetries: wsState['connectionRetries']! as int,
      timeOfOldestInflightRequest: _requestManager
          .timeOfOldestInflightRequest(),
      inflightMutations: _requestManager.inflightMutations(),
      inflightActions: _requestManager.inflightActions(),
    );
  }

  void markConnectionStateDirty() {
    scheduleMicrotask(() {
      final current = connectionState();
      if (_lastPublishedConnectionState?.toJsonLike().toString() !=
          current.toJsonLike().toString()) {
        _lastPublishedConnectionState = current;
        for (final cb in _connectionStateSubscribers.values) {
          cb(current);
        }
      }
    });
  }

  /// Subscribes to [ConnectionState] changes.
  void Function() subscribeToConnectionState(
    void Function(ConnectionState) cb,
  ) {
    final id = _nextConnectionStateSubscriberId++;
    _connectionStateSubscribers[id] = cb;
    return () => _connectionStateSubscribers.remove(id);
  }

  /// Executes a mutation function.
  ///
  /// [name] is the name of the mutation. [args] are the mutation arguments; if
  /// omitted, the arguments default to `{}`.
  Future<Object?> mutation(
    String name, [
    Map<String, Object?>? args,
    MutationOptions options = const MutationOptions(),
  ]) async {
    final result = await _mutationInternal(name, args, options);
    if (result['success'] != true) {
      if (result.containsKey('errorData')) {
        throw ConvexError<Object?>(
          result['errorData'],
          message: result['errorMessage'] as String?,
        );
      }
      throw StateError(result['errorMessage']! as String);
    }
    return result['value'];
  }

  Future<FunctionResult> _mutationInternal(
    String udfPath, [
    Map<String, Object?>? args,
    MutationOptions options = const MutationOptions(),
    String? componentPath,
  ]) => enqueueMutation(udfPath, args, options, componentPath).mutationPromise;

  ({int requestId, Future<FunctionResult> mutationPromise}) enqueueMutation(
    String udfPath, [
    Map<String, Object?>? args,
    MutationOptions options = const MutationOptions(),
    String? componentPath,
  ]) {
    final mutationArgs = parseArgs(args);
    final requestId = _nextRequestId++;
    final optimisticUpdate = options.optimisticUpdate;
    if (optimisticUpdate != null) {
      final changedTokens = _optimisticQueryResults.applyOptimisticUpdate(
        optimisticUpdate,
        requestId,
        mutationArgs,
      );
      _handleTransition(
        Transition(
          queries: [
            for (final token in changedTokens)
              (
                token: token,
                modification: {
                  'kind': 'Updated',
                  'result': _optimisticQueryResults.rawQueryResult(token),
                },
              ),
          ],
          reflectedMutations: const [],
          timestamp: _remoteQuerySet.timestamp(),
        ),
      );
    }
    final message = <String, Object?>{
      'type': 'Mutation',
      'requestId': requestId,
      'udfPath': udfPath,
      'args': [convexToJson(mutationArgs)],
    };
    if (componentPath != null) {
      message['componentPath'] = componentPath;
    }
    final mightBeSent = _webSocketManager.sendMessage(message);
    return (
      requestId: requestId,
      mutationPromise: _requestManager.request(message, mightBeSent),
    );
  }

  /// Executes an action function.
  ///
  /// [name] is the name of the action. [args] are the action arguments; if
  /// omitted, the arguments default to `{}`.
  Future<Object?> action(String name, [Map<String, Object?>? args]) async {
    final result = await _actionInternal(name, args);
    if (result['success'] != true) {
      if (result.containsKey('errorData')) {
        throw ConvexError<Object?>(
          result['errorData'],
          message: result['errorMessage'] as String?,
        );
      }
      throw StateError(result['errorMessage']! as String);
    }
    return result['value'];
  }

  Future<FunctionResult> _actionInternal(
    String udfPath, [
    Map<String, Object?>? args,
    String? componentPath,
  ]) {
    final actionArgs = parseArgs(args);
    final requestId = _nextRequestId++;
    final message = <String, Object?>{
      'type': 'Action',
      'requestId': requestId,
      'udfPath': udfPath,
      'args': [convexToJson(actionArgs)],
    };
    if (componentPath != null) {
      message['componentPath'] = componentPath;
    }
    final mightBeSent = _webSocketManager.sendMessage(message);
    return _requestManager.request(message, mightBeSent);
  }

  /// Closes the WebSocket connection and stops the client.
  Future<void> close() {
    _authenticationManager.stop();
    return _webSocketManager.terminate();
  }

  /// The canonical deployment URL for this client.
  String get url => _address;
  int get nextRequestId => _nextRequestId;
  String get sessionId => _sessionId;

  OnMessageResponse _handleServerMessage(ServerMessage serverMessage) {
    switch (serverMessage['type']) {
      case 'Transition':
        _observedTimestamp(
          ((serverMessage['endVersion'] as Map).cast<String, Object?>())['ts']!
              as BigInt,
        );
        _authenticationManager.onTransition(serverMessage);
        _remoteQuerySet.transition(serverMessage);
        _state.transition(serverMessage);
        final completedRequests = _requestManager.removeCompleted(
          _remoteQuerySet.timestamp(),
        );
        _notifyOnQueryResultChanges(completedRequests);
        break;
      case 'MutationResponse':
        if (serverMessage['success'] == true) {
          _observedTimestamp(serverMessage['ts']! as BigInt);
        }
        final completed = _requestManager.onResponse(serverMessage);
        if (completed != null) {
          _notifyOnQueryResultChanges({completed.requestId: completed.result});
        }
        break;
      case 'ActionResponse':
        _requestManager.onResponse(serverMessage);
        break;
      case 'AuthError':
        _authenticationManager.onAuthError(serverMessage);
        break;
      case 'FatalError':
        final error = logFatalError(_logger, serverMessage['error']! as String);
        unawaited(_webSocketManager.terminate());
        throw error;
      default:
        throw StateError('Unknown server message ${serverMessage['type']}');
    }
    return {'hasSyncedPastLastReconnect': _hasSyncedPastLastReconnect()};
  }

  bool _hasSyncedPastLastReconnect() =>
      _requestManager.hasSyncedPastLastReconnect() &&
      _state.hasSyncedPastLastReconnect();

  void _observedTimestamp(BigInt ts) {
    if (_maxObservedTimestamp == null || _maxObservedTimestamp! <= ts) {
      _maxObservedTimestamp = ts;
    }
  }

  void _notifyOnQueryResultChanges(Map<int, FunctionResult> completedRequests) {
    final queryTokenToValue = <QueryToken, Query>{};
    for (final entry in _remoteQuerySet.remoteQueryResults().entries) {
      final queryToken = _state.queryToken(entry.key);
      if (queryToken != null) {
        queryTokenToValue[queryToken] = Query(
          result: entry.value,
          udfPath: _state.queryPath(entry.key)!,
          args: _state.queryArgs(entry.key)!,
        );
      }
    }
    final changedTokens = _optimisticQueryResults.ingestQueryResultsFromServer(
      queryTokenToValue,
      completedRequests.keys.toSet(),
    );
    _handleTransition(
      Transition(
        queries: [
          for (final token in changedTokens)
            (
              token: token,
              modification: {
                'kind': 'Updated',
                'result': _optimisticQueryResults.rawQueryResult(token),
              },
            ),
        ],
        reflectedMutations: [
          for (final entry in completedRequests.entries)
            (requestId: entry.key, result: entry.value),
        ],
        timestamp: _remoteQuerySet.timestamp(),
      ),
    );
  }

  void _handleTransition(Transition transition) {
    for (final fn in _onTransitionFns.values) {
      fn(transition);
    }
  }

  static String _wsUri(String address) {
    final uri = Uri.parse(address);
    final protocol = uri.scheme == 'http'
        ? 'ws'
        : uri.scheme == 'https'
        ? 'wss'
        : throw ArgumentError('Unknown parent protocol ${uri.scheme}');
    return uri.replace(scheme: protocol, path: '/api/1.41.0/sync').toString();
  }
}

String _normalizeJwtPart(String value) {
  final padding = value.length % 4;
  if (padding == 0) {
    return value;
  }
  return value.padRight(value.length + 4 - padding, '=');
}
