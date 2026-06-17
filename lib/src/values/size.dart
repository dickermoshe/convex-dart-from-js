import 'dart:convert';
import 'dart:typed_data';

/// Estimated size of an `_id` field when it is absent.
const systemFieldIdEstimate = 38;

/// Size of the `_creationTime` system field.
const systemFieldCreationTimeSize = 23;

/// Calculate the size in bytes of a Convex value.
int getConvexSize(Object? value) {
  if (value == null) return 1;
  if (value is bool) return 1;
  if (value is int) return 9;
  if (value is double) return 9;
  if (value is String) return 2 + utf8.encode(value).length;
  if (value is Uint8List) return 2 + value.length;
  if (value is List) {
    return 2 + value.fold<int>(0, (sum, item) => sum + getConvexSize(item));
  }
  if (value is Map) {
    final map = value.cast<String, Object?>();
    var size = 2;
    for (final entry in map.entries) {
      size += utf8.encode(entry.key).length + 1 + getConvexSize(entry.value);
    }
    return size;
  }
  throw ArgumentError('Unsupported value type: ${value.runtimeType}');
}

/// Calculate document size, adding missing Convex system fields.
int getDocumentSize(Map<String, Object?> value, {int? customIdLength}) {
  final baseSize = getConvexSize(value);
  final hasId = value.containsKey('_id') && value['_id'] != null;
  final hasCreationTime =
      value.containsKey('_creationTime') && value['_creationTime'] != null;
  if (hasId && hasCreationTime) {
    return baseSize;
  }
  var additional = 0;
  if (!hasId) {
    additional += customIdLength == null
        ? systemFieldIdEstimate
        : customIdLength + 6;
  }
  if (!hasCreationTime) {
    additional += systemFieldCreationTimeSize;
  }
  return baseSize + additional;
}
