# Convex JS Port Notes

This package ports the raw client-oriented parts of `third-party/convex-js` at
tag `npm/1.41.0`.

## Source Mapping

Values:

- `src/values/value.ts` -> `lib/src/values/value.dart`
- `src/values/base64.ts` -> `lib/src/values/base64.dart`
- `src/values/errors.ts` -> `lib/src/values/errors.dart`
- `src/values/compare.ts` -> `lib/src/values/compare.dart`
- `src/values/compare_utf8.ts` -> `lib/src/values/compare_utf8.dart`
- `src/values/size.ts` -> `lib/src/values/size.dart`
- `src/values/validator.ts` and `src/values/validators.ts` -> `lib/src/values/validator.dart` and `lib/src/values/validators.dart`

Common and browser clients:

- `src/common/index.ts` -> `lib/src/common/index.dart`
- `src/browser/http_client.ts` -> `lib/src/browser/http_client.dart`
- `src/browser/logging.ts` -> `lib/src/browser/logging.dart`
- `src/browser/simple_client.ts` -> `lib/src/browser/simple_client.dart`

WebSocket sync:

- `src/browser/sync/protocol.ts` -> `lib/src/browser/sync/protocol.dart`
- `src/browser/sync/web_socket_manager.ts` -> `lib/src/browser/sync/web_socket_manager.dart`
- `src/browser/sync/client.ts` -> `lib/src/browser/sync/client.dart`
- `src/browser/sync/local_state.ts` -> `lib/src/browser/sync/local_state.dart`
- `src/browser/sync/remote_query_set.ts` -> `lib/src/browser/sync/remote_query_set.dart`
- `src/browser/sync/request_manager.ts` -> `lib/src/browser/sync/request_manager.dart`
- `src/browser/sync/authentication_manager.ts` -> `lib/src/browser/sync/authentication_manager.dart`
- `src/browser/sync/optimistic_updates.ts` and `optimistic_updates_impl.ts` -> `lib/src/browser/sync/optimistic_updates.dart` and `optimistic_updates_impl.dart`
- `src/browser/sync/function_result.ts` -> `lib/src/browser/sync/function_result.dart`
- `src/browser/sync/session.ts` -> `lib/src/browser/sync/session.dart`
- `src/browser/sync/udf_path_utils.ts` -> `lib/src/browser/sync/udf_path_utils.dart`

## Intentional Public Scope

- Public function references are raw string UDF paths, e.g. `messages:list`.
- Convex Int64 values are represented as Dart `BigInt`.
- Convex Float64 values are represented as Dart `double`.
- React, Next.js, server runtime, CLI, codegen, generated type-safe clients, and experimental public APIs are not exposed.

## Test Coverage

- `test/values_test.dart`: value wire format, comparison, size, validators.
- `test/protocol_test.dart`: common helpers, U64 protocol fields, message encode/decode, UDF token serialization.
- `test/http_client_test.dart`: raw HTTP client request shape, auth headers, mutation queue, errors.
- `test/sync_state_test.dart`: local sync state and request replay behavior.
- `test/web_socket_manager_test.dart`: WebSocket state manager, pings, transition chunks, pause/resume.
- `test/websocket_client_test.dart`: raw WebSocket client subscription, transitions, mutation completion, optimistic updates.
