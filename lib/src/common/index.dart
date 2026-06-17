import '../values/value.dart';

Map<String, Object?> parseArgs(Map<String, Object?>? args) {
  if (args == null) return <String, Object?>{};
  return args;
}

void validateDeploymentUrl(String deploymentUrl) {
  final uri = Uri.tryParse(deploymentUrl);
  if (uri == null || !uri.hasScheme || uri.host.isEmpty) {
    throw ArgumentError('Provided address was not an absolute URL.');
  }
  if (uri.scheme != 'http' && uri.scheme != 'https') {
    throw ArgumentError('Unknown parent protocol ${uri.scheme}');
  }
  if (uri.host == 'localhost' ||
      uri.host == '127.0.0.1' ||
      uri.host.endsWith('.convex.cloud') ||
      uri.host.endsWith('.convex.site')) {
    return;
  }
  throw ArgumentError(
    'Invalid Convex deployment URL $deploymentUrl. If running a self-hosted backend, set skipConvexDeploymentUrlCheck.',
  );
}

bool isSimpleObject(Object? value) => value is Map<String, Object?>;

Map<String, Object?> convexMap(Map<String, Object?> map) =>
    jsonToConvex(convexToJson(map)) as Map<String, Object?>;
