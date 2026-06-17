Minimal Convex deployment used by `test/integration/` in the parent package and in `convex_dart_cli`.

## CI secrets

The GitHub Actions integration job (`dart-test.yml`) expects these repository secrets:

| Secret | Purpose |
|--------|---------|
| `CONVEX_DEPLOY_KEY` | Deploys the backend via `npx convex deploy` and authenticates `convex_dart_cli` credential tests |
| `CONVEX_URL` | Deployment URL for Dart clients and CLI tests |
| `CONVEX_AUTH_TOKEN` | Valid test JWT for auth integration tests in `convex_dart` |

Create a dedicated Convex project (or deployment) for CI. Generate a **prod** or **dev** deploy key from Project Settings and store it as `CONVEX_DEPLOY_KEY`. Set `CONVEX_URL` to that deployment's URL.

## Local integration tests

```bash
# Deploy (or use an existing dev deployment)
cd packages/convex_dart/convex-test
CONVEX_DEPLOY_KEY='dev:...|...' npx convex deploy

# convex_dart HTTP/WebSocket tests
CONVEX_URL='https://....convex.cloud' \
CONVEX_AUTH_TOKEN='...' \
dart test packages/convex_dart/test/integration/

# convex_dart_cli credential + function-spec tests
CONVEX_URL='https://....convex.cloud' \
CONVEX_DEPLOY_KEY='dev:...|...' \
dart test packages/convex_dart_cli/test/integration/
```

Unit tests skip integration tests automatically when env vars are unset (`dart_test.yaml`).
