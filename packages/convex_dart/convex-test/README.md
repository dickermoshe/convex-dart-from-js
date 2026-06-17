Minimal Convex deployment used by `test/integration/` in the parent package and in `convex_dart_cli`.

To run auth integration tests locally, generate a matching custom JWT provider keypair and token:

```sh
node scripts/generate-integration-keys.mjs
export CONVEX_AUTH_TOKEN="$(node scripts/sign-integration-jwt.mjs)"
npx convex dev --once
```

CI runs the same scripts before deploying the integration backend.
