import 'package:dotenv/dotenv.dart';

import 'big_brain.dart';
import 'env.dart';
import 'local_deployment.dart';
import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;

class DeploymentCredentials {
  const DeploymentCredentials({required this.url, required this.adminKey});

  final String url;
  final String adminKey;
}

Future<DeploymentCredentials> resolveCredentials({
  String? envFile,
  bool prod = false,
  String? workingDirectory,
  BigBrainClient? bigBrain,
  String? Function()? readGlobalConfigFn,
  LocalDeploymentConfig? Function(String deploymentName)?
  loadLocalDeploymentConfigFn,
}) async {
  final env = loadEnv(envFile: envFile, workingDirectory: workingDirectory);
  return resolveCredentialsFromEnv(
    env,
    prod: prod,
    workingDirectory: workingDirectory,
    bigBrain: bigBrain,
    readGlobalConfigFn: readGlobalConfigFn,
    loadLocalDeploymentConfigFn: loadLocalDeploymentConfigFn,
  );
}

Future<DeploymentCredentials> resolveCredentialsFromEnv(
  DotEnv env, {
  bool prod = false,
  String? workingDirectory,
  BigBrainClient? bigBrain,
  String? Function()? readGlobalConfigFn,
  LocalDeploymentConfig? Function(String deploymentName)?
  loadLocalDeploymentConfigFn,
}) async {
  final selfHostedUrl = envGet(env, convexSelfHostedUrlEnvVar);
  final selfHostedAdminKey = envGet(env, convexSelfHostedAdminKeyEnvVar);
  if (selfHostedUrl != null && selfHostedAdminKey != null) {
    return DeploymentCredentials(
      url: selfHostedUrl,
      adminKey: selfHostedAdminKey,
    );
  }

  final deployKey = readDeployKeyFromEnv(env);
  if (deployKey != null) {
    return _resolveDeployKeyCredentials(
      deployKey,
      env: env,
      prod: prod,
      bigBrain: bigBrain,
    );
  }

  final convexDeployment = envGet(env, convexDeploymentEnvVar);
  if (convexDeployment == null) {
    throw Exception(_missingCredentialsMessage);
  }

  final deploymentName = stripDeploymentTypePrefix(convexDeployment);
  final deploymentType = getDeploymentTypeFromConfiguredDeployment(
    convexDeployment,
  );

  if (deploymentType == 'local') {
    final localConfig =
        (loadLocalDeploymentConfigFn ??
        (name) => loadLocalDeploymentConfig(
          name,
          projectDir: workingDirectory,
        ))(deploymentName);
    if (localConfig == null) {
      throw Exception(
        'No local deployment found. Run `npx convex dev --configure`.',
      );
    }
    return DeploymentCredentials(
      url: localDeploymentUrl(localConfig.cloudPort),
      adminKey: localConfig.adminKey,
    );
  }

  final accessToken = (readGlobalConfigFn ?? readAccessToken)();
  if (accessToken == null) {
    throw Exception(_missingCredentialsMessage);
  }

  final client = bigBrain ?? BigBrainClient(bearerToken: accessToken);
  try {
    final response = prod
        ? await client.authorizeProd(deploymentName: deploymentName)
        : await client.authorizeWithinCurrentProject(
            deploymentName: deploymentName,
            deploymentType: deploymentType ?? 'dev',
          );
    return DeploymentCredentials(
      url: response.url,
      adminKey: response.adminKey,
    );
  } finally {
    if (bigBrain == null) {
      client.close();
    }
  }
}

/// Reads the Convex CLI access token from `~/.convex/config.json`.
///
/// That file is created by `npx convex login` and holds the credentials used
/// to authorize deployments via the Convex platform API.
///
/// Returns the `accessToken` string, or `null` if the file is missing,
/// unreadable, or does not contain a valid token.
String? readAccessToken() {
  final home =
      Platform.environment['USERPROFILE'] ?? Platform.environment['HOME'];
  if (home == null || home.isEmpty) return null;

  final file = File(p.join(home, '.convex', 'config.json'));
  if (!file.existsSync()) return null;

  try {
    final json = jsonDecode(file.readAsStringSync()) as Map<String, Object?>;
    final token = json['accessToken'];
    if (token is! String || token.isEmpty) return null;
    return token;
  } on Object {
    return null;
  }
}

const _missingCredentialsMessage =
    'Could not resolve deployment credentials. '
    'Run `npx convex login` and `npx convex dev` in this project.';

Future<DeploymentCredentials> _resolveDeployKeyCredentials(
  String deployKey, {
  required DotEnv env,
  required bool prod,
  BigBrainClient? bigBrain,
}) async {
  if (isPreviewDeployKey(deployKey)) {
    final slugs = teamAndProjectFromPreviewDeployKey(deployKey);
    final client = bigBrain ?? BigBrainClient(bearerToken: deployKey);
    try {
      final response = await client.provisionAndAuthorize(
        teamSlug: slugs.teamSlug,
        projectSlug: slugs.projectSlug,
        deploymentType: prod ? 'prod' : 'dev',
      );
      return DeploymentCredentials(
        url: response.url,
        adminKey: response.adminKey,
      );
    } finally {
      if (bigBrain == null) client.close();
    }
  }

  if (isProjectKey(deployKey)) {
    final client = bigBrain ?? BigBrainClient(bearerToken: deployKey);
    try {
      final response = await client.provisionAndAuthorize(
        deploymentType: prod ? 'prod' : 'dev',
      );
      return DeploymentCredentials(
        url: response.url,
        adminKey: response.adminKey,
      );
    } finally {
      if (bigBrain == null) client.close();
    }
  }

  if (isDeploymentKey(deployKey)) {
    final resolvedUrl = envGet(env, convexUrlEnvVar);
    if (resolvedUrl != null) {
      return DeploymentCredentials(url: resolvedUrl, adminKey: deployKey);
    }

    final client = bigBrain ?? BigBrainClient(bearerToken: deployKey);
    try {
      return DeploymentCredentials(
        url: await client.urlForDeployKey(deployKey),
        adminKey: deployKey,
      );
    } finally {
      if (bigBrain == null) client.close();
    }
  }

  throw Exception('Unrecognized deploy key format.');
}
