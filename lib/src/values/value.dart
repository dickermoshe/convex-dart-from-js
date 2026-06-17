import 'dart:convert';
import 'dart:math' as math;
import 'dart:typed_data';

import 'base64.dart' as base64;

const _minInt64 = -9223372036854775808;
const _maxInt64 = 9223372036854775807;
const _maxIdentifierLen = 1024;
const _maxValueForErrorLen = 16384;

typedef JSONValue = Object?;
typedef ConvexValue = Object?;

bool _isSpecialDouble(double n) =>
    n.isNaN || !n.isFinite || (n == 0.0 && n.isNegative);

Uint8List _int64Bytes(int value) {
  if (value < _minInt64 || value > _maxInt64) {
    throw ArgumentError(
      'Int $value does not fit into a 64-bit signed integer.',
    );
  }
  final bytes = Uint8List(8);
  ByteData.sublistView(bytes).setInt64(0, value, Endian.little);
  return bytes;
}

/// Encode a signed 64-bit integer as little-endian base64.
String int64ToBase64(int value) => base64.fromByteArray(_int64Bytes(value));

/// Decode a signed 64-bit integer from little-endian base64.
int base64ToInt64(String encoded) {
  final bytes = base64.toByteArray(encoded);
  if (bytes.length != 8) {
    throw FormatException(
      'Received ${bytes.length} bytes, expected 8 for \$integer',
    );
  }
  return ByteData.sublistView(bytes).getInt64(0, Endian.little);
}

Uint8List _doubleBytes(double value) {
  final bytes = Uint8List(8);
  ByteData.sublistView(bytes).setFloat64(0, value, Endian.little);
  return bytes;
}

double _doubleFromBase64(String encoded) {
  final bytes = base64.toByteArray(encoded);
  if (bytes.length != 8) {
    throw FormatException(
      'Received ${bytes.length} bytes, expected 8 for \$float',
    );
  }
  return ByteData.sublistView(bytes).getFloat64(0, Endian.little);
}

void _validateObjectField(String key) {
  if (key.length > _maxIdentifierLen) {
    throw ArgumentError(
      'Field name $key exceeds maximum field name length $_maxIdentifierLen.',
    );
  }
  if (key.startsWith(r'$')) {
    throw ArgumentError(
      "Field name $key starts with a '\$', which is reserved.",
    );
  }
  for (var i = 0; i < key.length; i++) {
    final code = key.codeUnitAt(i);
    if (code < 32 || code >= 127) {
      throw ArgumentError(
        "Field name $key has invalid character '${key[i]}': Field names can only contain non-control ASCII characters",
      );
    }
  }
}

/// Parse a Convex value from its JSON wire representation.
Object? jsonToConvex(Object? value) {
  if (value == null || value is bool || value is num || value is String) {
    return value;
  }
  if (value is List) {
    return value.map(jsonToConvex).toList(growable: false);
  }
  if (value is! Map) {
    throw ArgumentError('Unexpected type of $value');
  }
  final map = value.cast<String, Object?>();
  if (map.length == 1) {
    final key = map.keys.single;
    switch (key) {
      case r'$bytes':
        final encoded = map[key];
        if (encoded is! String) {
          throw FormatException('Malformed \$bytes field on $value');
        }
        return base64.toByteArray(encoded);
      case r'$integer':
        final encoded = map[key];
        if (encoded is! String) {
          throw FormatException('Malformed \$integer field on $value');
        }
        return base64ToInt64(encoded);
      case r'$float':
        final encoded = map[key];
        if (encoded is! String) {
          throw FormatException('Malformed \$float field on $value');
        }
        final decoded = _doubleFromBase64(encoded);
        if (!_isSpecialDouble(decoded)) {
          throw FormatException('Float $decoded should be encoded as a number');
        }
        return decoded;
      case r'$set':
        throw UnsupportedError(
          'Received a Set which is no longer supported as a Convex type.',
        );
      case r'$map':
        throw UnsupportedError(
          'Received a Map which is no longer supported as a Convex type.',
        );
    }
  }
  final out = <String, Object?>{};
  for (final entry in map.entries) {
    _validateObjectField(entry.key);
    out[entry.key] = jsonToConvex(entry.value);
  }
  return out;
}

String stringifyValueForError(Object? value) {
  String str;
  try {
    str = jsonEncode(
      value,
      toEncodable: (object) {
        if (object is Uint8List) return base64.fromByteArray(object);
        return object.toString();
      },
    );
  } catch (_) {
    str = value.toString();
  }
  if (str.length > _maxValueForErrorLen) {
    const rest = '[...truncated]';
    return str.substring(0, _maxValueForErrorLen - rest.length) + rest;
  }
  return str;
}

Object? _convexToJsonInternal(Object? value, Object? original, String context) {
  if (value == null || value is bool || value is String) return value;
  if (value is int) {
    return {r'$integer': int64ToBase64(value)};
  }
  if (value is double) {
    if (_isSpecialDouble(value)) {
      return {r'$float': base64.fromByteArray(_doubleBytes(value))};
    }
    return value;
  }
  if (value is Uint8List) {
    return {r'$bytes': base64.fromByteArray(value)};
  }
  if (value is ByteBuffer) {
    return {r'$bytes': base64.fromByteArray(value.asUint8List())};
  }
  if (value is List) {
    return value
        .asMap()
        .entries
        .map(
          (entry) => _convexToJsonInternal(
            entry.value,
            original,
            '$context[${entry.key}]',
          ),
        )
        .toList(growable: false);
  }
  if (value is Map) {
    if (value.keys.any((key) => key is! String)) {
      throw ArgumentError(
        '${stringifyValueForError(value)} is not a supported Convex type.',
      );
    }
    final out = <String, Object?>{};
    final entries = value.cast<String, Object?>().entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));
    for (final entry in entries) {
      _validateObjectField(entry.key);
      out[entry.key] = _convexToJsonInternal(
        entry.value,
        original,
        '$context.${entry.key}',
      );
    }
    return out;
  }
  throw ArgumentError(
    '${stringifyValueForError(value)} is not a supported Convex type${context.isEmpty ? '' : ' (present at path $context in original object ${stringifyValueForError(original)})'}.',
  );
}

/// Convert a native Dart Convex value to Convex's JSON wire representation.
Object? convexToJson(Object? value) => _convexToJsonInternal(value, value, '');

/// True if [value] is a negative zero double.
bool isNegativeZero(Object? value) =>
    value is double && value == 0.0 && value.isNegative;

/// Compare two doubles with Convex's special NaN and negative-zero behavior.
int compareDoubles(double a, double b) {
  if (a.isNaN || b.isNaN) {
    final aBits = ByteData.sublistView(
      _doubleBytes(a),
    ).getInt64(0, Endian.little);
    final bBits = ByteData.sublistView(
      _doubleBytes(b),
    ).getInt64(0, Endian.little);
    final aSign = aBits < 0;
    final bSign = bBits < 0;
    if (a.isNaN != b.isNaN) {
      return a.isNaN ? (aSign ? -1 : 1) : (bSign ? 1 : -1);
    }
    if (aSign != bSign) return aSign ? -1 : 1;
    return aBits.compareTo(bBits);
  }
  if (a == b && a.isNegative == b.isNegative) return 0;
  if (a == 0.0 && a.isNegative) {
    return b == 0.0 ? -1 : -b.sign.toInt();
  }
  if (b == 0.0 && b.isNegative) {
    return a == 0.0 ? 1 : a.sign.toInt();
  }
  return a < b ? -1 : 1;
}

int signOf(num value) => value == 0 ? 0 : value.sign.toInt();

bool doublesEqual(double a, double b) =>
    (a.isNaN && b.isNaN) || (a == b && a.isNegative == b.isNegative);

int checkedInt64(int value) {
  if (value < _minInt64 || value > _maxInt64) {
    throw ArgumentError(
      'Int $value does not fit into a 64-bit signed integer.',
    );
  }
  return value;
}

int get maxInt64 => _maxInt64;
int get minInt64 => _minInt64;

double nanWithPayload(int payload) {
  final bytes = Uint8List(8);
  ByteData.sublistView(bytes).setUint64(0, math.max(payload, 1), Endian.little);
  return ByteData.sublistView(bytes).getFloat64(0, Endian.little);
}
