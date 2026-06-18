import 'dart:convert';

import 'package:convex_dart/src/browser.dart';
import 'package:test/test.dart';

import 'support/fake_socket.dart';
import 'support/transition_fixtures.dart';

void main() {
  group('ConvexClient', () {
    test('onUpdate notifies listeners on transition', () {
      late FakeSocket socket;
      final values = <Object?>[];
      final client = ConvexClient(
        'https://x.convex.cloud',
        options: ConvexClientOptions(
          webSocketFactory: (_) => socket = FakeSocket(),
        ),
      );
      final handle = client.onUpdate<Object?>('messages:list', {}, values.add);
      socket.open();
      socket.message(
        transitionJson(
          startQuerySet: 0,
          endQuerySet: 1,
          modifications: [queryUpdated(queryId: 0, value: 1)],
        ),
      );
      expect(values, [1]);
      expect(handle.getCurrentValue(), 1);
      handle.unsubscribe();
      client.close();
    });

    test('multiple listeners on same query all fire', () {
      late FakeSocket socket;
      final a = <Object?>[];
      final b = <Object?>[];
      final client = ConvexClient(
        'https://x.convex.cloud',
        options: ConvexClientOptions(
          webSocketFactory: (_) => socket = FakeSocket(),
        ),
      );
      client.onUpdate<Object?>('messages:list', {}, a.add);
      client.onUpdate<Object?>('messages:list', {}, b.add);
      socket.open();
      socket.message(
        transitionJson(
          startQuerySet: 0,
          endQuerySet: 1,
          modifications: [queryUpdated(queryId: 0, value: 'x')],
        ),
      );
      expect(a, ['x']);
      expect(b, ['x']);
    });

    test('onUpdate reports query errors without blocking other listeners', () {
      late FakeSocket socket;
      Object? error;
      final values = <Object?>[];
      final client = ConvexClient(
        'https://x.convex.cloud',
        options: ConvexClientOptions(
          webSocketFactory: (_) => socket = FakeSocket(),
        ),
      );
      client.onUpdate<Object?>(
        'messages:list',
        {},
        values.add,
        onError: (e, _) => error = e,
      );
      client.onUpdate<Object?>('other:list', {}, values.add);
      socket.open();
      socket.message(
        transitionJson(
          startQuerySet: 0,
          endQuerySet: 2,
          modifications: [
            queryFailed(queryId: 0, errorMessage: 'bad'),
            queryUpdated(queryId: 1, value: 'ok'),
          ],
        ),
      );
      expect(error, isA<ConvexError<Object?>>());
      expect(values, ['ok']);
    });

    test('onUpdate calls new listener with cached value', () async {
      late FakeSocket socket;
      final firstValues = <Object?>[];
      final cachedValues = <Object?>[];
      final client = ConvexClient(
        'https://x.convex.cloud',
        options: ConvexClientOptions(
          webSocketFactory: (_) => socket = FakeSocket(),
        ),
      );
      client.onUpdate<Object?>('messages:list', {}, firstValues.add);
      socket.open();
      socket.message(
        transitionJson(
          startQuerySet: 0,
          endQuerySet: 1,
          modifications: [queryUpdated(queryId: 0, value: 'cached')],
        ),
      );
      client.onUpdate<Object?>('messages:list', {}, cachedValues.add);
      await Future<void>.delayed(Duration.zero);
      expect(firstValues, ['cached']);
      expect(cachedValues, ['cached']);
    });

    test('rawQuery waits for first uncached result and unsubscribes', () async {
      late FakeSocket socket;
      final client = ConvexClient(
        'https://x.convex.cloud',
        options: ConvexClientOptions(
          webSocketFactory: (_) => socket = FakeSocket(),
        ),
      );
      socket.open();
      final modifyCountBeforeQuery = sentMessageTypes(
        socket.sent,
      ).where((type) => type == 'ModifyQuerySet').length;
      final result = client.rawQuery('messages:list', {});
      expect(sentMessageTypes(socket.sent), contains('ModifyQuerySet'));
      socket.message(
        transitionJson(
          startQuerySet: 0,
          endQuerySet: 1,
          modifications: [queryUpdated(queryId: 0, value: 'first')],
        ),
      );
      expect(await result, 'first');
      expect(
        sentMessageTypes(socket.sent).where((type) => type == 'ModifyQuerySet'),
        hasLength(modifyCountBeforeQuery + 2),
      );
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

    test('close clears listeners and prevents later callbacks', () async {
      late FakeSocket socket;
      final values = <Object?>[];
      final client = ConvexClient(
        'https://x.convex.cloud',
        options: ConvexClientOptions(
          webSocketFactory: (_) => socket = FakeSocket(),
        ),
      );
      client.onUpdate<Object?>('messages:list', {}, values.add);
      socket.open();
      await client.close();
      socket.message(
        transitionJson(
          startQuerySet: 0,
          endQuerySet: 1,
          modifications: [queryUpdated(queryId: 0, value: 'late')],
        ),
      );
      expect(values, isEmpty);
      expect(client.closed, isTrue);
    });

    test('disabled client is inert and throws for calls', () async {
      final client = ConvexClient(
        'https://x.convex.cloud',
        options: const ConvexClientOptions(disabled: true),
      );
      expect(client.disabled, isTrue);
      var called = false;
      final unsubscribe = client.onUpdate<Object?>(
        'messages:list',
        {},
        (_) => called = true,
      );
      unsubscribe.unsubscribe();
      expect(called, isFalse);
      expect(() => client.connectionState(), throwsA(isA<StateError>()));
      expect(() => client.rawMutation('send', {}), throwsA(isA<StateError>()));
      await client.close();
    });

    test('setAdminAuth and getAuth delegate to base client', () async {
      late FakeSocket socket;
      final client = ConvexClient(
        'https://x.convex.cloud',
        options: ConvexClientOptions(
          webSocketFactory: (_) => socket = FakeSocket(),
        ),
      );
      socket.open();
      client.setAdminAuth('admin-token', {'subject': 'admin'});
      expect(client.client.hasAuth(), isTrue);
      expect(client.getAuth(), isNull);

      final token = _jwt({'sub': '123', 'name': 'Ada'});
      await client.setAuth((_) async => token, (_) {});
      final auth = client.getAuth();
      expect(auth?.token, token);
      expect(auth?.decoded['sub'], '123');
      expect(auth?.decoded['name'], 'Ada');
    });
  });
}

String _jwt(Map<String, Object?> payload) {
  String encode(Map<String, Object?> value) {
    return base64Url.encode(utf8.encode(jsonEncode(value))).replaceAll('=', '');
  }

  return '${encode({'alg': 'none'})}.${encode(payload)}.';
}
