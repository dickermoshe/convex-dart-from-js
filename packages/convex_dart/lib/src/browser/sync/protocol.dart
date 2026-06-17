import 'dart:convert';
import 'dart:typed_data';

import '../../values/base64.dart' as base64;

typedef RequestId = int;
typedef QueryId = int;
typedef QuerySetVersion = int;
typedef IdentityVersion = int;
typedef QueryJournal = String?;
typedef TS = BigInt;
typedef ClientMessage = Map<String, Object?>;
typedef ServerMessage = Map<String, Object?>;
typedef WireServerMessage = Map<String, Object?>;

BigInt u64ToLong(String encoded) {
  final bytes = base64.toByteArray(encoded);
  if (bytes.length != 8) {
    throw FormatException('Received ${bytes.length} bytes, expected 8 for u64');
  }
  var value = BigInt.zero;
  for (var i = 7; i >= 0; i--) {
    value = (value << 8) + BigInt.from(bytes[i]);
  }
  return value;
}

String longToU64(BigInt raw) {
  if (raw < BigInt.zero || raw >= (BigInt.one << 64)) {
    throw ArgumentError('U64 $raw does not fit into 64 bits.');
  }
  var value = raw;
  final bytes = Uint8List(8);
  for (var i = 0; i < 8; i++) {
    bytes[i] = (value & BigInt.from(0xff)).toInt();
    value >>= 8;
  }
  return base64.fromByteArray(bytes);
}

WireServerMessage parseServerMessage(Object encoded) {
  final message = _asMap(encoded);
  switch (message['type']) {
    case 'FatalError':
    case 'AuthError':
    case 'ActionResponse':
    case 'TransitionChunk':
    case 'Ping':
      return message;
    case 'MutationResponse':
      if (message['success'] == true && message['ts'] is String) {
        return {...message, 'ts': u64ToLong(message['ts']! as String)};
      }
      return message;
    case 'Transition':
      return {
        ...message,
        'startVersion': _decodeStateVersion(message['startVersion']),
        'endVersion': _decodeStateVersion(message['endVersion']),
      };
    default:
      throw FormatException('Unknown server message type ${message['type']}');
  }
}

ClientMessage encodeClientMessage(ClientMessage message) {
  if (message['type'] == 'Connect' &&
      message['maxObservedTimestamp'] is BigInt) {
    return {
      ...message,
      'maxObservedTimestamp': longToU64(
        message['maxObservedTimestamp']! as BigInt,
      ),
    };
  }
  return Map<String, Object?>.from(message);
}

WireServerMessage decodeServerMessage(Object? data) {
  final raw = data is String ? jsonDecode(data) : data;
  return parseServerMessage(raw as Object);
}

String encodeClientMessageToJson(ClientMessage message) =>
    jsonEncode(encodeClientMessage(message));

Map<String, Object?> _decodeStateVersion(Object? value) {
  final version = _asMap(value as Object);
  final ts = version['ts'];
  if (ts is String) {
    return {...version, 'ts': u64ToLong(ts)};
  }
  return version;
}

Map<String, Object?> _asMap(Object value) {
  if (value is! Map) throw FormatException('Invalid message: $value');
  return value.cast<String, Object?>();
}
