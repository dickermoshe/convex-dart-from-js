@Tags(['integration'])
library integration_http;

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

  group('HTTP integration', () {
    late ConvexHttpClient client;

    setUp(() {
      client = ConvexHttpClient(url);
    });

    tearDown(() => client.close());

    test('echo query returns args', () async {
      final result = await retry(
        () => client.query('integration:echo', {'message': 'hi'}),
      );
      expect(result, {'message': 'hi'});
    });

    test('types query returns Convex value types', () async {
      final result =
          await retry(() => client.query('integration:types')) as Map;
      expect(result['int64'], BigInt.from(42));
      expect(result['nested'], {'a': 'x'});
    });

    test('mutation increments counter', () async {
      const name = 'dart-integration-http';
      await retry(
        () => client.mutation('integration:increment', {'name': name}),
      );
      final value = await retry(
        () => client.query('integration:getCounter', {'name': name}),
      );
      expect(value, isA<BigInt>());
      expect((value as BigInt) >= BigInt.one, isTrue);
    });

    test('action doubles input', () async {
      final result = await retry(
        () => client.action('integration:compute', {'x': 3.0}),
      );
      expect(result, 6.0);
    });

    test('throws ConvexError with data', () async {
      await expectLater(
        retry(() => client.query('integration:throws')),
        throwsA(
          isA<ConvexError<Object?>>()
              .having((e) => e.message, 'message', 'integration error')
              .having((e) => e.data, 'data', {'code': 'test'}),
        ),
      );
    });

    test('auth required query with token', () async {
      final token = Platform.environment['CONVEX_AUTH_TOKEN'];
      if (token == null || token.isEmpty) {
        return;
      }
      final authed = ConvexHttpClient(
        url,
        options: ConvexHttpClientOptions(auth: token),
      );
      addTearDown(authed.close);
      final result = await retry(
        () => authed.query('integration:authRequired'),
      );
      expect(result, isA<String>());
      expect((result as String).isNotEmpty, isTrue);
    });
  });
}
