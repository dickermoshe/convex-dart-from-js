import '../values/value.dart';

Map<String, Object?> parseArgs(Map<String, Object?>? args) {
  if (args == null) return <String, Object?>{};
  return args;
}

void validateDeploymentUrl(String deploymentUrl) {
  final uri = Uri.tryParse(deploymentUrl);
  if (uri == null || !uri.hasScheme || uri.host.isEmpty) {
    throw ArgumentError(
      'Invalid deployment address: "$deploymentUrl" is not a valid URL.',
    );
  }
  if (uri.scheme != 'http' && uri.scheme != 'https') {
    throw ArgumentError(
      'Invalid deployment address: Must start with "https://" or "http://". Found "$deploymentUrl".',
    );
  }
  if (deploymentUrl.endsWith('.convex.site')) {
    throw ArgumentError(
      'Invalid deployment address: "$deploymentUrl" ends with .convex.site, which is used for HTTP Actions.',
    );
  }
}

bool isSimpleObject(Object? value) => value is Map<String, Object?>;

Map<String, Object?> convexMap(Map<String, Object?> map) =>
    jsonToConvex(convexToJson(map)) as Map<String, Object?>;
