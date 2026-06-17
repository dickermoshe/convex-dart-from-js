import 'dart:convert';
import 'dart:typed_data';

import '../../values/base64.dart' as base64;

typedef RequestId = int;
typedef QueryId = int;
typedef QuerySetVersion = int;
typedef IdentityVersion = int;
typedef QueryJournal = String?;

int u64FromBase64(String encoded) {
  final bytes = base64.toByteArray(encoded);
  if (bytes.length != 8) {
    throw FormatException('Received ${bytes.length} bytes, expected 8 for u64');
  }
  return ByteData.sublistView(bytes).getUint64(0, Endian.little);
}

String u64ToBase64(int value) {
  final bytes = Uint8List(8);
  ByteData.sublistView(bytes).setUint64(0, value, Endian.little);
  return base64.fromByteArray(bytes);
}

Map<String, Object?> decodeServerMessage(Object? data) {
  final raw = data is String ? jsonDecode(data) : data;
  if (raw is! Map) throw FormatException('Invalid server message: $data');
  final message = raw.cast<String, Object?>();
  if (message['type'] == 'Transition') {
    for (final key in const ['startVersion', 'endVersion']) {
      final version = (message[key] as Map).cast<String, Object?>();
      final ts = version['ts'];
      if (ts is String) version['ts'] = u64FromBase64(ts);
      message[key] = version;
    }
  } else if (message['type'] == 'MutationResponse' &&
      message['success'] == true &&
      message['ts'] is String) {
    message['ts'] = u64FromBase64(message['ts'] as String);
  }
  return message;
}

String encodeClientMessage(Map<String, Object?> message) {
  final encoded = Map<String, Object?>.from(message);
  if (encoded['type'] == 'Connect' && encoded['maxObservedTimestamp'] is int) {
    encoded['maxObservedTimestamp'] = u64ToBase64(
      encoded['maxObservedTimestamp'] as int,
    );
  }
  return jsonEncode(encoded);
}
