# Convex JS Port Notes

This package ports the raw client-oriented parts of `third-party/convex-js`.

## Source Mapping

- `src/values/value.ts` -> `lib/src/values/value.dart`
- `src/values/base64.ts` -> `lib/src/values/base64.dart`
- `src/values/compare.ts` and `compare_utf8.ts` -> `lib/src/values/compare.dart`
- `src/values/size.ts` -> `lib/src/values/size.dart`
- `src/values/errors.ts` -> `lib/src/values/errors.dart`
- `src/values/validator.ts` and `validators.ts` -> `lib/src/values/validator_builder.dart` and `validators.dart`
- `src/common/index.ts` -> `lib/src/common/`
- `src/browser/http_client.ts` -> `lib/src/browser/http_client.dart`
- Stable raw WebSocket client behavior from `src/browser/simple_client.ts` and `src/browser/sync/` -> `lib/src/browser/client.dart` and `lib/src/browser/sync/`

## Intentional Exclusions

- React, Next.js, server runtime, CLI, bundler, and codegen modules.
- Experimental pagination APIs.
- TypeScript-only generated API typing.
- Admin/component internal APIs.
- Debug metrics reporting.

## Dart Value Shape

Callers use native Dart values: `null`, `bool`, `int`, `double`, `String`,
`Uint8List`, `List`, and `Map<String, Object?>`. The Convex serializer maps
Dart `int` to Convex Int64 and Dart `double` to Convex Float64.
