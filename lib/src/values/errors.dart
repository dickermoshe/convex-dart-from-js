import 'value.dart';

/// Error data thrown by Convex functions.
class ConvexError<T> implements Exception {
  ConvexError(this.data, [String? message])
    : message =
          message ??
          (data is String ? data as String : stringifyValueForError(data));

  final T data;
  final String message;

  @override
  String toString() => 'ConvexError: $message';
}
