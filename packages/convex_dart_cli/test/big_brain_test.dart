import 'package:convex_dart_cli/big_brain.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:test/test.dart';

void main() {
  group('BigBrainClient', () {
    test('urlForDeployKey accepts a JSON string response', () async {
      final client = BigBrainClient(
        bearerToken: 'dev:my-dep|secret',
        httpClient: MockClient(
          (request) async => http.Response(
            '"https://veracious-panther-907.convex.cloud"',
            200,
          ),
        ),
      );

      final url = await client.urlForDeployKey('dev:my-dep|secret');

      expect(url, 'https://veracious-panther-907.convex.cloud');
    });

    test('urlForDeployKey accepts an object response', () async {
      final client = BigBrainClient(
        bearerToken: 'dev:my-dep|secret',
        httpClient: MockClient(
          (request) async =>
              http.Response('{"url":"https://from-object.convex.cloud"}', 200),
        ),
      );

      final url = await client.urlForDeployKey('dev:my-dep|secret');

      expect(url, 'https://from-object.convex.cloud');
    });

    test('authorization endpoints still require an object response', () async {
      final client = BigBrainClient(
        bearerToken: 'token',
        httpClient: MockClient(
          (request) async => http.Response(
            '"https://veracious-panther-907.convex.cloud"',
            200,
          ),
        ),
      );

      expect(
        () => client.authorizeWithinCurrentProject(
          deploymentName: 'my-dep',
          deploymentType: 'dev',
        ),
        throwsA(isA<BigBrainException>()),
      );
    });
  });
}
