import 'dart:convert';

import 'package:convex_dart/src/browser/logging.dart';
import 'package:convex_dart/src/browser/sync/web_socket_manager.dart';
import 'package:test/test.dart';

import 'support/fake_socket.dart';
import 'support/transition_fixtures.dart';

void main() {
  group('WebSocketManager', () {
    test('connects, sends encoded messages, and reports connection state', () {
      late FakeSocket socket;
      final manager = WebSocketManager(
        'wss://example.com/api/1.41.0/sync',
        onOpen: (_) {},
        onResume: () {},
        onMessage: (_) => {'hasSyncedPastLastReconnect': true},
        webSocketFactory: (_) => socket = FakeSocket(),
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
        'event': <dynamic, dynamic>{},
      });
    });

    test('ignores pings and assembles transition chunks', () {
      final messages = <Map<String, Object?>>[];
      late FakeSocket socket;
      WebSocketManager(
        'wss://example.com/api/1.41.0/sync',
        onOpen: (_) {},
        onResume: () {},
        onMessage: (message) {
          messages.add(message);
          return {'hasSyncedPastLastReconnect': true};
        },
        webSocketFactory: (_) => socket = FakeSocket(),
        logger: const NoopLogger(),
        markConnectionStateDirty: () {},
        debug: false,
        serverInactivityThreshold: const Duration(minutes: 5),
      );
      socket.open();
      socket.message(jsonEncode({'type': 'Ping'}));
      expect(messages, isEmpty);

      final transition = transitionJson(
        startQuerySet: 0,
        endQuerySet: 0,
        modifications: [],
      );
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
      late FakeSocket socket;
      final manager = WebSocketManager(
        'wss://example.com/api/1.41.0/sync',
        onOpen: (_) => opens++,
        onResume: () {},
        onMessage: (_) => {'hasSyncedPastLastReconnect': true},
        webSocketFactory: (_) => socket = FakeSocket(),
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

    test('stop and tryRestart reconnect', () async {
      var opens = 0;
      late FakeSocket socket;
      final manager = WebSocketManager(
        'wss://example.com/api/1.41.0/sync',
        onOpen: (_) => opens++,
        onResume: () {},
        onMessage: (_) => {'hasSyncedPastLastReconnect': true},
        webSocketFactory: (_) => socket = FakeSocket(),
        logger: const NoopLogger(),
        markConnectionStateDirty: () {},
        debug: false,
        serverInactivityThreshold: const Duration(minutes: 5),
      );
      socket.open();
      expect(opens, 1);
      await manager.stop();
      expect(manager.socketState(), 'stopped');
      manager.tryRestart();
      expect(manager.socketState(), 'connecting');
      socket.open();
      expect(opens, 2);
    });

    test('terminate prevents further reconnects', () async {
      late FakeSocket socket;
      final manager = WebSocketManager(
        'wss://example.com/api/1.41.0/sync',
        onOpen: (_) {},
        onResume: () {},
        onMessage: (_) => {'hasSyncedPastLastReconnect': true},
        webSocketFactory: (_) => socket = FakeSocket(),
        logger: const NoopLogger(),
        markConnectionStateDirty: () {},
        debug: false,
        serverInactivityThreshold: const Duration(minutes: 5),
      );
      socket.open();
      await manager.terminate();
      expect(manager.socketState(), 'terminated');
      socket.closeWith();
      expect(manager.socketState(), 'terminated');
    });

    test('invalid transition chunk throws', () {
      late FakeSocket socket;
      WebSocketManager(
        'wss://example.com/api/1.41.0/sync',
        onOpen: (_) {},
        onResume: () {},
        onMessage: (_) => {'hasSyncedPastLastReconnect': true},
        webSocketFactory: (_) => socket = FakeSocket(),
        logger: const NoopLogger(),
        markConnectionStateDirty: () {},
        debug: false,
        serverInactivityThreshold: const Duration(minutes: 5),
      );
      socket.open();
      expect(
        () => socket.message(
          jsonEncode({
            'type': 'TransitionChunk',
            'chunk': '{}',
            'partNumber': 1,
            'totalParts': 2,
            'transitionId': 't',
          }),
        ),
        throwsStateError,
      );
    });
  });
}
