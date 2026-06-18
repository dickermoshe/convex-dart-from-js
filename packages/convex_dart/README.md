# convex_dart

Dart port of the Convex JavaScript browser client from `convex-js` at `npm/1.41.0`.

## Overview

This package maps `convex-js/src/browser/*` and `convex-js/src/values/*` to Dart
equivalents:

- **HTTP client** — [ConvexHttpClient] for queries, mutations, and actions over HTTP
- **WebSocket client** — [ConvexClient] and [BaseConvexClient] for reactive subscriptions
- **Values** — Convex wire format encoding, validators, and size utilities

Import `package:convex_dart/browser.dart` for the public API.

## Parity

Behavior is intended to match the upstream JavaScript client for wire format,
state transitions, error forwarding, auth behavior, value conversion, logging,
and edge cases. See [docs/convex_js_parity.md](../../docs/convex_js_parity.md)
for the audit matrix.

## Intentional Dart differences

- HTTP transport injection uses [ConvexHttpClientOptions.httpClient], not upstream
  `fetch` / `setFetch` / `setFetchOptions`.
- Dart [parseArgs] accepts `Map<String, Object?>?`, so non-object argument
  validation is largely enforced by the type system.
- [ConvexError] stores an optional message to model JavaScript's ability to
  construct `ConvexError(errorMessage)` and then mutate `.data`.

## API documentation

Generate API docs with:

    dart doc

Output is written to `doc/api/`.

## Related packages

- `convex_dart_cli` — CLI helpers ported from selected `convex-js` CLI utilities
- `example` — sample integration

[ConvexHttpClient]: lib/src/browser/http_client.dart
[ConvexClient]: lib/src/browser/simple_client.dart
[BaseConvexClient]: lib/src/browser/sync/client.dart
[ConvexHttpClientOptions.httpClient]: lib/src/browser/http_client.dart
[parseArgs]: lib/src/common/index.dart
[ConvexError]: lib/src/values/errors.dart
