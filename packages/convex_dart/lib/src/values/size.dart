/// Calculate the size of a Convex value in bytes.
///
/// This matches the Rust implementation used to compute bandwidth and document
/// size limits in Convex.
library;

import 'dart:convert';
import 'dart:typed_data';

import 'value.dart';

/// Estimated size contribution of the `_id` system field when absent.
const systemFieldIdEstimate = 38;

/// Estimated size contribution of the `_creationTime` system field when absent.
const systemFieldCreationTimeSize = 23;

/// Returns the size in bytes of a Convex [value].
///
/// This matches how Convex calculates document size for bandwidth tracking and
/// size limit enforcement.
int getConvexSize(Object? value) {
  if (value is ConvexUndefined) return 0;
  if (value == null || value is bool) return 1;
  if (value is BigInt || value is double || value is int) return 9;
  if (value is String) return 2 + utf8.encode(value).length;
  if (value is Uint8List) return 2 + value.length;
  if (value is ByteBuffer) return 2 + value.lengthInBytes;
  if (value is List) {
    return 2 +
        value.fold<int>(0, (sum, element) => sum + getConvexSize(element));
  }
  if (value is Map) {
    var size = 2;
    for (final entry in value.cast<String, Object?>().entries) {
      if (entry.value is! ConvexUndefined) {
        size += utf8.encode(entry.key).length + 1 + getConvexSize(entry.value);
      }
    }
    return size;
  }
  throw ArgumentError('Unsupported value type: ${value.runtimeType}');
}

/// Returns the size in bytes of a Convex document [value], including system
/// fields when they are absent.
int getDocumentSize(Map<String, Object?> value, {int? customIdLength}) {
  final baseSize = getConvexSize(value);
  final hasId = value.containsKey('_id') && value['_id'] is! ConvexUndefined;
  final hasCreationTime =
      value.containsKey('_creationTime') &&
      value['_creationTime'] is! ConvexUndefined;
  var additionalSize = 0;
  if (!hasId) {
    additionalSize += customIdLength == null
        ? systemFieldIdEstimate
        : customIdLength + 6;
  }
  if (!hasCreationTime) {
    additionalSize += systemFieldCreationTimeSize;
  }
  return baseSize + additionalSize;
}
