import 'dart:convert';
import 'dart:io';

import 'package:convex_dart_from_js/convex_dart_from_js.dart';
import 'package:test/test.dart';

void main() {
  test(
    'HTTP client posts encoded function calls and decodes responses',
    () async {
      final requests = <Map<String, Object?>>[];
      final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
      final sub = server.listen((request) async {
        requests.add({
          'path': request.uri.path,
          'auth': request.headers.value('authorization'),
          'body': jsonDecode(await utf8.decodeStream(request)),
        });
        request.response.headers.contentType = ContentType.json;
        request.response.write(
          jsonEncode({
            'status': 'success',
            'value': {r'$integer': 'AQAAAAAAAAA='},
            'logLines': <String>[],
          }),
        );
        await request.response.close();
      });

      final client = ConvexHttpClient(
        'http://${server.address.host}:${server.port}',
        const ConvexHttpClientOptions(skipConvexDeploymentUrlCheck: true),
      )..setAuth('token');

      expect(await client.query('messages:list', {'n': 1}), 1);
      expect(requests.single['path'], '/api/query');
      expect(requests.single['auth'], 'Bearer token');
      expect((requests.single['body'] as Map)['format'], 'convex_encoded_json');

      client.close();
      await sub.cancel();
      await server.close(force: true);
    },
  );

  test('HTTP client forwards Convex error data', () async {
    final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    final sub = server.listen((request) async {
      await utf8.decodeStream(request);
      request.response.statusCode = statusCodeUdfFailed;
      request.response.headers.contentType = ContentType.json;
      request.response.write(
        jsonEncode({
          'status': 'error',
          'errorMessage': 'failed',
          'errorData': {'reason': 'bad'},
        }),
      );
      await request.response.close();
    });

    final client = ConvexHttpClient(
      'http://${server.address.host}:${server.port}',
      const ConvexHttpClientOptions(skipConvexDeploymentUrlCheck: true),
    );

    await expectLater(
      client.action('fail'),
      throwsA(
        isA<ConvexError<Object?>>().having((error) => error.data, 'data', {
          'reason': 'bad',
        }),
      ),
    );

    client.close();
    await sub.cancel();
    await server.close(force: true);
  });
}
