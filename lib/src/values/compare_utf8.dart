import 'dart:convert';

/// Compare strings as their UTF-8 byte sequences.
int compareUtf8(String a, String b) {
  final aBytes = utf8.encode(a);
  final bBytes = utf8.encode(b);
  final length = aBytes.length < bBytes.length ? aBytes.length : bBytes.length;
  for (var i = 0; i < length; i++) {
    final diff = aBytes[i] - bBytes[i];
    if (diff != 0) return diff;
  }
  return aBytes.length - bBytes.length;
}
