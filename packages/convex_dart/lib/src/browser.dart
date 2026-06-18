/// Tools for accessing Convex from Dart applications.
///
/// This library is a Dart port of the Convex JavaScript `convex/browser` module
/// from `convex-js` at `npm/1.41.0`. It maps `convex-js/src/browser/*` and
/// `convex-js/src/values/*` to Dart equivalents: HTTP and WebSocket clients,
/// reactive sync, and Convex value wire format.
library;

export 'browser/http_client.dart';
export 'browser/simple_client.dart';
export 'browser/sync/client.dart';
export 'browser/sync/optimistic_updates.dart';
export 'browser/sync/udf_path_utils.dart' show QueryToken;
export 'values/index.dart';
