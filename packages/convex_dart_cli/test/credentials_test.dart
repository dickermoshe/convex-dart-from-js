import 'package:dotenv/dotenv.dart';
import 'package:convex_dart_cli/big_brain.dart';
import 'package:convex_dart_cli/credentials.dart';
import 'package:convex_dart_cli/env.dart';
import 'package:test/test.dart';

class FakeBigBrainClient extends BigBrainClient {
  FakeBigBrainClient({
    super.bearerToken,
    this.urlForDeployKeyResult = 'https://from-key.convex.cloud',
    this.authorizeResult = const DeploymentAuthResponse(
      adminKey: 'authorized-admin-key',
      url: 'https://authorized.convex.cloud',
    ),
    this.provisionResult = const DeploymentAuthResponse(
      adminKey: 'provisioned-admin-key',
      url: 'https://provisioned.convex.cloud',
    ),
  });

  final String urlForDeployKeyResult;
  final DeploymentAuthResponse authorizeResult;
  final DeploymentAuthResponse provisionResult;
  var authorizeProdCalled = false;
  var authorizeWithinProjectCalled = false;
  var provisionAndAuthorizeCalled = false;
  String? lastProvisionDeploymentType;
  String? lastProvisionTeamSlug;
  String? lastProvisionProjectSlug;

  @override
  Future<String> urlForDeployKey(String deployKey) async =>
      urlForDeployKeyResult;

  @override
  Future<DeploymentAuthResponse> authorizeWithinCurrentProject({
    required String deploymentName,
    required String deploymentType,
  }) async {
    authorizeWithinProjectCalled = true;
    return authorizeResult;
  }

  @override
  Future<DeploymentAuthResponse> authorizeProd({
    required String deploymentName,
  }) async {
    authorizeProdCalled = true;
    return authorizeResult;
  }

  @override
  Future<DeploymentAuthResponse> provisionAndAuthorize({
    String? teamSlug,
    String? projectSlug,
    required String deploymentType,
  }) async {
    provisionAndAuthorizeCalled = true;
    lastProvisionDeploymentType = deploymentType;
    lastProvisionTeamSlug = teamSlug;
    lastProvisionProjectSlug = projectSlug;
    return provisionResult;
  }

  @override
  void close() {}
}

DotEnv envFromMap(Map<String, String> values) {
  final env = DotEnv(quiet: true);
  env.addAll(values);
  return env;
}

void main() {
  group('resolveCredentialsFromEnv', () {
    test('uses self-hosted env pair', () async {
      final credentials = await resolveCredentialsFromEnv(
        envFromMap({
          convexSelfHostedUrlEnvVar: 'https://self.convex.cloud',
          convexSelfHostedAdminKeyEnvVar: 'self-admin',
        }),
      );
      expect(credentials.url, 'https://self.convex.cloud');
      expect(credentials.adminKey, 'self-admin');
    });

    test('uses deployment deploy key with CONVEX_URL', () async {
      final credentials = await resolveCredentialsFromEnv(
        envFromMap({
          convexDeployKeyEnvVar: 'dev:my-dep|secret',
          convexUrlEnvVar: 'https://env-url.convex.cloud',
        }),
      );
      expect(credentials.url, 'https://env-url.convex.cloud');
      expect(credentials.adminKey, 'dev:my-dep|secret');
    });

    test(
      'uses deployment deploy key with url_for_key when CONVEX_URL missing',
      () async {
        final deployKey = 'dev:my-dep|secret';
        final bigBrain = FakeBigBrainClient(bearerToken: deployKey);
        final credentials = await resolveCredentialsFromEnv(
          envFromMap({convexDeployKeyEnvVar: deployKey}),
          bigBrain: bigBrain,
        );
        expect(bigBrain.bearerToken, deployKey);
        expect(credentials.url, 'https://from-key.convex.cloud');
        expect(credentials.adminKey, deployKey);
      },
    );

    test('uses CONVEX_DEPLOYMENT_TOKEN alias', () async {
      final credentials = await resolveCredentialsFromEnv(
        envFromMap({
          convexDeploymentTokenEnvVar: 'dev:my-dep|secret',
          convexUrlEnvVar: 'https://env-url.convex.cloud',
        }),
      );
      expect(credentials.adminKey, 'dev:my-dep|secret');
    });

    test('uses project deploy key via provision_and_authorize', () async {
      final deployKey = 'project:me:my-project|secret';
      final bigBrain = FakeBigBrainClient(bearerToken: deployKey);
      final credentials = await resolveCredentialsFromEnv(
        envFromMap({convexDeployKeyEnvVar: deployKey}),
        bigBrain: bigBrain,
      );
      expect(bigBrain.provisionAndAuthorizeCalled, isTrue);
      expect(bigBrain.lastProvisionDeploymentType, 'dev');
      expect(bigBrain.lastProvisionTeamSlug, isNull);
      expect(credentials.url, 'https://provisioned.convex.cloud');
      expect(credentials.adminKey, 'provisioned-admin-key');
    });

    test('uses preview deploy key via provision_and_authorize', () async {
      final deployKey = 'preview:my-team:my-project|secret';
      final bigBrain = FakeBigBrainClient(bearerToken: deployKey);
      final credentials = await resolveCredentialsFromEnv(
        envFromMap({convexDeployKeyEnvVar: deployKey}),
        bigBrain: bigBrain,
      );
      expect(bigBrain.provisionAndAuthorizeCalled, isTrue);
      expect(bigBrain.lastProvisionTeamSlug, 'my-team');
      expect(bigBrain.lastProvisionProjectSlug, 'my-project');
      expect(credentials.url, 'https://provisioned.convex.cloud');
    });

    test('ignores CONVEX_DEPLOYMENT when deploy key is set', () async {
      final credentials = await resolveCredentialsFromEnv(
        envFromMap({
          convexDeployKeyEnvVar: 'dev:my-dep|secret',
          convexUrlEnvVar: 'https://env-url.convex.cloud',
          convexDeploymentEnvVar: 'dev:other-dep',
        }),
      );
      expect(credentials.adminKey, 'dev:my-dep|secret');
    });

    test('rejects local CONVEX_DEPLOYMENT', () async {
      expect(
        () => resolveCredentialsFromEnv(
          envFromMap({convexDeploymentEnvVar: 'local:my-local'}),
        ),
        throwsA(
          isA<Exception>().having(
            (e) => e.toString(),
            'message',
            contains('Local Convex deployments are not supported'),
          ),
        ),
      );
    });

    test('rejects preview CONVEX_DEPLOYMENT', () async {
      expect(
        () => resolveCredentialsFromEnv(
          envFromMap({convexDeploymentEnvVar: 'preview:my-preview'}),
          readGlobalConfigFn: () => 'token',
        ),
        throwsA(
          isA<Exception>().having(
            (e) => e.toString(),
            'message',
            contains('Preview deployments'),
          ),
        ),
      );
    });

    test('rejects anonymous CONVEX_DEPLOYMENT', () async {
      expect(
        () => resolveCredentialsFromEnv(
          envFromMap({convexDeploymentEnvVar: 'dev:anonymous-abc123'}),
          readGlobalConfigFn: () => 'token',
        ),
        throwsA(
          isA<Exception>().having(
            (e) => e.toString(),
            'message',
            contains('Anonymous Convex deployments are not supported'),
          ),
        ),
      );
    });

    test('authorizes logged-in dev deployment', () async {
      final bigBrain = FakeBigBrainClient(bearerToken: 'token');
      final credentials = await resolveCredentialsFromEnv(
        envFromMap({convexDeploymentEnvVar: 'dev:my-dep'}),
        bigBrain: bigBrain,
        readGlobalConfigFn: () => 'token',
      );
      expect(bigBrain.authorizeWithinProjectCalled, isTrue);
      expect(credentials.url, 'https://authorized.convex.cloud');
      expect(credentials.adminKey, 'authorized-admin-key');
    });

    test('authorizes prod deployment when prod flag is set', () async {
      final bigBrain = FakeBigBrainClient(bearerToken: 'token');
      await resolveCredentialsFromEnv(
        envFromMap({convexDeploymentEnvVar: 'prod:my-dep'}),
        prod: true,
        bigBrain: bigBrain,
        readGlobalConfigFn: () => 'token',
      );
      expect(bigBrain.authorizeProdCalled, isTrue);
    });

    test('fails when no credentials are available', () async {
      expect(
        () => resolveCredentialsFromEnv(envFromMap({})),
        throwsA(
          isA<Exception>().having(
            (e) => e.toString(),
            'message',
            contains('npx convex login'),
          ),
        ),
      );
    });
  });
}
