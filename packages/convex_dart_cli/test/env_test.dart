import 'dart:io';

import '../lib/env.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';

void main() {
  group('loadEnv', () {
    late Directory tempDir;

    setUp(() {
      tempDir = Directory.systemTemp.createTempSync('function_spec_env_test');
    });

    tearDown(() {
      tempDir.deleteSync(recursive: true);
    });

    test('parses key=value pairs and strips quotes', () {
      File(p.join(tempDir.path, '.env.local')).writeAsStringSync('''
# comment
CONVEX_URL=https://example.convex.cloud
CONVEX_DEPLOYMENT="dev:my-deployment"
TOKEN='abc'
''');

      final env = loadEnv(workingDirectory: tempDir.path);
      expect(env['CONVEX_URL'], 'https://example.convex.cloud');
      expect(env['CONVEX_DEPLOYMENT'], 'dev:my-deployment');
      expect(env['TOKEN'], 'abc');
    });

    test('prefers .env.local over .env', () {
      File(p.join(tempDir.path, '.env')).writeAsStringSync('FOO=from_env');
      File(
        p.join(tempDir.path, '.env.local'),
      ).writeAsStringSync('FOO=from_local');

      final env = loadEnv(workingDirectory: tempDir.path);
      expect(env['FOO'], 'from_local');
    });

    test('loads only the provided env file when --env-file is used', () {
      File(p.join(tempDir.path, '.env.local')).writeAsStringSync('FOO=ignored');
      File(p.join(tempDir.path, 'custom.env')).writeAsStringSync('FOO=custom');

      final env = loadEnv(
        envFile: 'custom.env',
        workingDirectory: tempDir.path,
      );
      expect(env['FOO'], 'custom');
    });
  });

  group('deployment helpers', () {
    test('stripDeploymentTypePrefix removes type prefix', () {
      expect(
        stripDeploymentTypePrefix('dev:tall-forest-1234'),
        'tall-forest-1234',
      );
      expect(stripDeploymentTypePrefix('legacy-name'), 'legacy-name');
    });

    test('getDeploymentTypeFromConfiguredDeployment recognizes types', () {
      expect(getDeploymentTypeFromConfiguredDeployment('dev:foo'), 'dev');
      expect(getDeploymentTypeFromConfiguredDeployment('prod:foo'), 'prod');
      expect(getDeploymentTypeFromConfiguredDeployment('local:foo'), 'local');
      expect(getDeploymentTypeFromConfiguredDeployment('foo'), isNull);
    });

    test('isDeploymentKey matches dev and prod keys', () {
      expect(isDeploymentKey('dev:name|secret'), isTrue);
      expect(isDeploymentKey('prod:name|secret'), isTrue);
      expect(isDeploymentKey('preview:name|secret'), isFalse);
    });

    test('isAnonymousDeployment recognizes anonymous deployment names', () {
      expect(isAnonymousDeployment('anonymous-abc123'), isTrue);
      expect(isAnonymousDeployment('joyful-capybara-123'), isFalse);
    });
  });
}
