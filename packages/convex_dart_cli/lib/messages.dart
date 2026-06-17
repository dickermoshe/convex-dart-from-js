const missingCredentialsMessage =
    'Could not resolve deployment credentials. '
    'Run `npx convex login` and `npx convex dev` in this project.';

const deploymentWorkaround =
    'Workaround: run `npx convex deployment select dev` to use a cloud dev '
    'deployment, or set CONVEX_DEPLOY_KEY to a deploy key from the Convex '
    'dashboard.';

const localDeploymentUnsupportedMessage =
    'Local Convex deployments are not supported. $deploymentWorkaround';

const previewDeploymentUnsupportedMessage =
    'Preview deployments (CONVEX_DEPLOYMENT=preview:...) are not supported. '
    '$deploymentWorkaround';

const anonymousDeploymentUnsupportedMessage =
    'Anonymous Convex deployments are not supported. $deploymentWorkaround';

const deploymentSelectionUnsupportedMessage =
    'Selecting a deployment via --deployment is not supported. '
    'Workaround: run `npx convex deployment select dev` (or another deployment) '
    'to update CONVEX_DEPLOYMENT in .env.local, or set CONVEX_DEPLOY_KEY for CI.';

String formatCredentialError(Object error) {
  final text = error.toString();
  const prefix = 'Exception: ';
  if (text.startsWith(prefix)) {
    return text.substring(prefix.length);
  }
  return text;
}
