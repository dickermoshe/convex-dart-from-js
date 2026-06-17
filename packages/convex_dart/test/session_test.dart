import 'package:convex_dart/src/browser/sync/session.dart';
import 'package:test/test.dart';

void main() {
  group('session', () {
    test('newSessionId is 32 hex chars and unique', () {
      final ids = {for (var i = 0; i < 100; i++) newSessionId()};
      expect(ids, hasLength(100));
      for (final id in ids) {
        expect(id, hasLength(32));
        expect(RegExp(r'^[0-9a-f]{32}$').hasMatch(id), isTrue);
      }
    });
  });
}
