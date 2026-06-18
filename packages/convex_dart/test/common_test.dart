import 'package:convex_dart/src/common/index.dart';
import 'package:convex_dart/src/browser.dart';
import 'package:test/test.dart';

void main() {
  group('common utilities', () {
    test('parseArgs handles null and nested maps', () {
      expect(parseArgs(null), isEmpty);
      expect(parseArgs({}), isEmpty);
      expect(
        parseArgs({
          'a': 1.0,
          'nested': {'b': BigInt.one},
        }),
        {
          'a': 1.0,
          'nested': {'b': BigInt.one},
        },
      );
    });

    test('validateDeploymentUrl accepts convex and localhost hosts', () {
      for (final url in [
        'https://happy-animal-123.convex.cloud',
        'https://custom.example.com',
        'http://localhost:3210',
        'http://127.0.0.1:3210',
      ]) {
        expect(() => validateDeploymentUrl(url), returnsNormally);
      }
    });

    test('validateDeploymentUrl rejects invalid hosts and schemes', () {
      for (final url in [
        'ftp://example.com',
        'https://app.convex.site',
        'not-a-url',
        '',
      ]) {
        expect(() => validateDeploymentUrl(url), throwsArgumentError);
      }
    });

    test('isSimpleObject identifies plain maps', () {
      expect(isSimpleObject(<String, Object?>{}), isTrue);
      expect(isSimpleObject({'a': 1}), isTrue);
      expect(isSimpleObject('x'), isFalse);
      expect(isSimpleObject([1]), isFalse);
    });

    test('convexMap round trips through wire encoding', () {
      final input = {'n': BigInt.one, 's': 'hi'};
      final output = convexMap(input);
      expect(output, {'n': BigInt.one, 's': 'hi'});
      expect(convexToJson(output), convexToJson(input));
    });
  });
}
