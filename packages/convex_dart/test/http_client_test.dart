import 'dart:async';
import 'dart:convert';

import 'package:convex_dart/browser.dart';
import 'package:http/http.dart' as http;
import 'package:test/test.dart';

import 'support/fake_http_client.dart';

void main() {
  group('ConvexHttpClient', () {
    test('runs query with encoded args and auth header', () async {
      final fake = FakeHttpClient((request) async {
        expect(request.url.toString(), 'https://x.convex.cloud/api/query');
        expect(request.headers['Authorization'], 'Bearer token');
        expect(jsonDecode(request.body), {
          'path': 'messages:list',
          'format': 'convex_encoded_json',
          'args': [
            {
              'n': {r'$integer': 'AQAAAAAAAAA='},
            },
          ],
        });
        return jsonResponse({
          'status': 'success',
          'value': 2.5,
          'logLines': [],
        });
      });
      final client = ConvexHttpClient(
        'https://x.convex.cloud',
        options: ConvexHttpClientOptions(httpClient: fake, auth: 'token'),
      );

      expect(await client.query('messages:list', {'n': BigInt.one}), 2.5);
    });

    test('queues mutations by default', () async {
      final seen = <String>[];
      final gate = Completer<void>();
      final fake = FakeHttpClient((request) async {
        final path = (jsonDecode(request.body) as Map)['path'] as String;
        seen.add(path);
        if (path == 'first') await gate.future;
        return jsonResponse({
          'status': 'success',
          'value': null,
          'logLines': [],
        });
      });
      final client = ConvexHttpClient(
        'https://x.convex.cloud',
        options: ConvexHttpClientOptions(httpClient: fake),
      );

      final first = client.mutation('first');
      final second = client.mutation('second');
      await Future<void>.delayed(Duration.zero);
      expect(seen, ['first']);
      gate.complete();
      await Future.wait([first, second]);
      expect(seen, ['first', 'second']);
    });

    test('skipQueue runs mutations in parallel', () async {
      final inFlight = <String>[];
      final gate = Completer<void>();
      final fake = FakeHttpClient((request) async {
        final path = (jsonDecode(request.body) as Map)['path'] as String;
        inFlight.add(path);
        await gate.future;
        inFlight.remove(path);
        return jsonResponse({
          'status': 'success',
          'value': null,
          'logLines': [],
        });
      });
      final client = ConvexHttpClient(
        'https://x.convex.cloud',
        options: ConvexHttpClientOptions(httpClient: fake),
      );
      final first = client.mutation(
        'first',
        null,
        const HttpMutationOptions(skipQueue: true),
      );
      final second = client.mutation(
        'second',
        null,
        const HttpMutationOptions(skipQueue: true),
      );
      await Future<void>.delayed(Duration.zero);
      expect(inFlight, containsAll(['first', 'second']));
      gate.complete();
      await Future.wait([first, second]);
    });

    test('actions are not queued', () async {
      final fake = FakeHttpClient((request) async {
        expect(request.url.toString(), 'https://x.convex.cloud/api/action');
        return jsonResponse({
          'status': 'success',
          'value': {r'$integer': 'AQAAAAAAAAA='},
          'logLines': [],
        });
      });
      final client = ConvexHttpClient(
        'https://x.convex.cloud',
        options: ConvexHttpClientOptions(httpClient: fake),
      );

      expect(await client.action('doThing'), BigInt.one);
    });

    test('setAuth and clearAuth update Authorization header', () async {
      String? authHeader;
      final fake = FakeHttpClient((request) async {
        authHeader = request.headers['Authorization'];
        return jsonResponse({
          'status': 'success',
          'value': null,
          'logLines': [],
        });
      });
      final client = ConvexHttpClient(
        'https://x.convex.cloud',
        options: ConvexHttpClientOptions(httpClient: fake),
      );
      client.setAuth('token-1');
      await client.query('q');
      expect(authHeader, 'Bearer token-1');
      client.clearAuth();
      await client.query('q');
      expect(authHeader, isNull);
    });

    test('close closes underlying http client', () {
      final fake = FakeHttpClient((_) async => http.Response('', 200));
      final client = ConvexHttpClient(
        'https://x.convex.cloud',
        options: ConvexHttpClientOptions(httpClient: fake),
      );
      expect(() => client.close(), returnsNormally);
    });

    test('throws ConvexError with forwarded data', () async {
      final fake = FakeHttpClient((request) async {
        return jsonResponse({
          'status': 'error',
          'errorMessage': 'boom',
          'errorData': {'code': 'bad'},
          'logLines': [],
        }, statusCode: statusCodeUdfFailed);
      });
      final client = ConvexHttpClient(
        'https://x.convex.cloud',
        options: ConvexHttpClientOptions(httpClient: fake),
      );

      await expectLater(
        client.query('broken'),
        throwsA(
          isA<ConvexError<Object?>>()
              .having((e) => e.message, 'message', 'boom')
              .having((e) => e.data, 'data', {'code': 'bad'}),
        ),
      );
    });

    test('throws response body for non-UDF HTTP failures', () async {
      final fake = FakeHttpClient((request) async {
        return http.Response('nope', 500);
      });
      final client = ConvexHttpClient(
        'https://x.convex.cloud',
        options: ConvexHttpClientOptions(httpClient: fake),
      );

      await expectLater(client.query('broken'), throwsStateError);
    });

    test('concurrent queries complete independently', () async {
      var count = 0;
      final fake = FakeHttpClient((request) async {
        count++;
        return jsonResponse({
          'status': 'success',
          'value': count,
          'logLines': [],
        });
      });
      final client = ConvexHttpClient(
        'https://x.convex.cloud',
        options: ConvexHttpClientOptions(httpClient: fake),
      );
      final results = await Future.wait([client.query('a'), client.query('b')]);
      expect(results, [1, 2]);
    });
  });
}
