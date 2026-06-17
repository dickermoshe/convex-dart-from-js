int compareUTF8(String a, String b) {
  final aBytes = a.codeUnits.expand(_utf8BytesForCodeUnit).toList();
  final bBytes = b.codeUnits.expand(_utf8BytesForCodeUnit).toList();
  for (var i = 0; i < aBytes.length && i < bBytes.length; i++) {
    if (aBytes[i] != bBytes[i]) return aBytes[i] - bBytes[i];
  }
  return aBytes.length.compareTo(bBytes.length);
}

Iterable<int> _utf8BytesForCodeUnit(int code) {
  if (code < 0x80) return [code];
  if (code < 0x800) return [0xc0 | (code >> 6), 0x80 | (code & 0x3f)];
  return [
    0xe0 | (code >> 12),
    0x80 | ((code >> 6) & 0x3f),
    0x80 | (code & 0x3f),
  ];
}

int utf16LengthForCodePoint(int codePoint) => codePoint > 0xffff ? 2 : 1;
bool greaterThan(String a, String b) => compareUTF8(a, b) > 0;
bool greaterThanEq(String a, String b) => compareUTF8(a, b) >= 0;
bool lessThan(String a, String b) => compareUTF8(a, b) < 0;
bool lessThanEq(String a, String b) => compareUTF8(a, b) <= 0;
