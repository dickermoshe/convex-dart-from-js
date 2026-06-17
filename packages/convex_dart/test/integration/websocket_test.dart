@Tags(['integration'])
library;

import 'dart:async';
import 'dart:io';

import 'package:convex_dart/browser.dart';
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
    test('onUpdate receives reactive query results', () async {
      final client = ConvexClient(url);
      addTearDown(() => client.close());

      final completer = Completer<Object?>();
      late Unsubscribe<Object?> handle;
      handle = client.onUpdate<Object?>(
        'integration:echo',
        {'message': 'live'},
        () {
          final value = handle.getCurrentValue();
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

      const name = 'dart-integration-ws';
      final updates = <BigInt?>[];
      late Unsubscribe<BigInt?> handle;
      handle = client.onUpdate<BigInt?>('integration:getCounter', {
        'name': name,
      }, () => updates.add(handle.getCurrentValue()));

      await retry(
        () => client.mutation('integration:increment', {'name': name}),
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

    test(
      'setAuth enables auth-required query',
      () async {
        final token = requireEnv('CONVEX_AUTH_TOKEN').trim();

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
        late Unsubscribe<String> handle;
        handle = client.onUpdate<String>('integration:authRequired', {}, () {
          try {
            final value = handle.getCurrentValue();
            if (value != null && !queryCompleter.isCompleted) {
              queryCompleter.complete(value);
            }
          } on Object {
            // Query may fail before auth propagates; wait for a successful value.
          }
        });

        final identity = await retry(
          () => queryCompleter.future.timeout(const Duration(seconds: 30)),
        );
        expect(identity.isNotEmpty, isTrue);
        handle.unsubscribe();
        client.clearAuth();
      },
      skip: optionalEnv('CONVEX_AUTH_TOKEN') == null,
    );
  });
}
