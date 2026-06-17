import 'dart:async';

import 'package:web_socket_channel/web_socket_channel.dart';

import '../common/args.dart';
import '../common/deployment_url.dart';
import '../values/errors.dart';
import '../values/value.dart';
import 'sync/protocol.dart';
import 'sync/udf_path_utils.dart';

typedef QueryCallback = void Function(Object? result);
typedef QueryErrorCallback = void Function(Object error);
typedef AuthTokenFetcher = FutureOr<String?> Function();
typedef WebSocketConnector = WebSocketChannel Function(Uri uri);

class ConvexClientOptions {
  const ConvexClientOptions({
    this.skipConvexDeploymentUrlCheck = false,
    this.disabled = false,
    this.webSocketConnector,
  });

  final bool skipConvexDeploymentUrlCheck;
  final bool disabled;
  final WebSocketConnector? webSocketConnector;
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
}

class Unsubscribe<T> {
  Unsubscribe(this._unsubscribe, this._currentValue, this._queryLogs);

  final void Function() _unsubscribe;
  final T? Function() _currentValue;
  final List<String>? Function() _queryLogs;

  void call() => _unsubscribe();
  void unsubscribe() => _unsubscribe();
  T? getCurrentValue() => _currentValue();
  List<String>? getQueryLogs() => _queryLogs();
}

class _QuerySubscription {
  _QuerySubscription({
    required this.queryId,
    required this.token,
    required this.name,
    required this.args,
  });

  final int queryId;
  final QueryToken token;
  final String name;
  final Map<String, Object?> args;
  int refs = 0;
  Object? value;
  Object? error;
  List<String>? logs;
  QueryJournal journal;
  final listeners = <_Listener>{};
}

class _Listener {
  _Listener(this.callback, this.onError);

  final QueryCallback callback;
  final QueryErrorCallback? onError;
}

class _Request {
  _Request(this.completer, this.kind, this.startedAt);

  final Completer<Object?> completer;
  final String kind;
  final DateTime startedAt;
}

/// Basic WebSocket Convex client for Dart applications.
class ConvexClient {
  ConvexClient(
    String address, [
    ConvexClientOptions options = const ConvexClientOptions(),
  ]) : _address = address,
       _disabled = options.disabled,
       _connector = options.webSocketConnector ?? WebSocketChannel.connect {
    if (!options.skipConvexDeploymentUrlCheck) validateDeploymentUrl(address);
    if (!_disabled) _connect();
  }

  final String _address;
  final bool _disabled;
  final WebSocketConnector _connector;
  final _subscriptionsByToken = <QueryToken, _QuerySubscription>{};
  final _subscriptionsById = <int, _QuerySubscription>{};
  final _requests = <int, _Request>{};
  final _connectionSubscribers = <int, void Function(ConnectionState)>{};
  var _nextQueryId = 0;
  var _querySetVersion = 0;
  var _nextRequestId = 0;
  var _nextConnectionSubscriberId = 0;
  var _identityVersion = 0;
  var _closed = false;
  var _isConnected = false;
  var _hasEverConnected = false;
  var _connectionCount = 0;
  var _connectionRetries = 0;
  WebSocketChannel? _channel;
  StreamSubscription<Object?>? _socketSubscription;
  String? _authToken;
  AuthTokenFetcher? _authFetcher;

  String get url => _address;
  bool get closed => _closed;
  bool get disabled => _disabled;

  Unsubscribe<T> onUpdate<T>(
    String query,
    Map<String, Object?> args,
    void Function(T result) callback, {
    QueryErrorCallback? onError,
  }) {
    if (_disabled) {
      return Unsubscribe<T>(() {}, () => null, () => null);
    }
    final parsedArgs = parseArgs(args);
    final token = serializePathAndArgs(query, parsedArgs);
    final subscription = _subscriptionsByToken.putIfAbsent(token, () {
      final created = _QuerySubscription(
        queryId: _nextQueryId++,
        token: token,
        name: canonicalizeUdfPath(query),
        args: parsedArgs,
      );
      _subscriptionsById[created.queryId] = created;
      _sendQueryModification([
        {
          'type': 'Add',
          'queryId': created.queryId,
          'udfPath': created.name,
          'args': [convexToJson(created.args)],
          if (created.journal != null) 'journal': created.journal,
        },
      ]);
      return created;
    });
    subscription.refs++;
    final listener = _Listener((value) => callback(value as T), onError);
    subscription.listeners.add(listener);
    if (subscription.error != null) {
      if (onError != null) {
        scheduleMicrotask(() => onError(subscription.error!));
      }
    } else if (subscription.value != null) {
      scheduleMicrotask(() => callback(subscription.value as T));
    }
    return Unsubscribe<T>(
      () {
        if (_closed) return;
        subscription.listeners.remove(listener);
        subscription.refs--;
        if (subscription.refs <= 0) {
          _subscriptionsByToken.remove(token);
          _subscriptionsById.remove(subscription.queryId);
          _sendQueryModification([
            {'type': 'Remove', 'queryId': subscription.queryId},
          ]);
        }
      },
      () => subscription.value as T?,
      () => subscription.logs,
    );
  }

  Future<Object?> query(String name, [Map<String, Object?>? args]) {
    final parsedArgs = parseArgs(args);
    final token = serializePathAndArgs(name, parsedArgs);
    final existing = _subscriptionsByToken[token];
    if (existing != null && existing.value != null) {
      return Future.value(existing.value);
    }
    final completer = Completer<Object?>();
    late Unsubscribe<Object?> unsubscribe;
    unsubscribe = onUpdate<Object?>(
      name,
      parsedArgs,
      (value) {
        unsubscribe.unsubscribe();
        completer.complete(value);
      },
      onError: (error) {
        unsubscribe.unsubscribe();
        completer.completeError(error);
      },
    );
    return completer.future;
  }

  Future<Object?> mutation(String name, [Map<String, Object?>? args]) =>
      _request('Mutation', name, parseArgs(args));

  Future<Object?> action(String name, [Map<String, Object?>? args]) =>
      _request('Action', name, parseArgs(args));

  Future<Object?> _request(
    String type,
    String name,
    Map<String, Object?> args,
  ) {
    if (_disabled) throw StateError('ConvexClient is disabled');
    final requestId = _nextRequestId++;
    final completer = Completer<Object?>();
    _requests[requestId] = _Request(completer, type, DateTime.now());
    _send({
      'type': type,
      'requestId': requestId,
      'udfPath': canonicalizeUdfPath(name),
      'args': [convexToJson(args)],
    });
    _publishConnectionState();
    return completer.future;
  }

  Future<void> setAuth(
    Object auth, {
    void Function(bool isAuthenticated)? onChange,
  }) async {
    if (auth is String) {
      _authFetcher = null;
      _authToken = auth;
    } else if (auth is AuthTokenFetcher) {
      _authFetcher = auth;
      _authToken = await auth();
    } else {
      throw ArgumentError('setAuth expects a token string or token fetcher');
    }
    onChange?.call(_authToken != null);
    _sendAuth();
  }

  void clearAuth() {
    _authFetcher = null;
    _authToken = null;
    _sendAuth();
  }

  ConnectionState connectionState() {
    final oldest = _requests.values
        .map((request) => request.startedAt)
        .fold<DateTime?>(
          null,
          (oldest, next) =>
              oldest == null || next.isBefore(oldest) ? next : oldest,
        );
    return ConnectionState(
      hasInflightRequests: _requests.isNotEmpty,
      isWebSocketConnected: _isConnected,
      timeOfOldestInflightRequest: oldest,
      hasEverConnected: _hasEverConnected,
      connectionCount: _connectionCount,
      connectionRetries: _connectionRetries,
      inflightMutations: _requests.values
          .where((r) => r.kind == 'Mutation')
          .length,
      inflightActions: _requests.values.where((r) => r.kind == 'Action').length,
    );
  }

  void Function() subscribeToConnectionState(
    void Function(ConnectionState) cb,
  ) {
    final id = _nextConnectionSubscriberId++;
    _connectionSubscribers[id] = cb;
    return () => _connectionSubscribers.remove(id);
  }

  Future<void> close() async {
    _closed = true;
    await _socketSubscription?.cancel();
    await _channel?.sink.close();
    _isConnected = false;
    _publishConnectionState();
  }

  void _connect() {
    if (_closed) return;
    _channel = _connector(_syncUri());
    _socketSubscription = _channel!.stream.listen(
      _handleSocketMessage,
      onError: (_) => _handleDisconnect(),
      onDone: _handleDisconnect,
    );
    _channel!.ready
        .then((_) {
          if (_closed) {
            return;
          }
          _isConnected = true;
          _hasEverConnected = true;
          _connectionCount++;
          _publishConnectionState();
          _send({
            'type': 'Connect',
            'sessionId': DateTime.now().microsecondsSinceEpoch.toString(),
            'connectionCount': _connectionCount,
            'lastCloseReason': null,
            'clientTs': DateTime.now().millisecondsSinceEpoch,
          });
          _sendAuth();
          _resubscribeAll();
        })
        .catchError((_) {
          _handleDisconnect();
        });
  }

  Uri _syncUri() {
    final uri = Uri.parse(_address);
    final scheme = uri.scheme == 'https' ? 'wss' : 'ws';
    return uri.replace(scheme: scheme, path: '/api/1.0.0/sync');
  }

  void _handleDisconnect() {
    if (_closed) return;
    _isConnected = false;
    _connectionRetries++;
    _publishConnectionState();
    Timer(const Duration(milliseconds: 250), _connect);
  }

  void _sendAuth() {
    if (_disabled || _closed) return;
    _send({
      'type': 'Authenticate',
      'tokenType': _authToken == null ? 'None' : 'User',
      if (_authToken != null) 'value': _authToken,
      'baseVersion': _identityVersion++,
    });
  }

  void _resubscribeAll() {
    if (_subscriptionsById.isEmpty) return;
    _sendQueryModification(
      _subscriptionsById.values
          .map(
            (sub) => {
              'type': 'Add',
              'queryId': sub.queryId,
              'udfPath': sub.name,
              'args': [convexToJson(sub.args)],
              if (sub.journal != null) 'journal': sub.journal,
            },
          )
          .toList(),
    );
  }

  void _sendQueryModification(List<Map<String, Object?>> modifications) {
    if (modifications.isEmpty || _disabled || _closed) return;
    _send({
      'type': 'ModifyQuerySet',
      'baseVersion': _querySetVersion,
      'newVersion': ++_querySetVersion,
      'modifications': modifications,
    });
  }

  void _send(Map<String, Object?> message) {
    final channel = _channel;
    if (channel == null || !_isConnected) return;
    channel.sink.add(encodeClientMessage(message));
  }

  void _handleSocketMessage(Object? data) {
    final message = decodeServerMessage(data);
    switch (message['type']) {
      case 'Transition':
        _handleTransition(message);
      case 'MutationResponse':
      case 'ActionResponse':
        _handleResponse(message);
      case 'AuthError':
        if (_authFetcher != null) {
          Future.sync(_authFetcher!).then((token) {
            _authToken = token;
            _sendAuth();
          });
        }
      case 'FatalError':
        throw Exception(message['error']);
      case 'Ping':
        break;
    }
  }

  void _handleTransition(Map<String, Object?> message) {
    final modifications = (message['modifications'] as List).cast<Map>();
    for (final rawModification in modifications) {
      final modification = rawModification.cast<String, Object?>();
      final queryId = modification['queryId'] as int?;
      final sub = queryId == null ? null : _subscriptionsById[queryId];
      if (sub == null) continue;
      switch (modification['type']) {
        case 'QueryUpdated':
          sub.value = jsonToConvex(modification['value']);
          sub.error = null;
          sub.logs = (modification['logLines'] as List?)?.cast<String>();
          sub.journal = modification['journal'] as String?;
          for (final listener in List<_Listener>.from(sub.listeners)) {
            listener.callback(sub.value);
          }
        case 'QueryFailed':
          final error = modification.containsKey('errorData')
              ? ConvexError<Object?>(
                  jsonToConvex(modification['errorData']),
                  modification['errorMessage']?.toString(),
                )
              : Exception(modification['errorMessage']);
          sub.error = error;
          sub.logs = (modification['logLines'] as List?)?.cast<String>();
          sub.journal = modification['journal'] as String?;
          for (final listener in List<_Listener>.from(sub.listeners)) {
            if (listener.onError != null) {
              listener.onError!(error);
            }
          }
        case 'QueryRemoved':
          sub.value = null;
      }
    }
  }

  void _handleResponse(Map<String, Object?> message) {
    final requestId = message['requestId'] as int;
    final request = _requests.remove(requestId);
    if (request == null) return;
    if (message['success'] == true) {
      request.completer.complete(jsonToConvex(message['result']));
    } else {
      final error = message.containsKey('errorData')
          ? ConvexError<Object?>(
              jsonToConvex(message['errorData']),
              message['result']?.toString(),
            )
          : Exception(message['result']);
      request.completer.completeError(error);
    }
    _publishConnectionState();
  }

  void _publishConnectionState() {
    final state = connectionState();
    for (final cb in _connectionSubscribers.values) {
      cb(state);
    }
  }
}
