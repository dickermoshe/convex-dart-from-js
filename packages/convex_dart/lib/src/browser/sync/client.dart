import 'dart:async';

import '../../common/index.dart';
import '../../values/errors.dart';
import '../../values/value.dart';
import '../logging.dart';
import 'authentication_manager.dart';
import 'function_result.dart';
import 'local_state.dart';
import 'optimistic_updates.dart';
import 'optimistic_updates_impl.dart';
import 'protocol.dart';
import 'remote_query_set.dart';
import 'request_manager.dart';
import 'session.dart';
import 'udf_path_utils.dart';
import 'web_socket_manager.dart';

class BaseConvexClientOptions {
  const BaseConvexClientOptions({
    this.webSocketFactory,
    this.verbose = false,
    this.logger,
    this.reportDebugInfoToConvex = false,
    this.skipConvexDeploymentUrlCheck = false,
    this.expectAuth = false,
  });

  final SyncWebSocketFactory? webSocketFactory;
  final bool verbose;
  final Logger? logger;
  final bool reportDebugInfoToConvex;
  final bool skipConvexDeploymentUrlCheck;
  final bool expectAuth;
}

class ConnectionState {
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

  final bool hasInflightRequests;
  final bool isWebSocketConnected;
  final DateTime? timeOfOldestInflightRequest;
  final bool hasEverConnected;
  final int connectionCount;
  final int connectionRetries;
  final int inflightMutations;
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

class SubscribeOptions {
  const SubscribeOptions({this.journal, this.componentPath});
  final QueryJournal journal;
  final String? componentPath;
}

class MutationOptions {
  const MutationOptions({this.optimisticUpdate});
  final OptimisticUpdate? optimisticUpdate;
}

class Transition {
  const Transition({
    required this.queries,
    required this.reflectedMutations,
    required this.timestamp,
  });

  final List<({QueryToken token, Map<String, Object?> modification})> queries;
  final List<({int requestId, FunctionResult result})> reflectedMutations;
  final BigInt timestamp;
}

class BaseConvexClient {
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

  BigInt? getMaxObservedTimestamp() => _maxObservedTimestamp;

  void Function() addOnTransitionHandler(void Function(Transition) fn) {
    final id = _transitionHandlerCounter++;
    _onTransitionFns[id] = fn;
    return () => _onTransitionFns.remove(id);
  }

  Future<void> setAuth(
    AuthTokenFetcher fetchToken,
    void Function(bool isAuthenticated) onChange, [
    void Function(bool isRefreshing)? onRefreshChange,
  ]) => _authenticationManager.setConfig(fetchToken, onChange, onRefreshChange);

  bool hasAuth() => _state.hasAuth();

  void clearAuth() {
    final message = _state.clearAuth();
    _webSocketManager.sendMessage(message);
  }

  void setAdminAuth(String value, [Map<String, Object?>? actingAs]) {
    final message = _state.setAdminAuth(value, actingAs);
    _webSocketManager.sendMessage(message);
  }

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

  Object? localQueryResult(String udfPath, [Map<String, Object?>? args]) {
    final queryToken = serializePathAndArgs(udfPath, parseArgs(args));
    return _optimisticQueryResults.queryResult(queryToken);
  }

  Object? localQueryResultByToken(QueryToken queryToken) =>
      _optimisticQueryResults.queryResult(queryToken);

  bool hasLocalQueryResultByToken(QueryToken queryToken) =>
      _optimisticQueryResults.hasQueryResult(queryToken);

  List<String>? localQueryLogs(String udfPath, [Map<String, Object?>? args]) {
    final queryToken = serializePathAndArgs(udfPath, parseArgs(args));
    return _optimisticQueryResults.queryLogs(queryToken);
  }

  QueryJournal queryJournal(String name, [Map<String, Object?>? args]) =>
      _state.queryJournal(serializePathAndArgs(name, parseArgs(args)));

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

  void Function() subscribeToConnectionState(
    void Function(ConnectionState) cb,
  ) {
    final id = _nextConnectionStateSubscriberId++;
    _connectionStateSubscribers[id] = cb;
    return () => _connectionStateSubscribers.remove(id);
  }

  Future<Object?> mutation(
    String name, [
    Map<String, Object?>? args,
    MutationOptions options = const MutationOptions(),
  ]) async {
    final result = await mutationInternal(name, args, options);
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

  Future<FunctionResult> mutationInternal(
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

  Future<Object?> action(String name, [Map<String, Object?>? args]) async {
    final result = await actionInternal(name, args);
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

  Future<FunctionResult> actionInternal(
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

  Future<void> close() {
    _authenticationManager.stop();
    return _webSocketManager.terminate();
  }

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
