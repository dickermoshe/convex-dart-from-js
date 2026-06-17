@Tags(['integration'])
library;

import 'dart:convert';

import 'package:test/test.dart';

import '../../lib/credentials.dart';
import '../../lib/function_spec.dart';
import 'helpers.dart';

void main() {
  final credentials = integrationDeployCredentials();
  if (credentials == null) {
    test('requires CONVEX_DEPLOY_KEY and CONVEX_URL', () {
      fail(
        'Set CONVEX_DEPLOY_KEY and CONVEX_URL to run integration tests',
      );
    });
    return;
  }

  group('watchFunctionSpec integration', () {
    late DeploymentCredentials creds;

    setUpAll(() async {
      creds = await resolveCredentialsFromEnv(
        deployKeyEnv(credentials.deployKey, credentials.url),
      );
    });

    test('emits function spec JSON for deployed backend', () async {
      final json = await retry(
        () => watchFunctionSpec(
          deploymentUrl: creds.url,
          adminKey: creds.adminKey,
        ).first.timeout(const Duration(seconds: 30)),
      );

      final spec = jsonDecode(json) as Map<String, dynamic>;
      expect(spec['url'], isNotNull);
      expect(spec['functions'], isA<List<dynamic>>());

      final functions = spec['functions'] as List<dynamic>;
      expect(functions, isNotEmpty);

      final serialized = jsonEncode(functions);
      expect(
        serialized,
        contains('integration:echo'),
        reason: 'convex-test deployment should expose integration.ts',
      );
    });
  });
}
