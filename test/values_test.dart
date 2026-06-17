import 'dart:typed_data';

import 'package:convex_dart_from_js/convex_dart_from_js.dart';
import 'package:test/test.dart';

void main() {
  group('values', () {
    test('encodes and decodes primitive and tagged values', () {
      expect(convexToJson(null), isNull);
      expect(convexToJson(true), isTrue);
      expect(convexToJson('x'), 'x');
      expect(convexToJson(1.5), 1.5);
      expect(convexToJson(1), {r'$integer': 'AQAAAAAAAAA='});
      expect(jsonToConvex({r'$integer': '//////////8='}), -1);

      final bytes = Uint8List.fromList([1, 2, 3]);
      expect(convexToJson(bytes), {r'$bytes': 'AQID'});
      expect(jsonToConvex({r'$bytes': 'AQID'}), bytes);
    });

    test('encodes special doubles as floats', () {
      final encodedNaN = convexToJson(double.nan) as Map<String, Object?>;
      expect(encodedNaN.keys.single, r'$float');

      final encodedInfinity =
          convexToJson(double.infinity) as Map<String, Object?>;
      expect(encodedInfinity.keys.single, r'$float');

      final encodedNegativeZero = convexToJson(-0.0) as Map<String, Object?>;
      expect(encodedNegativeZero.keys.single, r'$float');
      expect(isNegativeZero(jsonToConvex(encodedNegativeZero)), isTrue);
    });

    test('sorts object fields and validates names', () {
      expect(convexToJson({'b': 1, 'a': 2}), {
        'a': {r'$integer': 'AgAAAAAAAAA='},
        'b': {r'$integer': 'AQAAAAAAAAA='},
      });
      expect(() => convexToJson({r'$bad': 1}), throwsArgumentError);
      expect(() => jsonToConvex({'é': 1}), throwsArgumentError);
    });

    test('rejects malformed tagged values', () {
      expect(() => jsonToConvex({r'$bytes': 1}), throwsFormatException);
      expect(() => jsonToConvex({r'$integer': 'AQID'}), throwsFormatException);
      expect(() => jsonToConvex({r'$float': 'AQID'}), throwsFormatException);
      expect(() => jsonToConvex({r'$set': []}), throwsUnsupportedError);
      expect(() => jsonToConvex({r'$map': []}), throwsUnsupportedError);
    });
  });

  group('comparison and size', () {
    test('compares by Convex type rank', () {
      expect(compareValues(null, 1), lessThan(0));
      expect(compareValues(1, 2), lessThan(0));
      expect(compareValues(2.0, true), lessThan(0));
      expect(compareValues(false, true), lessThan(0));
      expect(compareValues('a', 'b'), lessThan(0));
      expect(compareValues(Uint8List.fromList([1]), [1]), lessThan(0));
    });

    test('calculates value and document sizes', () {
      expect(getConvexSize(null), 1);
      expect(getConvexSize(1), 9);
      expect(getConvexSize('abc'), 5);
      expect(getConvexSize(Uint8List.fromList([1, 2])), 4);
      expect(
        getDocumentSize({'name': 'Ada'}),
        getConvexSize({'name': 'Ada'}) + 38 + 23,
      );
    });
  });

  group('validators', () {
    test('emits Convex validator JSON', () {
      final validator = v.object({
        'id': v.id('users'),
        'name': v.string(),
        'age': v.optional(v.number()),
        'tags': v.array(v.string()),
        'kind': v.literal('user'),
      });
      expect(validator.json, {
        'type': 'object',
        'value': {
          'id': {
            'fieldType': {'type': 'id', 'tableName': 'users'},
            'optional': false,
          },
          'name': {
            'fieldType': {'type': 'string'},
            'optional': false,
          },
          'age': {
            'fieldType': {'type': 'number'},
            'optional': true,
          },
          'tags': {
            'fieldType': {
              'type': 'array',
              'value': {'type': 'string'},
            },
            'optional': false,
          },
          'kind': {
            'fieldType': {'type': 'literal', 'value': 'user'},
            'optional': false,
          },
        },
      });
    });

    test('supports object helpers', () {
      final validator = v.object({'a': v.string(), 'b': v.number()});
      expect(validator.pick(['a']).json['value'], contains('a'));
      expect(validator.omit(['b']).json['value'], isNot(contains('b')));
      expect(
        ((validator.partial().json['value'] as Map)['a'] as Map)['optional'],
        isTrue,
      );
      expect(validator.extend({'c': v.boolean()}).json['value'], contains('c'));
    });
  });
}
