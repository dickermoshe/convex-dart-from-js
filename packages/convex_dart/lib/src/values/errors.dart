import 'value.dart';

/// An error thrown by Convex functions with structured [data].
///
/// When the server forwards error data, [data] contains the structured payload
/// and [message] preserves the server error message when available.
///
/// Dart stores an optional [message] to model JavaScript's ability to
/// construct `ConvexError(errorMessage)` and then mutate `.data`.
class ConvexError<TData extends Object?> implements Exception {
  /// Creates a [ConvexError] with [data] and an optional [message].
  ConvexError(this.data, {String? message}) : _message = message;

  /// Structured error data from the Convex function.
  TData data;

  final String? _message;

  /// A human-readable error message.
  String get message =>
      _message ??
      (data is String ? data as String : stringifyValueForError(data));

  @override
  String toString() => 'ConvexError: $message';
}
