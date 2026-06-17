import 'dart:convert';

import 'package:convex_dart_from_js/src/browser/logging.dart';
import 'package:convex_dart_from_js/src/browser/sync/web_socket_manager.dart';
import 'package:test/test.dart';

void main() {
  group('WebSocketManager', () {
    test('connects, sends encoded messages, and reports connection state', () {
      late _FakeSocket socket;
      final manager = WebSocketManager(
        'wss://example.com/api/1.41.0/sync',
        onOpen: (_) {},
        onResume: () {},
        onMessage: (_) => {'hasSyncedPastLastReconnect': true},
        webSocketFactory: (_) => socket = _FakeSocket(),
        logger: const NoopLogger(),
        markConnectionStateDirty: () {},
        debug: false,
        serverInactivityThreshold: const Duration(minutes: 5),
      );

      expect(manager.socketState(), 'connecting');
      socket.open();
      expect(manager.socketState(), 'ready');
      expect(manager.connectionState()['isConnected'], isTrue);

      expect(
        manager.sendMessage({'type': 'Event', 'eventType': 'x', 'event': {}}),
        isTrue,
      );
      expect(jsonDecode(socket.sent.single), {
        'type': 'Event',
        'eventType': 'x',
        'event': {},
      });
    });

    test('ignores pings and assembles transition chunks', () {
      final messages = <Map<String, Object?>>[];
      late _FakeSocket socket;
      WebSocketManager(
        'wss://example.com/api/1.41.0/sync',
        onOpen: (_) {},
        onResume: () {},
        onMessage: (message) {
          messages.add(message);
          return {'hasSyncedPastLastReconnect': true};
        },
        webSocketFactory: (_) => socket = _FakeSocket(),
        logger: const NoopLogger(),
        markConnectionStateDirty: () {},
        debug: false,
        serverInactivityThreshold: const Duration(minutes: 5),
      );
      socket.open();
      socket.message(jsonEncode({'type': 'Ping'}));
      expect(messages, isEmpty);

      final transition = jsonEncode({
        'type': 'Transition',
        'startVersion': {'querySet': 0, 'ts': 'AAAAAAAAAAA=', 'identity': 0},
        'endVersion': {'querySet': 0, 'ts': 'AAAAAAAAAAA=', 'identity': 0},
        'modifications': [],
      });
      final midpoint = transition.length ~/ 2;
      socket.message(
        jsonEncode({
          'type': 'TransitionChunk',
          'chunk': transition.substring(0, midpoint),
          'partNumber': 0,
          'totalParts': 2,
          'transitionId': 't',
        }),
      );
      socket.message(
        jsonEncode({
          'type': 'TransitionChunk',
          'chunk': transition.substring(midpoint),
          'partNumber': 1,
          'totalParts': 2,
          'transitionId': 't',
        }),
      );
      expect(messages.single['type'], 'Transition');
    });

    test('pause before open defers onOpen until resume', () {
      var opens = 0;
      late _FakeSocket socket;
      final manager = WebSocketManager(
        'wss://example.com/api/1.41.0/sync',
        onOpen: (_) => opens++,
        onResume: () {},
        onMessage: (_) => {'hasSyncedPastLastReconnect': true},
        webSocketFactory: (_) => socket = _FakeSocket(),
        logger: const NoopLogger(),
        markConnectionStateDirty: () {},
        debug: false,
        serverInactivityThreshold: const Duration(minutes: 5),
      );
      manager.pause();
      socket.open();
      expect(opens, 0);
      manager.resume();
      expect(opens, 1);
    });
  });
}

class _FakeSocket implements SyncWebSocket {
  final sent = <String>[];
  @override
  void Function(int code, String reason)? onClose;
  @override
  void Function(Object error)? onError;
  @override
  void Function(Object? data)? onMessage;
  @override
  void Function()? onOpen;

  void open() => onOpen?.call();
  void message(String data) => onMessage?.call(data);
  void closeWith([int code = closeNormal, String reason = '']) =>
      onClose?.call(code, reason);

  @override
  void close() {
    closeWith();
  }

  @override
  void send(String message) {
    sent.add(message);
  }
}
