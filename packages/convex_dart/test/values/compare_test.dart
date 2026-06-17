import 'dart:typed_data';

import 'package:convex_dart/browser.dart';
import 'package:test/test.dart';

void main() {
  group('compareValues type rank', () {
    final nullVal = null;
    final int64 = BigInt.one;
    final float64 = 1.0;
    final boolean = true;
    final string = 'a';
    final bytes = Uint8List.fromList([1]);
    final array = <Object?>[1.0];
    final object = <String, Object?>{'a': 1.0};

    final values = [
      nullVal,
      int64,
      float64,
      boolean,
      string,
      bytes,
      array,
      object,
    ];

    test('orders by Convex type rank', () {
      for (var i = 0; i < values.length; i++) {
        for (var j = 0; j < values.length; j++) {
          final cmp = compareValues(values[i], values[j]);
          if (i < j) expect(cmp, lessThan(0), reason: '$i vs $j');
          if (i == j) expect(cmp, 0);
          if (i > j) expect(cmp, greaterThan(0), reason: '$i vs $j');
        }
      }
    });

    test('int64 sorts before float64 at same numeric value', () {
      expect(compareValues(BigInt.one, 1.0), lessThan(0));
    });

    test('compares arrays lexicographically', () {
      expect(compareValues([1.0], [1.0, 2.0]), lessThan(0));
      expect(compareValues([1.0, 3.0], [1.0, 2.0]), greaterThan(0));
      expect(
        compareValues(
          [
            1.0,
            [2.0],
          ],
          [
            1.0,
            [3.0],
          ],
        ),
        lessThan(0),
      );
    });

    test('compares objects by sorted keys', () {
      expect(compareValues({'a': 1.0}, {'b': 1.0}), lessThan(0));
      expect(compareValues({'a': 1.0}, {'a': 2.0}), lessThan(0));
    });
  });

  group('UTF-8 string compare', () {
    test('compares multi-byte strings', () {
      expect(compareValues('a', 'b'), lessThan(0));
      expect(compareValues('ä', 'b'), greaterThan(0));
      expect(compareValues('🙂', '🙃'), lessThan(0));
    });
  });

  group('special doubles', () {
    test('compares NaN and infinity consistently', () {
      expect(compareValues(double.nan, double.nan), 0);
      expect(
        compareValues(double.infinity, double.negativeInfinity),
        greaterThan(0),
      );
      expect(compareValues(-0.0, 0.0), lessThan(0));
    });
  });
}
