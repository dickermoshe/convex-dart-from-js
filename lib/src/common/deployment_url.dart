/// Validate a Convex deployment URL.
void validateDeploymentUrl(String deploymentUrl) {
  if (!deploymentUrl.startsWith('http:') &&
      !deploymentUrl.startsWith('https:')) {
    throw ArgumentError(
      'Invalid deployment address: Must start with "https://" or "http://". Found "$deploymentUrl".',
    );
  }
  final uri = Uri.tryParse(deploymentUrl);
  if (uri == null || !uri.hasScheme || uri.host.isEmpty) {
    throw ArgumentError(
      'Invalid deployment address: "$deploymentUrl" is not a valid URL. If you believe this URL is correct, use the skipConvexDeploymentUrlCheck option to bypass this.',
    );
  }
  if (deploymentUrl.endsWith('.convex.site')) {
    throw ArgumentError(
      'Invalid deployment address: "$deploymentUrl" ends with .convex.site, which is used for HTTP Actions.',
    );
  }
}
