import 'dart:io';

String requireEnv(String name) {
  final value = Platform.environment[name];
  if (value == null || value.isEmpty) {
    throw StateError(
      'Missing required environment variable $name for integration tests',
    );
  }
  return value;
}

String? optionalEnv(String name) {
  final value = Platform.environment[name];
  if (value == null || value.isEmpty) {
    return null;
  }
  return value;
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
