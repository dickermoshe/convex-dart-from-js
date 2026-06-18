import 'package:convex_dart/src/browser.dart';
import 'package:test/test.dart';

void main() {
  group('value wire format extended', () {
    test('round trips strings unicode and emoji', () {
      for (final value in ['', 'hello', 'äöü', '🙂🙃']) {
        expect(jsonToConvex(convexToJson(value)), value);
      }
    });

    test('round trips Int64 boundaries', () {
      for (final value in [minInt64, maxInt64, BigInt.zero, BigInt.from(-1)]) {
        expect(jsonToConvex(convexToJson(value)), value);
      }
    });

    test('rejects out-of-range BigInt', () {
      expect(() => convexToJson(maxInt64 + BigInt.one), throwsArgumentError);
      expect(() => convexToJson(minInt64 - BigInt.one), throwsArgumentError);
    });

    test('round trips arrays and nested objects', () {
      final value = {
        'items': [BigInt.one, 'x', true],
        'nested': {'a': 1.5},
      };
      expect(jsonToConvex(convexToJson(value)), {
        'items': [BigInt.one, 'x', true],
        'nested': {'a': 1.5},
      });
    });

    test('convexOrUndefinedToJson and patchValueToJson', () {
      expect(convexOrUndefinedToJson(convexUndefined), {r'$undefined': null});
      expect(patchValueToJson({'a': convexUndefined}), {
        'a': {r'$undefined': null},
      });
      expect(() => convexToJson(convexUndefined), throwsArgumentError);
    });

    test('stringifyValueForError truncates long values', () {
      final long = 'x' * 20000;
      final str = stringifyValueForError(long);
      expect(str.length, lessThanOrEqualTo(16384));
      expect(str.contains('[...truncated]'), isTrue);
    });

    test('rejects field names starting with dollar', () {
      expect(() => validateObjectField(r'$bad'), throwsArgumentError);
      expect(() => validateObjectField('é'), throwsArgumentError);
    });

    test('encodes NaN and infinities as float tags', () {
      for (final value in [
        double.nan,
        double.infinity,
        double.negativeInfinity,
        -0.0,
      ]) {
        final encoded = convexToJson(value);
        expect(encoded, isA<Map<dynamic, dynamic>>());
        expect((encoded as Map).keys.single, r'$float');
        expect(jsonToConvex(encoded), value);
        if (value == -0.0) {
          expect(isNegativeZero(jsonToConvex(encoded)), isTrue);
        }
      }
    });

    test('json numbers decode as double', () {
      expect(jsonToConvex(42), 42.0);
      expect(jsonToConvex([1, 2]), [1.0, 2.0]);
    });

    test('rejects unsupported convex types in convexToJson', () {
      expect(() => convexToJson(DateTime.now()), throwsArgumentError);
      expect(() => convexToJson({1: 'bad'}), throwsArgumentError);
    });
  });

  group('ConvexError', () {
    test('uses message and data', () {
      final error = ConvexError({'code': 'x'}, message: 'boom');
      expect(error.message, 'boom');
      expect(error.data, {'code': 'x'});
      expect(error.toString(), contains('boom'));
    });

    test('derives message from string data', () {
      final error = ConvexError<String>('plain');
      expect(error.message, 'plain');
    });
  });
}
