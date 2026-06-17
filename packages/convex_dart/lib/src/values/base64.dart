import 'dart:convert' as convert;
import 'dart:typed_data';

int byteLength(String b64) => toByteArray(b64).length;

Uint8List toByteArray(String b64) => convert.base64.decode(b64);

String fromByteArray(Uint8List uint8) => convert.base64.encode(uint8);

String fromByteArrayUrlSafeNoPadding(Uint8List uint8) =>
    convert.base64Url.encode(uint8).replaceAll('=', '');
