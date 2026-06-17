import 'dart:io';

String? optionalJwtEnv(String name) {
  final value = optionalEnv(name)?.trim();
  if (value == null) return null;
  final token = value.startsWith('Bearer ') ? value.substring(7).trim() : value;
  if (!_looksLikeJwt(token)) return null;
  return token;
}

String requireJwtEnv(String name) {
  final token = optionalJwtEnv(name);
  if (token == null) {
    throw StateError(
      'Missing valid JWT in $name for integration tests. '
      'Expected three base64url-encoded parts separated by dots.',
    );
  }
  return token;
}

String requireEnv(String name) {
  final value = Platform.environment[name];
  if (value == null || value.isEmpty) {
    throw StateError(
      'Missing required environment variable $name for integration tests',
    );
  }
  return value;
}

bool _looksLikeJwt(String value) {
  final parts = value.split('.');
  if (parts.length != 3 || parts.any((part) => part.isEmpty)) {
    return false;
  }
  final base64UrlPattern = RegExp(r'^[A-Za-z0-9_-]+$');
  return parts.every((part) => base64UrlPattern.hasMatch(part));
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
