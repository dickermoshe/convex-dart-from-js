import 'dart:typed_data';

import 'compare_utf8.dart';
import 'value.dart';

int compareValues(Object? k1, Object? k2) =>
    _compareAsTuples(_makeComparable(k1), _makeComparable(k2));

int _compareAsTuples(List<Object?> a, List<Object?> b) {
  final rankA = a[0] as int;
  final rankB = b[0] as int;
  if (rankA == rankB) return _compareSameTypeValues(a[1], b[1]);
  return rankA < rankB ? -1 : 1;
}

int _compareSameTypeValues(Object? v1, Object? v2) {
  if (v1 is ConvexUndefined || v1 == null) return 0;
  if (v1 is double) {
    if (v2 is! double) throw StateError('Unexpected type $v2');
    return compareDoubles(v1, v2);
  }
  if (v1 is String) {
    if (v2 is! String) throw StateError('Unexpected type $v2');
    return compareUTF8(v1, v2);
  }
  if (v1 is BigInt) return v1.compareTo(v2 as BigInt).sign;
  if (v1 is bool) return v1 == v2 ? 0 : (v1 ? 1 : -1);
  if (v1 is! List || v2 is! List) throw StateError('Unexpected type $v1');
  for (var i = 0; i < v1.length && i < v2.length; i++) {
    final cmp = _compareAsTuples(
      v1[i] as List<Object?>,
      v2[i] as List<Object?>,
    );
    if (cmp != 0) return cmp;
  }
  return v1.length.compareTo(v2.length).sign;
}

List<Object?> _makeComparable(Object? v) {
  if (v is ConvexUndefined) return [0, v];
  if (v == null) return [1, null];
  if (v is BigInt) return [2, v];
  if (v is double) return [3, v];
  if (v is int) return [3, v.toDouble()];
  if (v is bool) return [4, v];
  if (v is String) return [5, v];
  if (v is Uint8List) {
    return [6, v.map((byte) => _makeComparable(byte.toDouble())).toList()];
  }
  if (v is ByteBuffer) {
    return [
      6,
      v.asUint8List().map((byte) => _makeComparable(byte.toDouble())).toList(),
    ];
  }
  if (v is List) return [7, v.map(_makeComparable).toList()];
  if (v is Map) {
    final keys = v.keys.cast<String>().toList()..sort();
    final pojo = keys.map((k) => [k, v[k]]).toList();
    return [8, pojo.map(_makeComparable).toList()];
  }
  throw StateError('Unexpected type $v');
}
