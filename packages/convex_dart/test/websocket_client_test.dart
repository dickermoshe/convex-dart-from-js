import 'dart:async';

import 'package:convex_dart/src/browser.dart';
import 'package:test/test.dart';

import 'support/fake_socket.dart';
import 'support/transition_fixtures.dart';

void main() {
  group('BaseConvexClient', () {
    test('sends connect and query set on open, then applies transition', () {
      late FakeSocket socket;
      final updated = <List<QueryToken>>[];
      final client = BaseConvexClient(
        'https://x.convex.cloud',
        (queries) => updated.add(queries),
        options: BaseConvexClientOptions(
          webSocketFactory: (_) => socket = FakeSocket(),
        ),
      );
      final sub = client.subscribe('messages.js:list', {'n': BigInt.one});

      socket.open();
      expect(sentMessageTypes(socket.sent), ['Connect', 'ModifyQuerySet']);
      final add = sentMessage(socket.sent, 1);
      expect(
        ((add['modifications'] as List).single as Map)['udfPath'],
        'messages:list',
      );

      socket.message(
        transitionJson(
          startQuerySet: 0,
          endQuerySet: 1,
          modifications: [queryUpdated(queryId: 0, value: 'hello')],
        ),
      );

      expect(updated.last, [sub.queryToken]);
      expect(client.localQueryResultByToken(sub.queryToken), 'hello');
    });

    test(
      'mutation resolves after transition reaches mutation timestamp',
      () async {
        late FakeSocket socket;
        final client = BaseConvexClient(
          'https://x.convex.cloud',
          (_) {},
          options: BaseConvexClientOptions(
            webSocketFactory: (_) => socket = FakeSocket(),
          ),
        );
        socket.open();
        socket.message(
          transitionJson(startQuerySet: 0, endQuerySet: 1, modifications: []),
        );
        final mutation = client.mutation('send', {'body': 'hi'});
        final mutationMessage = sentMessage(
          socket.sent,
          socket.sent.length - 1,
        );
        expect(mutationMessage['type'], 'Mutation');

        socket.message(
          mutationResponseJson(
            requestId: mutationMessage['requestId']! as int,
            success: true,
            result: 'ok',
          ),
        );
        await Future<void>.delayed(Duration.zero);
        expect(client.connectionState().hasInflightRequests, isTrue);

        socket.message(
          transitionJson(
            startQuerySet: 1,
            endQuerySet: 1,
            startTs: 'AAAAAAAAAAA=',
            endTs: 'AQAAAAAAAAA=',
            modifications: [],
          ),
        );
        expect(await mutation, 'ok');
        expect(client.connectionState().hasInflightRequests, isFalse);
      },
    );

    test('optimistic update changes local subscribed query immediately', () {
      late FakeSocket socket;
      final updated = <List<QueryToken>>[];
      final client = BaseConvexClient(
        'https://x.convex.cloud',
        (queries) => updated.add(queries),
        options: BaseConvexClientOptions(
          webSocketFactory: (_) => socket = FakeSocket(),
        ),
      );
      final sub = client.subscribe('messages:list', {});
      socket.open();
      socket.message(
        transitionJson(
          startQuerySet: 0,
          endQuerySet: 1,
          modifications: [queryUpdated(queryId: 0, value: [])],
        ),
      );

      client.enqueueMutation(
        'send',
        {'body': 'hi'},
        MutationOptions(
          optimisticUpdate: (store, args) {
            final current =
                (store.getRawQuery('messages:list', {}) as List?) ?? [];
            store.setRawQuery('messages:list', {}, [...current, args['body']]);
          },
        ),
      );

      expect(client.localQueryResultByToken(sub.queryToken), ['hi']);
      expect(updated.last, [sub.queryToken]);
    });

    test('action resolves on ActionResponse', () async {
      late FakeSocket socket;
      final client = BaseConvexClient(
        'https://x.convex.cloud',
        (_) {},
        options: BaseConvexClientOptions(
          webSocketFactory: (_) => socket = FakeSocket(),
        ),
      );
      socket.open();
      socket.message(
        transitionJson(startQuerySet: 0, endQuerySet: 1, modifications: []),
      );
      final actionFuture = client.action('doThing', {'x': 1.0});
      final actionMessage = sentMessage(socket.sent, socket.sent.length - 1);
      expect(actionMessage['type'], 'Action');
      socket.message(
        actionResponseJson(
          requestId: actionMessage['requestId']! as int,
          success: true,
          result: 'done',
        ),
      );
      expect(await actionFuture, 'done');
    });

    test('QueryFailed with errorData surfaces ConvexError', () {
      late FakeSocket socket;
      final client = BaseConvexClient(
        'https://x.convex.cloud',
        (_) {},
        options: BaseConvexClientOptions(
          webSocketFactory: (_) => socket = FakeSocket(),
        ),
      );
      final sub = client.subscribe('broken:list', {});
      socket.open();
      socket.message(
        transitionJson(
          startQuerySet: 0,
          endQuerySet: 1,
          modifications: [
            queryFailed(
              queryId: 0,
              errorMessage: 'query failed',
              errorData: {'code': 'query'},
            ),
          ],
        ),
      );
      expect(
        () => client.localQueryResultByToken(sub.queryToken),
        throwsA(
          isA<ConvexError<Object?>>()
              .having((e) => e.message, 'message', 'query failed')
              .having((e) => e.data, 'data', {'code': 'query'}),
        ),
      );
    });

    test('QueryFailed without errorData surfaces StateError', () {
      late FakeSocket socket;
      final client = BaseConvexClient(
        'https://x.convex.cloud',
        (_) {},
        options: BaseConvexClientOptions(
          webSocketFactory: (_) => socket = FakeSocket(),
        ),
      );
      final sub = client.subscribe('broken:list', {});
      socket.open();
      socket.message(
        transitionJson(
          startQuerySet: 0,
          endQuerySet: 1,
          modifications: [
            queryFailed(queryId: 0, errorMessage: 'query failed'),
          ],
        ),
      );
      expect(
        () => client.localQueryResultByToken(sub.queryToken),
        throwsStateError,
      );
    });

    test('mutation failure with errorData throws ConvexError', () async {
      late FakeSocket socket;
      final client = BaseConvexClient(
        'https://x.convex.cloud',
        (_) {},
        options: BaseConvexClientOptions(
          webSocketFactory: (_) => socket = FakeSocket(),
        ),
      );
      socket.open();
      socket.message(
        transitionJson(startQuerySet: 0, endQuerySet: 1, modifications: []),
      );
      final mutation = client.mutation('broken', {});
      final msg = sentMessage(socket.sent, socket.sent.length - 1);
      socket.message(
        mutationResponseJson(
          requestId: msg['requestId']! as int,
          success: false,
          result: 'mutation failed',
          errorData: {'code': 'mutation'},
        ),
      );

      await expectLater(
        mutation,
        throwsA(
          isA<ConvexError<Object?>>()
              .having((e) => e.message, 'message', 'mutation failed')
              .having((e) => e.data, 'data', {'code': 'mutation'}),
        ),
      );
    });

    test('action failure with errorData throws ConvexError', () async {
      late FakeSocket socket;
      final client = BaseConvexClient(
        'https://x.convex.cloud',
        (_) {},
        options: BaseConvexClientOptions(
          webSocketFactory: (_) => socket = FakeSocket(),
        ),
      );
      socket.open();
      socket.message(
        transitionJson(startQuerySet: 0, endQuerySet: 1, modifications: []),
      );
      final action = client.action('broken', {});
      final msg = sentMessage(socket.sent, socket.sent.length - 1);
      socket.message(
        actionResponseJson(
          requestId: msg['requestId']! as int,
          success: false,
          result: 'action failed',
          errorData: {'code': 'action'},
        ),
      );

      await expectLater(
        action,
        throwsA(
          isA<ConvexError<Object?>>()
              .having((e) => e.message, 'message', 'action failed')
              .having((e) => e.data, 'data', {'code': 'action'}),
        ),
      );
    });

    test('setAuth sends Authenticate message', () async {
      late FakeSocket socket;
      final client = BaseConvexClient(
        'https://x.convex.cloud',
        (_) {},
        options: BaseConvexClientOptions(
          webSocketFactory: (_) => socket = FakeSocket(),
        ),
      );
      socket.open();
      await client.setAuth((_) async => 'token', (_) {});
      expect(sentMessageTypes(socket.sent), contains('Authenticate'));
      expect(client.hasAuth(), isTrue);
      client.clearAuth();
      expect(client.hasAuth(), isFalse);
    });

    test('setAuth onChange fires after identity transition', () async {
      late FakeSocket socket;
      bool? authChanged;
      final client = BaseConvexClient(
        'https://x.convex.cloud',
        (_) {},
        options: BaseConvexClientOptions(
          webSocketFactory: (_) => socket = FakeSocket(),
        ),
      );
      socket.open();
      socket.message(
        transitionJson(startQuerySet: 0, endQuerySet: 1, modifications: []),
      );
      await client.setAuth(
        (_) async => 'token',
        (isAuth) => authChanged = isAuth,
      );
      expect(sentMessageTypes(socket.sent), contains('Authenticate'));
      expect(authChanged, isNull);

      socket.message(
        transitionJson(
          startQuerySet: 1,
          endQuerySet: 1,
          startIdentity: 0,
          endIdentity: 1,
          modifications: [],
        ),
      );
      expect(authChanged, isTrue);
    });

    test('setAuth then auth-required query receives result', () async {
      late FakeSocket socket;
      final updated = <List<QueryToken>>[];
      final client = BaseConvexClient(
        'https://x.convex.cloud',
        (queries) => updated.add(queries),
        options: BaseConvexClientOptions(
          webSocketFactory: (_) => socket = FakeSocket(),
        ),
      );
      final authReady = Completer<void>();
      socket.open();
      socket.message(
        transitionJson(startQuerySet: 0, endQuerySet: 1, modifications: []),
      );
      await client.setAuth((_) async => 'token', (isAuth) {
        if (isAuth && !authReady.isCompleted) {
          authReady.complete();
        }
      });
      socket.message(
        transitionJson(
          startQuerySet: 1,
          endQuerySet: 1,
          startIdentity: 0,
          endIdentity: 1,
          modifications: [],
        ),
      );
      await authReady.future;

      final sub = client.subscribe('integration:authRequired', {});
      socket.message(
        transitionJson(
          startQuerySet: 1,
          endQuerySet: 2,
          startIdentity: 1,
          endIdentity: 1,
          modifications: [queryUpdated(queryId: 0, value: 'user|test')],
        ),
      );

      expect(updated.last, [sub.queryToken]);
      expect(client.localQueryResultByToken(sub.queryToken), 'user|test');
    });

    test('subscribeToConnectionState notifies on changes', () async {
      late FakeSocket socket;
      final states = <ConnectionState>[];
      final client = BaseConvexClient(
        'https://x.convex.cloud',
        (_) {},
        options: BaseConvexClientOptions(
          webSocketFactory: (_) => socket = FakeSocket(),
        ),
      );
      client.subscribeToConnectionState(states.add);
      socket.open();
      await Future<void>.delayed(Duration.zero);
      expect(states, isNotEmpty);
      expect(states.last.isWebSocketConnected, isTrue);
    });

    test('close terminates client', () async {
      late FakeSocket socket;
      final client = BaseConvexClient(
        'https://x.convex.cloud',
        (_) {},
        options: BaseConvexClientOptions(
          webSocketFactory: (_) => socket = FakeSocket(),
        ),
      );
      socket.open();
      await client.close();
      expect(client.connectionState().isWebSocketConnected, isFalse);
    });
  });
}
