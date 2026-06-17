import 'dart:io';

import 'package:dotenv/dotenv.dart';
import 'package:path/path.dart' as p;

const convexDeployKeyEnvVar = 'CONVEX_DEPLOY_KEY';
const convexDeploymentTokenEnvVar = 'CONVEX_DEPLOYMENT_TOKEN';
const convexDeploymentEnvVar = 'CONVEX_DEPLOYMENT';
const convexUrlEnvVar = 'CONVEX_URL';
const convexSelfHostedUrlEnvVar = 'CONVEX_SELF_HOSTED_URL';
const convexSelfHostedAdminKeyEnvVar = 'CONVEX_SELF_HOSTED_ADMIN_KEY';
const envVarFilePath = '.env.local';

/// Loads environment variables from files and the process environment.
///
/// Precedence (highest first):
/// 1. [envFile] if provided
/// 2. `.env.local` in [workingDirectory]
/// 3. `.env` in [workingDirectory]
/// 4. [Platform.environment] (file values overwrite platform vars)
DotEnv loadEnv({String? envFile, String? workingDirectory}) {
  final cwd = workingDirectory ?? Directory.current.path;
  final dotenv = DotEnv(quiet: true, includePlatformEnvironment: true);

  if (envFile != null) {
    final path = p.isAbsolute(envFile) ? envFile : p.join(cwd, envFile);
    dotenv.load([path]);
  } else {
    // Later files overwrite earlier ones; .env.local wins over .env (JS parity).
    dotenv.load([p.join(cwd, '.env'), p.join(cwd, envVarFilePath)]);
  }

  return dotenv;
}

String? envGet(DotEnv env, String name) {
  final value = env[name];
  if (value == null || value.isEmpty) return null;
  return value;
}

/// Processes `CONVEX_DEPLOY_KEY` / `CONVEX_DEPLOYMENT_TOKEN` sentinel values.
String? processDeployKeyValue(String? deployKey) {
  if (deployKey == null) return null;
  if (deployKey == '<ignore_deploy_key>') return null;

  final missingKeyMatch = RegExp(
    r'^<missing_deploy_key:(.+)>$',
  ).firstMatch(deployKey);
  if (missingKeyMatch != null) {
    throw Exception(missingKeyMatch.group(1));
  }

  return deployKey;
}

String? readDeployKeyFromEnv(DotEnv env) =>
    processDeployKeyValue(envGet(env, convexDeployKeyEnvVar)) ??
    processDeployKeyValue(envGet(env, convexDeploymentTokenEnvVar));

/// Given `dev:tall-forest-1234`, returns `tall-forest-1234`.
String stripDeploymentTypePrefix(String deployment) =>
    deployment.split(':').last;

/// Anonymous agent-mode deployments use names like `anonymous-...`.
bool isAnonymousDeployment(String deploymentName) =>
    deploymentName.startsWith('anonymous-');

/// Returns `dev`, `prod`, `preview`, `local`, or null if no recognized prefix.
String? getDeploymentTypeFromConfiguredDeployment(String raw) {
  final typeRaw = raw.split(':').first;
  if (typeRaw == 'prod' ||
      typeRaw == 'dev' ||
      typeRaw == 'preview' ||
      typeRaw == 'local') {
    return typeRaw;
  }
  return null;
}

bool isDeploymentKey(String key) => RegExp(r'^(dev|prod):.*\|').hasMatch(key);

bool isPreviewDeployKey(String key) {
  final parts = key.split('|');
  return parts.length >= 2 && parts[0].startsWith('preview:');
}

bool isProjectKey(String key) => key.startsWith('project:');

/// Parses `preview:team:project|...` preview deploy keys.
({String teamSlug, String projectSlug}) teamAndProjectFromPreviewDeployKey(
  String deployKey,
) {
  final parts = deployKey.split('|').first.split(':');
  if (parts.length != 3 || parts[0] != 'preview') {
    throw Exception(
      'Malformed preview CONVEX_DEPLOY_KEY, get a new key from Project Settings.',
    );
  }
  return (teamSlug: parts[1], projectSlug: parts[2]);
}
