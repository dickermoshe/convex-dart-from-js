import 'dart:async';
import 'dart:convert';

import 'package:convex_dart_from_js/convex_dart_from_js.dart';
import 'package:http/http.dart' as http;
import 'package:test/test.dart';

void main() {
  group('ConvexHttpClient', () {
    test('runs query with encoded args and auth header', () async {
      final fake = _FakeClient((request) async {
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
        return _json({'status': 'success', 'value': 2.5, 'logLines': []});
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
      final fake = _FakeClient((request) async {
        final path = (jsonDecode(request.body) as Map)['path'] as String;
        seen.add(path);
        if (path == 'first') await gate.future;
        return _json({'status': 'success', 'value': null, 'logLines': []});
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

    test('actions are not queued', () async {
      final fake = _FakeClient((request) async {
        expect(request.url.toString(), 'https://x.convex.cloud/api/action');
        return _json({
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

    test('throws ConvexError with forwarded data', () async {
      final fake = _FakeClient((request) async {
        return _json({
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
      final fake = _FakeClient((request) async {
        return http.Response('nope', 500);
      });
      final client = ConvexHttpClient(
        'https://x.convex.cloud',
        options: ConvexHttpClientOptions(httpClient: fake),
      );

      await expectLater(client.query('broken'), throwsStateError);
    });
  });
}

http.Response _json(Map<String, Object?> body, {int statusCode = 200}) =>
    http.Response(jsonEncode(body), statusCode);

class _FakeClient extends http.BaseClient {
  _FakeClient(this.handler);

  final FutureOr<http.Response> Function(http.Request request) handler;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final response = await handler(request as http.Request);
    return http.StreamedResponse(
      Stream.value(response.bodyBytes),
      response.statusCode,
      headers: response.headers,
      reasonPhrase: response.reasonPhrase,
    );
  }
}
