import 'package:convex_dart/src/browser/sync/web_socket_manager.dart';

/// In-memory WebSocket for unit tests.
class FakeSocket implements SyncWebSocket {
  FakeSocket();

  final sent = <String>[];

  @override
  void Function(int code, String reason)? onClose;

  @override
  void Function(Object error)? onError;

  @override
  void Function(Object? data)? onMessage;

  @override
  void Function()? onOpen;

  void open() => onOpen?.call();

  void message(String data) => onMessage?.call(data);

  void closeWith([int code = closeNormal, String reason = '']) =>
      onClose?.call(code, reason);

  @override
  void close() => closeWith();

  @override
  void send(String message) => sent.add(message);
}
