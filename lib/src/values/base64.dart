import 'dart:convert';
import 'dart:typed_data';

/// Returns the decoded byte length of a padded base64 string.
int byteLength(String b64) => toByteArray(b64).length;

/// Decode standard or URL-safe base64 into bytes.
Uint8List toByteArray(String b64) {
  var normalized = b64.replaceAll('-', '+').replaceAll('_', '/');
  final remainder = normalized.length % 4;
  if (remainder != 0) {
    normalized = normalized.padRight(normalized.length + 4 - remainder, '=');
  }
  return base64.decode(normalized);
}

/// Encode bytes as standard padded base64.
String fromByteArray(Uint8List bytes) => base64.encode(bytes);

/// Encode bytes as URL-safe base64 without padding.
String fromByteArrayUrlSafeNoPadding(Uint8List bytes) =>
    base64Url.encode(bytes).replaceAll('=', '');
