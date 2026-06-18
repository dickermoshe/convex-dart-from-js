import 'package:convex_dart/src/browser.dart';
import 'package:test/test.dart';

import 'support/fake_socket.dart';
import 'support/transition_fixtures.dart';

void main() {
  group('ConvexClient', () {
    test('onUpdate notifies listeners on transition', () {
      late FakeSocket socket;
      var callbacks = 0;
      final client = ConvexClient(
        'https://x.convex.cloud',
        options: ConvexClientOptions(
          webSocketFactory: (_) => socket = FakeSocket(),
        ),
      );
      final handle = client.onUpdate<Object?>(
        'messages:list',
        {},
        () => callbacks++,
      );
      socket.open();
      socket.message(
        transitionJson(
          startQuerySet: 0,
          endQuerySet: 1,
          modifications: [queryUpdated(queryId: 0, value: 1)],
        ),
      );
      expect(callbacks, greaterThan(0));
      expect(handle.getCurrentValue(), 1);
      handle.unsubscribe();
      client.close();
    });

    test('multiple listeners on same query all fire', () {
      late FakeSocket socket;
      var a = 0;
      var b = 0;
      final client = ConvexClient(
        'https://x.convex.cloud',
        options: ConvexClientOptions(
          webSocketFactory: (_) => socket = FakeSocket(),
        ),
      );
      client.onUpdate<Object?>('messages:list', {}, () => a++);
      client.onUpdate<Object?>('messages:list', {}, () => b++);
      socket.open();
      socket.message(
        transitionJson(
          startQuerySet: 0,
          endQuerySet: 1,
          modifications: [queryUpdated(queryId: 0, value: 'x')],
        ),
      );
      expect(a, greaterThan(0));
      expect(b, greaterThan(0));
    });

    test('delegates mutation and connectionState', () async {
      late FakeSocket socket;
      final client = ConvexClient(
        'https://x.convex.cloud',
        options: ConvexClientOptions(
          webSocketFactory: (_) => socket = FakeSocket(),
        ),
      );
      socket.open();
      socket.message(
        transitionJson(startQuerySet: 0, endQuerySet: 1, modifications: []),
      );
      final mutation = client.rawMutation('send', {});
      final msg = sentMessage(socket.sent, socket.sent.length - 1);
      socket.message(
        mutationResponseJson(
          requestId: msg['requestId']! as int,
          success: true,
          result: null,
        ),
      );
      socket.message(
        transitionJson(
          startQuerySet: 1,
          endQuerySet: 1,
          startTs: 'AAAAAAAAAAA=',
          endTs: 'AQAAAAAAAAA=',
          modifications: [],
        ),
      );
      expect(await mutation, isNull);
      expect(client.connectionState().isWebSocketConnected, isTrue);
      await client.close();
      expect(client.closed, isTrue);
    });

    test('clearAuth delegates to base client', () {
      late FakeSocket socket;
      final client = ConvexClient(
        'https://x.convex.cloud',
        options: ConvexClientOptions(
          webSocketFactory: (_) => socket = FakeSocket(),
        ),
      );
      socket.open();
      client.clearAuth();
      expect(client.client.hasAuth(), isFalse);
    });
  });
}
