import 'package:convex_dart/src/browser/sync/function_result.dart';
import 'package:test/test.dart';

void main() {
  group('function_result', () {
    test('functionSuccess shape', () {
      final result = functionSuccess('ok', ['line']);
      expect(result['success'], isTrue);
      expect(result['value'], 'ok');
      expect(result['logLines'], ['line']);
    });

    test('functionFailure shape with and without errorData', () {
      final basic = functionFailure('boom', ['err']);
      expect(basic['success'], isFalse);
      expect(basic['errorMessage'], 'boom');
      expect(basic.containsKey('errorData'), isFalse);

      final withData = functionFailure('boom', [], errorData: {'code': 1});
      expect(withData['errorData'], {'code': 1});
    });
  });
}
