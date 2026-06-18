/// Utilities for working with values stored in Convex.
///
/// See the full set of supported types at
/// [Types](https://docs.convex.dev/using/types).
library;

import 'dart:convert';
import 'dart:typed_data';

import 'base64.dart' as base64;

/// A JSON-serializable value.
typedef JSONValue = Object?;

/// A value supported by Convex.
///
/// Values can be stored in documents and used as arguments and return types to
/// Convex functions. See [Types](https://docs.convex.dev/using/types).
typedef Value = Object?;

/// The types of [Value] that can represent numbers.
typedef NumericValue = Object;

const _minInt64 = -9223372036854775808;
const _maxInt64 = 9223372036854775807;

/// Minimum 64-bit signed integer representable in Convex.
final BigInt minInt64 = BigInt.from(_minInt64);

/// Maximum 64-bit signed integer representable in Convex.
final BigInt maxInt64 = BigInt.from(_maxInt64);

final BigInt _twoTo63 = BigInt.one << 63;
final BigInt _twoTo64 = BigInt.one << 64;
const _maxIdentifierLen = 1024;
const _maxValueForErrorLen = 16384;

final class ConvexUndefined {
  const ConvexUndefined();
  @override
  String toString() => 'undefined';
}

/// Sentinel value representing JavaScript `undefined` in optional object fields.
const convexUndefined = ConvexUndefined();

bool _isSpecial(double n) =>
    n.isNaN || !n.isFinite || (n == 0.0 && n.isNegative);

Uint8List _bigIntBytes(BigInt value) {
  if (value < minInt64 || value > maxInt64) {
    throw ArgumentError(
      'BigInt $value does not fit into a 64-bit signed integer.',
    );
  }
  var unsigned = value;
  if (unsigned < BigInt.zero) {
    unsigned += _twoTo64;
  }
  final bytes = Uint8List(8);
  for (var i = 0; i < 8; i++) {
    bytes[i] = (unsigned & BigInt.from(0xff)).toInt();
    unsigned >>= 8;
  }
  return bytes;
}

String bigIntToBase64(BigInt value) =>
    base64.fromByteArray(_bigIntBytes(value));

BigInt base64ToBigInt(String encoded) {
  final bytes = base64.toByteArray(encoded);
  if (bytes.length != 8) {
    throw FormatException(
      'Received ${bytes.length} bytes, expected 8 for \$integer',
    );
  }
  var value = BigInt.zero;
  for (var i = 7; i >= 0; i--) {
    value = (value << 8) + BigInt.from(bytes[i]);
  }
  if (value >= _twoTo63) {
    value -= _twoTo64;
  }
  return value;
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

/// Validates that [key] is a legal Convex object field name.
void validateObjectField(String key) {
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

/// Converts Convex JSON wire format into Dart [Value] objects.
Object? jsonToConvex(Object? value) {
  if (value == null || value is bool || value is String) {
    return value;
  }
  if (value is num) {
    return value.toDouble();
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
        return base64ToBigInt(encoded);
      case r'$float':
        final encoded = map[key];
        if (encoded is! String) {
          throw FormatException('Malformed \$float field on $value');
        }
        final decoded = _doubleFromBase64(encoded);
        if (!_isSpecial(decoded)) {
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
      case r'$undefined':
        return convexUndefined;
    }
  }
  final out = <String, Object?>{};
  for (final entry in map.entries) {
    validateObjectField(entry.key);
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
        if (object is BigInt) return '${object}n';
        if (object is Uint8List) return base64.fromByteArray(object);
        if (object is ConvexUndefined) return 'undefined';
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

Object? _convexToJsonInternal(
  Object? value,
  Object? originalValue,
  String context,
  bool includeTopLevelUndefined,
) {
  if (value is ConvexUndefined) {
    if (includeTopLevelUndefined) return {r'$undefined': null};
    final contextText = context.isEmpty
        ? ''
        : ' (present at path $context in original object ${stringifyValueForError(originalValue)})';
    throw ArgumentError(
      "undefined is not a valid Convex value$contextText. To learn about Convex's supported types, see https://docs.convex.dev/using/types.",
    );
  }
  if (value == null || value is bool || value is String) return value;
  if (value is BigInt) {
    return {r'$integer': bigIntToBase64(value)};
  }
  if (value is double) {
    if (_isSpecial(value)) {
      return {r'$float': base64.fromByteArray(_doubleBytes(value))};
    }
    return value;
  }
  if (value is int) {
    return value.toDouble();
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
            originalValue,
            '$context[${entry.key}]',
            false,
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
      validateObjectField(entry.key);
      final v = entry.value;
      if (v is ConvexUndefined) {
        if (includeTopLevelUndefined) {
          out[entry.key] = {r'$undefined': null};
        }
      } else {
        out[entry.key] = _convexToJsonInternal(
          v,
          originalValue,
          '$context.${entry.key}',
          false,
        );
      }
    }
    return out;
  }
  final path = context.isEmpty
      ? ''
      : ' (present at path $context in original object ${stringifyValueForError(originalValue)})';
  throw ArgumentError(
    '${stringifyValueForError(value)} is not a supported Convex type$path. To learn about Convex\'s supported types, see https://docs.convex.dev/using/types.',
  );
}

/// Converts a Dart [Value] into Convex JSON wire format.
Object? convexToJson(Object? value) =>
    _convexToJsonInternal(value, value, '', false);

Object? convexOrUndefinedToJson(Object? value) =>
    value is ConvexUndefined ? {r'$undefined': null} : convexToJson(value);

Object? patchValueToJson(Object? value) =>
    _convexToJsonInternal(value, value, '', true);

bool isNegativeZero(Object? value) =>
    value is double && value == 0.0 && value.isNegative;

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
  if (a == 0.0 && a.isNegative) return b == 0.0 ? -1 : -b.sign.toInt();
  if (b == 0.0 && b.isNegative) return a == 0.0 ? 1 : a.sign.toInt();
  return a < b ? -1 : 1;
}
