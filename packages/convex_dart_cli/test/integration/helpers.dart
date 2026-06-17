import 'dart:io';

import 'package:dotenv/dotenv.dart';

import '../../lib/env.dart';

({String deployKey, String url})? integrationDeployCredentials() {
  final deployKey = Platform.environment[convexDeployKeyEnvVar];
  final url = Platform.environment[convexUrlEnvVar];
  if (deployKey == null ||
      deployKey.isEmpty ||
      url == null ||
      url.isEmpty) {
    return null;
  }
  return (deployKey: deployKey, url: url);
}

DotEnv deployKeyEnv(String deployKey, String url) {
  final env = DotEnv(quiet: true);
  env.addAll({
    convexDeployKeyEnvVar: deployKey,
    convexUrlEnvVar: url,
  });
  return env;
}

Future<T> retry<T>(
  Future<T> Function() fn, {
  int maxAttempts = 3,
  Duration delay = const Duration(seconds: 1),
}) async {
  Object? lastError;
  for (var attempt = 1; attempt <= maxAttempts; attempt++) {
    try {
      return await fn();
    } catch (error) {
      lastError = error;
      if (attempt < maxAttempts) {
        await Future<void>.delayed(delay * attempt);
      }
    }
  }
  Error.throwWithStackTrace(lastError!, StackTrace.current);
}
