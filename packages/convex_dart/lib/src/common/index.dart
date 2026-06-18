import '../values/value.dart';

/// Validates and normalizes arguments to a Convex function.
///
/// Returns `{}` when [args] is `null`. In Dart, [args] is typed as a map, so
/// non-object argument validation is largely enforced by the type system.
Map<String, Object?> parseArgs(Map<String, Object?>? args) {
  if (args == null) return <String, Object?>{};
  return args;
}

/// Validates that [deploymentUrl] is a usable Convex deployment address.
///
/// Accepts any valid `http` or `https` URL except those ending in `.convex.site`.
/// Set [ConvexHttpClientOptions.skipConvexDeploymentUrlCheck] or
/// [BaseConvexClientOptions.skipConvexDeploymentUrlCheck] to bypass validation
/// for self-hosted deployments.
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

/// Whether [value] is a plain map suitable for Convex object fields.
bool isSimpleObject(Object? value) => value is Map<String, Object?>;

/// Round-trips a map through Convex JSON encoding and decoding.
Map<String, Object?> convexMap(Map<String, Object?> map) =>
    jsonToConvex(convexToJson(map)) as Map<String, Object?>;
