@Tags(['integration'])
library;

import 'package:test/test.dart';

import '../../lib/credentials.dart';
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

  group('resolveCredentialsFromEnv integration', () {
    test('resolves deploy key credentials against live deployment', () async {
      final creds = await resolveCredentialsFromEnv(
        deployKeyEnv(credentials.deployKey, credentials.url),
      );
      expect(creds.url, credentials.url);
      expect(creds.adminKey, credentials.deployKey);
    });
  });
}
