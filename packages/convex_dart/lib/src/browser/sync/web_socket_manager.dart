import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:web_socket_channel/web_socket_channel.dart';

import '../logging.dart';
import 'protocol.dart';

typedef ReconnectMetadata = Map<String, Object?>;
typedef OnMessageResponse = Map<String, Object?>;
typedef SyncWebSocketFactory = SyncWebSocket Function(String uri);

const closeNormal = 1000;
const closeGoingAway = 1001;
const closeNoStatus = 1005;
const closeNotFound = 4040;

abstract interface class SyncWebSocket {
  void Function()? onOpen;
  void Function(Object? data)? onMessage;
  void Function(Object error)? onError;
  void Function(int code, String reason)? onClose;
  void send(String message);
  void close();
}

class ChannelSyncWebSocket implements SyncWebSocket {
  ChannelSyncWebSocket(String uri) {
    _channel = WebSocketChannel.connect(Uri.parse(uri));
    _subscription = _channel.stream.listen(
      (data) => onMessage?.call(data),
      onError: (Object error) => onError?.call(error),
      onDone: () => onClose?.call(
        _channel.closeCode ?? closeNoStatus,
        _channel.closeReason ?? '',
      ),
    );
    unawaited(_channel.ready.then((_) => onOpen?.call()));
  }

  late final WebSocketChannel _channel;
  late final StreamSubscription<dynamic> _subscription;

  @override
  void Function(int code, String reason)? onClose;
  @override
  void Function(Object error)? onError;
  @override
  void Function(Object? data)? onMessage;
  @override
  void Function()? onOpen;

  @override
  void close() {
    unawaited(_subscription.cancel());
    unawaited(_channel.sink.close());
  }

  @override
  void send(String message) {
    _channel.sink.add(message);
  }
}

class WebSocketManager {
  WebSocketManager(
    this.uri, {
    required this.onOpen,
    required this.onResume,
    required this.onMessage,
    required this.webSocketFactory,
    required this.logger,
    required this.markConnectionStateDirty,
    required this.debug,
    this.onServerDisconnectError,
    this.initialBackoff = 1000,
    this.maxBackoff = 16000,
    this.serverInactivityThreshold = const Duration(seconds: 60),
  }) {
    _connect();
  }

  final String uri;
  final void Function(ReconnectMetadata reconnectMetadata) onOpen;
  final void Function() onResume;
  final OnMessageResponse Function(ServerMessage message) onMessage;
  final void Function(String message)? onServerDisconnectError;
  final SyncWebSocketFactory webSocketFactory;
  final Logger logger;
  final void Function() markConnectionStateDirty;
  final bool debug;
  final int initialBackoff;
  final int maxBackoff;
  final Duration serverInactivityThreshold;
  final _random = Random();

  _SocketState _socket = const _SocketState('disconnected');
  int _connectionCount = 0;
  bool _hasEverConnected = false;
  String? _lastCloseReason = 'InitialConnect';
  int _retries = 0;
  Timer? _serverInactivityTimer;
  Timer? _scheduledReconnect;
  _TransitionChunkBuffer? _transitionChunkBuffer;

  String socketState() => _socket.state;

  bool sendMessage(ClientMessage message) {
    if (_socket.state == 'ready' && _socket.paused == 'no') {
      try {
        _socket.ws!.send(encodeClientMessageToJson(message));
      } catch (error) {
        logger.log([
          'Failed to send message on WebSocket, reconnecting: $error',
        ]);
        _closeAndReconnect('FailedToSendMessage');
      }
      return true;
    }
    return false;
  }

  Future<void> terminate() async {
    _serverInactivityTimer?.cancel();
    _scheduledReconnect?.cancel();
    final ws = _socket.ws;
    _setSocketState(const _SocketState('terminated'));
    ws?.close();
  }

  Future<void> stop() async {
    if (_socket.state == 'terminated') return;
    final ws = _socket.ws;
    _setSocketState(const _SocketState('stopped'));
    ws?.close();
  }

  void tryRestart() {
    if (_socket.state != 'stopped') {
      logger.logVerbose('Restart called without stopping first');
      return;
    }
    _connect();
  }

  void pause() {
    if (_socket.state == 'connecting' || _socket.state == 'ready') {
      _setSocketState(_socket.copyWith(paused: 'yes'));
    }
  }

  void resume() {
    switch (_socket.state) {
      case 'connecting':
        _setSocketState(_socket.copyWith(paused: 'no'));
        return;
      case 'ready':
        if (_socket.paused == 'uninitialized') {
          _setSocketState(_socket.copyWith(paused: 'no'));
          _hasEverConnected = true;
          onOpen(_reconnectMetadata());
        } else if (_socket.paused == 'yes') {
          _setSocketState(_socket.copyWith(paused: 'no'));
          onResume();
        }
        return;
      case 'disconnected':
        _connect();
        return;
    }
  }

  void tryReconnectImmediately() {
    if (_socket.state != 'disconnected') return;
    _scheduledReconnect?.cancel();
    _scheduledReconnect = null;
    _connect();
  }

  Map<String, Object?> connectionState() => {
    'isConnected': _socket.state == 'ready',
    'hasEverConnected': _hasEverConnected,
    'connectionCount': _connectionCount,
    'connectionRetries': _retries,
  };

  void _connect() {
    if (_socket.state == 'terminated') return;
    if (_socket.state != 'disconnected' && _socket.state != 'stopped') {
      throw StateError(
        "Didn't start connection from disconnected state: ${_socket.state}",
      );
    }
    final ws = webSocketFactory(uri);
    _setSocketState(_SocketState('connecting', ws: ws, paused: 'no'));
    _resetServerInactivityTimeout();

    ws.onOpen = () {
      if (_socket.state != 'connecting') {
        throw StateError('onopen called with socket not in connecting state');
      }
      _setSocketState(
        _SocketState(
          'ready',
          ws: ws,
          paused: _socket.paused == 'yes' ? 'uninitialized' : 'no',
        ),
      );
      _resetServerInactivityTimeout();
      if (_socket.paused == 'no') {
        _hasEverConnected = true;
        onOpen(_reconnectMetadata());
      }
      _connectionCount += 1;
      _lastCloseReason = null;
    };
    ws.onError = (error) {
      _transitionChunkBuffer = null;
      logger.log(['WebSocket error message: $error']);
    };
    ws.onMessage = (data) {
      _resetServerInactivityTimeout();
      var serverMessage = decodeServerMessage(data);
      if (serverMessage['type'] == 'Ping') return;
      if (serverMessage['type'] == 'TransitionChunk') {
        final transition = _assembleTransition(serverMessage);
        if (transition == null) return;
        serverMessage = transition;
      }
      if (_transitionChunkBuffer != null) {
        _transitionChunkBuffer = null;
        logger.log([
          'Received unexpected ${serverMessage['type']} while buffering TransitionChunks',
        ]);
      }
      final response = onMessage(serverMessage);
      if (response['hasSyncedPastLastReconnect'] == true) {
        _retries = 0;
        markConnectionStateDirty();
      }
    };
    ws.onClose = (code, reason) {
      _transitionChunkBuffer = null;
      if (_socket.state == 'terminated' || _socket.state == 'stopped') return;
      _lastCloseReason ??= reason.isEmpty ? 'closed with code $code' : reason;
      if (code != closeNormal &&
          code != closeGoingAway &&
          code != closeNoStatus &&
          code != closeNotFound) {
        var msg = 'WebSocket closed with code $code';
        if (reason.isNotEmpty) msg += ': $reason';
        logger.log([msg]);
        if (onServerDisconnectError != null && reason.isNotEmpty) {
          onServerDisconnectError!(msg);
        }
      }
      _scheduleReconnect(_classifyDisconnectError(reason));
    };
  }

  ServerMessage? _assembleTransition(WireServerMessage chunk) {
    final partNumber = chunk['partNumber']! as int;
    final totalParts = chunk['totalParts']! as int;
    final transitionId = chunk['transitionId']! as String;
    if (partNumber < 0 ||
        partNumber >= totalParts ||
        totalParts == 0 ||
        (_transitionChunkBuffer != null &&
            (_transitionChunkBuffer!.totalParts != totalParts ||
                _transitionChunkBuffer!.transitionId != transitionId))) {
      _transitionChunkBuffer = null;
      throw StateError('Invalid TransitionChunk');
    }
    _transitionChunkBuffer ??= _TransitionChunkBuffer(totalParts, transitionId);
    if (partNumber != _transitionChunkBuffer!.chunks.length) {
      final expected = _transitionChunkBuffer!.chunks.length;
      _transitionChunkBuffer = null;
      throw StateError(
        'TransitionChunk received out of order: expected part $expected, got $partNumber',
      );
    }
    _transitionChunkBuffer!.chunks.add(chunk['chunk']! as String);
    if (_transitionChunkBuffer!.chunks.length == totalParts) {
      final fullJson = _transitionChunkBuffer!.chunks.join();
      _transitionChunkBuffer = null;
      final transition = parseServerMessage(jsonDecode(fullJson) as Object);
      if (transition['type'] != 'Transition') {
        throw StateError(
          'Expected Transition, got ${transition['type']} after assembling chunks',
        );
      }
      return transition;
    }
    return null;
  }

  void _resetServerInactivityTimeout() {
    if (_socket.state == 'terminated') return;
    _serverInactivityTimer?.cancel();
    _serverInactivityTimer = Timer(serverInactivityThreshold, () {
      _closeAndReconnect('InactiveServer');
    });
  }

  void _closeAndReconnect(String closeReason) {
    switch (_socket.state) {
      case 'connecting':
      case 'ready':
        _lastCloseReason = closeReason;
        _socket.ws?.close();
        _scheduleReconnect('client');
        return;
    }
  }

  void _scheduleReconnect(String reason) {
    _scheduledReconnect?.cancel();
    _setSocketState(const _SocketState('disconnected'));
    final backoff = _nextBackoff(reason);
    logger.log(['Attempting reconnect in ${backoff.round()}ms']);
    _scheduledReconnect = Timer(Duration(milliseconds: backoff), () {
      _scheduledReconnect = null;
      _connect();
    });
  }

  int _nextBackoff(String reason) {
    final start = reason == 'client'
        ? 100
        : reason == 'Unknown'
        ? initialBackoff
        : 3000;
    final base = start * (1 << _retries);
    _retries += 1;
    final actual = min(base, maxBackoff);
    final jitter = actual * (_random.nextDouble() - 0.5);
    return max(0, actual + jitter).round();
  }

  ReconnectMetadata _reconnectMetadata() => {
    'connectionCount': _connectionCount,
    'lastCloseReason': _lastCloseReason,
    'clientTs': DateTime.now().millisecondsSinceEpoch,
  };

  String _classifyDisconnectError(String reason) {
    if (reason.isEmpty) return 'Unknown';
    for (final prefix in const [
      'InternalServerError',
      'SubscriptionsWorkerFullError',
      'TooManyConcurrentRequests',
      'CommitterFullError',
      'AwsTooManyRequestsException',
      'ExecuteFullError',
      'SystemTimeoutError',
      'ExpiredInQueue',
      'VectorIndexesUnavailable',
      'SearchIndexesUnavailable',
      'TableSummariesUnavailable',
      'VectorIndexTooLarge',
      'SearchIndexTooLarge',
      'TooManyWritesInTimePeriod',
    ]) {
      if (reason.startsWith(prefix)) return prefix;
    }
    return 'Unknown';
  }

  void _setSocketState(_SocketState state) {
    _socket = state;
    markConnectionStateDirty();
  }
}

class _SocketState {
  const _SocketState(this.state, {this.ws, this.paused});
  final String state;
  final SyncWebSocket? ws;
  final String? paused;

  _SocketState copyWith({String? paused}) =>
      _SocketState(state, ws: ws, paused: paused ?? this.paused);
}

class _TransitionChunkBuffer {
  _TransitionChunkBuffer(this.totalParts, this.transitionId);
  final List<String> chunks = [];
  final int totalParts;
  final String transitionId;
}
