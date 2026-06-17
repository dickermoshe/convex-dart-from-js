import 'dart:typed_data';

import 'package:convex_dart/src/values/base64.dart';
import 'package:test/test.dart';

void main() {
  group('base64', () {
    test('round trips empty and standard vectors', () {
      expect(fromByteArray(Uint8List(0)), '');
      expect(toByteArray(''), Uint8List(0));
      final bytes = Uint8List.fromList([1, 2, 3]);
      expect(toByteArray(fromByteArray(bytes)), bytes);
    });

    test('byteLength matches decoded size', () {
      expect(byteLength('AQID'), 3);
      expect(byteLength(''), 0);
    });

    test('url-safe encoding strips padding', () {
      final encoded = fromByteArrayUrlSafeNoPadding(
        Uint8List.fromList([255, 255]),
      );
      expect(encoded.contains('='), isFalse);
    });

    test('rejects invalid base64', () {
      expect(() => toByteArray('!!!'), throwsFormatException);
    });
  });

  group('Int64 base64 fixtures', () {
    test('matches known wire values', () {
      expect(toByteArray('AAAAAAAAAAA='), Uint8List(8));
      expect(
        toByteArray('AQAAAAAAAAA='),
        Uint8List.fromList([1, 0, 0, 0, 0, 0, 0, 0]),
      );
      expect(
        toByteArray('//////////8='),
        Uint8List.fromList([255, 255, 255, 255, 255, 255, 255, 255]),
      );
    });
  });
}
