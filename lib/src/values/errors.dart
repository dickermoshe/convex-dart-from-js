import 'value.dart';

class ConvexError<TData extends Object?> implements Exception {
  ConvexError(this.data, {String? message}) : _message = message;

  TData data;
  final String? _message;

  String get message =>
      _message ??
      (data is String ? data as String : stringifyValueForError(data));

  @override
  String toString() => 'ConvexError: $message';
}
