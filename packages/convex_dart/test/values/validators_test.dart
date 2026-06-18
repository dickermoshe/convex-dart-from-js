import 'package:convex_dart/src/browser.dart';
import 'package:test/test.dart';

void main() {
  group('individual validators', () {
    test('emits primitive validator JSON', () {
      expect(v.string().json, {'type': 'string'});
      expect(v.number().json, {'type': 'number'});
      expect(v.boolean().json, {'type': 'boolean'});
      expect(v.null_().json, {'type': 'null'});
      expect(v.bytes().json, {'type': 'bytes'});
      expect(v.int64().json, {'type': 'bigint'});
      expect(v.any().json, {'type': 'any'});
      expect(v.id('users').json, {'type': 'id', 'tableName': 'users'});
    });

    test('emits literal, array, record, and union JSON', () {
      expect(v.literal('x').json, {'type': 'literal', 'value': 'x'});
      expect(v.array(v.string()).json, {
        'type': 'array',
        'value': {'type': 'string'},
      });
      expect(v.record(v.string(), v.number()).json, {
        'type': 'record',
        'keys': {'type': 'string'},
        'values': {
          'fieldType': {'type': 'number'},
          'optional': false,
        },
      });
      expect(v.union(v.string(), v.number()).json, {
        'type': 'union',
        'value': [
          {'type': 'string'},
          {'type': 'number'},
        ],
      });
    });

    test('optional and nullable validators', () {
      expect(v.optional(v.string()).isOptional, isTrue);
      expect(v.nullable(v.string()).json['type'], 'union');
    });

    test('object helpers on nested validators', () {
      final validator = v.object({
        'a': v.string(),
        'b': v.number(),
        'c': v.object({'d': v.boolean()}),
      });
      expect(
        (validator.pick(['a', 'c']).json['value'] as Map).keys,
        containsAll(['a', 'c']),
      );
      expect(
        (validator.omit(['b']).json['value'] as Map).containsKey('b'),
        isFalse,
      );
      expect(
        ((validator.partial().json['value'] as Map)['a'] as Map)['optional'],
        isTrue,
      );
      expect(validator.extend({'e': v.bytes()}).json['value'], contains('e'));
    });

    test('rejects invalid record and literal validators', () {
      expect(
        () => v.record(v.optional(v.string()), v.string()),
        throwsArgumentError,
      );
      expect(
        () => v.record(v.string(), v.optional(v.string())),
        throwsArgumentError,
      );
      expect(() => v.literal(Object()), throwsArgumentError);
      expect(() => v.id(''), throwsArgumentError);
    });
  });
}
