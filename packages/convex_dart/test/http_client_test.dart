import 'dart:async';
import 'dart:convert';

import 'package:convex_dart/src/browser.dart';
import 'package:convex_dart/src/browser/logging.dart';
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

      expect(await client.rawQuery('messages:list', {'n': BigInt.one}), 2.5);
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

      final first = client.rawMutation('first', {});
      final second = client.rawMutation('second', {});
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
      final first = client.rawMutation(
        'first',
        null,
        const HttpMutationOptions(skipQueue: true),
      );
      final second = client.rawMutation(
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

      expect(await client.rawAction('doThing', {}), BigInt.one);
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
      await client.rawQuery('q', {});
      expect(authHeader, 'Bearer token-1');
      client.clearAuth();
      await client.rawQuery('q', {});
      expect(authHeader, isNull);
    });

    test('setAuth preserves token bytes like upstream', () async {
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
      client.setAuth(' token-1 ');
      await client.rawQuery('q', {});
      expect(authHeader, 'Bearer  token-1 ');
    });

    test('setAdminAuth uses Convex authorization scheme', () async {
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
      client.setAdminAuth('admin-key');
      await client.rawQuery('q', {});
      expect(authHeader, 'Convex admin-key');
    });

    test('close closes underlying http client', () {
      final fake = FakeHttpClient((_) async => http.Response('', 200));
      final client = ConvexHttpClient(
        'https://x.convex.cloud',
        options: ConvexHttpClientOptions(httpClient: fake),
      );
      expect(() => client.close(), returnsNormally);
    });

    test('setDebug disables result log forwarding', () async {
      final logger = _RecordingLogger();
      final fake = FakeHttpClient((request) async {
        return jsonResponse({
          'status': 'success',
          'value': null,
          'logLines': ['line'],
        });
      });
      final client = ConvexHttpClient(
        'https://x.convex.cloud',
        options: ConvexHttpClientOptions(httpClient: fake, logger: logger),
      );

      await client.rawQuery('logged', {});
      expect(logger.logs, [
        ['[query:logged] line'],
      ]);

      client.setDebug(false);
      await client.rawQuery('quiet', {});
      expect(logger.logs, [
        ['[query:logged] line'],
      ]);
    });

    test(
      'function calls generic endpoint without argument array wrapper',
      () async {
        final fake = FakeHttpClient((request) async {
          expect(request.url.toString(), 'https://x.convex.cloud/api/function');
          expect(jsonDecode(request.body), {
            'componentPath': 'component',
            'path': 'messages:list',
            'format': 'convex_encoded_json',
            'args': {'channel': 'general'},
          });
          return jsonResponse({
            'status': 'success',
            'value': 'ok',
            'logLines': [],
          });
        });
        final client = ConvexHttpClient(
          'https://x.convex.cloud',
          options: ConvexHttpClientOptions(httpClient: fake),
        );

        expect(
          await client.rawFunction(
            'messages:list',
            componentPath: 'component',
            args: {'channel': 'general'},
          ),
          'ok',
        );
      },
    );

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
        client.rawQuery('broken', {}),
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

      await expectLater(client.rawQuery('broken', {}), throwsStateError);
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
      final results = await Future.wait([
        client.rawQuery('a', {}),
        client.rawQuery('b', {}),
      ]);
      expect(results, [1, 2]);
    });
  });
}

class _RecordingLogger implements Logger {
  final logs = <List<Object?>>[];
  final warnings = <List<Object?>>[];
  final errors = <List<Object?>>[];
  final verbose = <String>[];

  @override
  void error(List<Object?> args) => errors.add(args);

  @override
  void log(List<Object?> args) => logs.add(args);

  @override
  void logVerbose(String message) => verbose.add(message);

  @override
  void warn(List<Object?> args) => warnings.add(args);
}
