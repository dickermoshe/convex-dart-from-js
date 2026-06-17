import 'dart:typed_data';

import 'compare_utf8.dart';
import 'value.dart';

/// Compare Convex values using Convex's canonical ordering.
int compareValues(Object? a, Object? b) => _compareComparable(
  _makeComparable(a, allowUndefined: true),
  _makeComparable(b, allowUndefined: true),
);

int _compareComparable(List<Object?> a, List<Object?> b) {
  final rank = (a[0] as int).compareTo(b[0] as int);
  if (rank != 0) return rank;
  return _compareSameRank(a[1], b[1]);
}

int _compareSameRank(Object? a, Object? b) {
  if (a == null) return 0;
  if (a is int && b is int) return a.compareTo(b);
  if (a is double && b is double) return compareDoubles(a, b);
  if (a is bool && b is bool) return a == b ? 0 : (a ? 1 : -1);
  if (a is String && b is String) return compareUtf8(a, b);
  if (a is List && b is List) {
    for (var i = 0; i < a.length && i < b.length; i++) {
      final cmp = _compareComparable(
        a[i] as List<Object?>,
        b[i] as List<Object?>,
      );
      if (cmp != 0) return cmp;
    }
    return a.length.compareTo(b.length);
  }
  throw StateError('Unexpected type $a');
}

List<Object?> _makeComparable(Object? value, {bool allowUndefined = false}) {
  if (value == null) return [1, null];
  if (value is int) return [2, value];
  if (value is double) return [3, value];
  if (value is bool) return [4, value];
  if (value is String) return [5, value];
  if (value is Uint8List) {
    return [6, value.map((byte) => _makeComparable(byte)).toList()];
  }
  if (value is List) {
    return [7, value.map(_makeComparable).toList()];
  }
  if (value is Map) {
    final map = value.cast<String, Object?>();
    final keys = map.keys.toList()..sort();
    return [
      8,
      keys.map((key) => _makeComparable([key, map[key]])).toList(),
    ];
  }
  if (allowUndefined) return [0, null];
  throw ArgumentError('Unexpected type $value');
}
