@Tags(['integration'])
library;

import 'dart:async';
import 'dart:io';

import 'package:convex_dart/src/browser.dart';
import 'package:test/test.dart';

import 'helpers.dart';

void main() {
  final url = Platform.environment['CONVEX_URL'];
  if (url == null || url.isEmpty) {
    test('requires CONVEX_URL', () {
      fail('Set CONVEX_URL to run integration tests');
    });
    return;
  }

  group('WebSocket integration', () {
    test('rawQuery waits for an uncached query result', () async {
      final client = ConvexClient(url);
      addTearDown(() => client.close());

      final result = await retry(
        () => client.rawQuery('integration:echo', {'message': 'one-shot'}),
      );
      expect(result, {'message': 'one-shot'});
    });

    test('onUpdate calls new listeners with cached query results', () async {
      final client = ConvexClient(url);
      addTearDown(() => client.close());

      final firstCompleter = Completer<Object?>();
      final first = client.onUpdate<Object?>(
        'integration:echo',
        {'message': 'cached'},
        (value) {
          if (value != null && !firstCompleter.isCompleted) {
            firstCompleter.complete(value);
          }
        },
      );
      addTearDown(first.unsubscribe);

      await retry(
        () => firstCompleter.future.timeout(const Duration(seconds: 30)),
      );

      final secondCompleter = Completer<Object?>();
      final second = client.onUpdate<Object?>(
        'integration:echo',
        {'message': 'cached'},
        (value) {
          if (value != null && !secondCompleter.isCompleted) {
            secondCompleter.complete(value);
          }
        },
      );
      addTearDown(second.unsubscribe);

      final cached = await retry(
        () => secondCompleter.future.timeout(const Duration(seconds: 30)),
      );
      expect(cached, {'message': 'cached'});
    });

    test('onUpdate routes query errors to onError', () async {
      final client = ConvexClient(url);
      addTearDown(() => client.close());

      final errorCompleter = Completer<Object>();
      final handle = client.onUpdate<Object?>(
        'integration:throws',
        {},
        (_) {},
        onError: (error, _) {
          if (!errorCompleter.isCompleted) {
            errorCompleter.complete(error);
          }
        },
      );
      addTearDown(handle.unsubscribe);

      final error = await retry(
        () => errorCompleter.future.timeout(const Duration(seconds: 30)),
      );
      expect(
        error,
        isA<ConvexError<Object?>>().having((error) => error.data, 'data', {
          'code': 'test',
        }),
      );
    });

    test('rawQuery throws ConvexError with string data', () async {
      final client = ConvexClient(url);
      addTearDown(() => client.close());

      await expectLater(
        retry(() => client.rawQuery('integration:throwsString', {})),
        throwsA(
          isA<ConvexError<Object?>>()
              .having((e) => e.message, 'message', isNotEmpty)
              .having((e) => e.data, 'data', 'string error'),
        ),
      );
    });

    test('rawMutation throws ConvexError with data', () async {
      final client = ConvexClient(url);
      addTearDown(() => client.close());

      await expectLater(
        retry(() => client.rawMutation('integration:throwsMutation', {})),
        throwsA(
          isA<ConvexError<Object?>>()
              .having((e) => e.message, 'message', isNotEmpty)
              .having((e) => e.data, 'data', {'code': 'mutation'}),
        ),
      );
    });

    test('rawAction throws ConvexError with data', () async {
      final client = ConvexClient(url);
      addTearDown(() => client.close());

      await expectLater(
        retry(() => client.rawAction('integration:throwsAction', {})),
        throwsA(
          isA<ConvexError<Object?>>()
              .having((e) => e.message, 'message', isNotEmpty)
              .having((e) => e.data, 'data', {'code': 'action'}),
        ),
      );
    });

    test('onUpdate receives reactive query results', () async {
      final client = ConvexClient(url);
      addTearDown(() => client.close());

      final completer = Completer<Object?>();
      final handle = client.onUpdate<Object?>(
        'integration:echo',
        {'message': 'live'},
        (value) {
          if (value != null && !completer.isCompleted) {
            completer.complete(value);
          }
        },
      );

      final result = await retry(
        () => completer.future.timeout(const Duration(seconds: 30)),
      );
      expect(result, {'message': 'live'});
      handle.unsubscribe();
    });

    test('mutation updates subscribed counter query', () async {
      final client = ConvexClient(url);
      addTearDown(() => client.close());

      final name = uniqueIntegrationName('dart-integration-ws');
      final updates = <BigInt?>[];
      final handle = client.onUpdate<BigInt?>('integration:getCounter', {
        'name': name,
      }, updates.add);

      await retry(
        () => client.rawMutation('integration:increment', {'name': name}),
      );

      await retry(() async {
        if (updates.isEmpty) {
          throw StateError('waiting for reactive update');
        }
      });

      expect(updates.last, isA<BigInt>());
      expect(updates.last! >= BigInt.one, isTrue);
      handle.unsubscribe();
    });

    test('optimistic update is visible before mutation settles', () async {
      final client = ConvexClient(url);
      addTearDown(() => client.close());

      final name = uniqueIntegrationName('dart-integration-ws-optimistic');
      final updates = <BigInt?>[];
      final initialCompleter = Completer<void>();
      final optimisticValue = BigInt.from(999);

      final handle = client.onUpdate<BigInt?>(
        'integration:getCounter',
        {'name': name},
        (value) {
          updates.add(value);
          if (!initialCompleter.isCompleted) {
            initialCompleter.complete();
          }
        },
      );
      addTearDown(handle.unsubscribe);

      await retry(
        () => initialCompleter.future.timeout(const Duration(seconds: 30)),
      );
      expect(updates.last, isNull);

      final mutation = client.rawMutation(
        'integration:increment',
        {'name': name},
        optimisticUpdate: (store, args) {
          store.setRawQuery('integration:getCounter', {
            'name': args['name'],
          }, optimisticValue);
        },
      );

      await retry(
        () async {
          if (!updates.contains(optimisticValue)) {
            throw StateError('waiting for optimistic update');
          }
        },
        maxAttempts: 10,
        delay: const Duration(milliseconds: 100),
      );

      final result = await retry(() => mutation);
      expect(result, BigInt.one);

      await retry(
        () async {
          if (updates.last != BigInt.one) {
            throw StateError('waiting for server value');
          }
        },
        maxAttempts: 10,
        delay: const Duration(milliseconds: 200),
      );
    });

    test(
      'setAuth enables auth-required query',
      () async {
        final token = requireJwtEnv('CONVEX_AUTH_TOKEN');

        final client = ConvexClient(
          url,
          options: const ConvexClientOptions(expectAuth: true),
        );
        addTearDown(() => client.close());

        final authCompleter = Completer<bool>();
        await client.setAuth((_) async => token, (isAuthenticated) {
          if (!authCompleter.isCompleted) {
            authCompleter.complete(isAuthenticated);
          }
        });

        final authenticated = await retry(
          () => authCompleter.future.timeout(const Duration(seconds: 30)),
        );
        expect(
          authenticated,
          isTrue,
          reason: 'setAuth onChange never confirmed',
        );

        final queryCompleter = Completer<String>();
        final handle = client.onUpdate<String>(
          'integration:authRequired',
          {},
          (value) {
            if (value != null && !queryCompleter.isCompleted) {
              queryCompleter.complete(value);
            }
          },
          onError: (_, _) {
            // Query may fail before auth propagates; wait for a successful value.
          },
        );

        final identity = await retry(
          () => queryCompleter.future.timeout(const Duration(seconds: 30)),
        );
        expect(identity.isNotEmpty, isTrue);
        handle.unsubscribe();
        client.clearAuth();
      },
      skip: optionalJwtEnv('CONVEX_AUTH_TOKEN') == null,
    );
  });
}

String uniqueIntegrationName(String prefix) =>
    '$prefix-${DateTime.now().microsecondsSinceEpoch}';
