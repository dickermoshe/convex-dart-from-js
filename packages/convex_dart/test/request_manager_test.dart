import 'package:convex_dart/src/browser/logging.dart';
import 'package:convex_dart/src/browser/sync/request_manager.dart';
import 'package:test/test.dart';

void main() {
  group('RequestManager extended', () {
    test('completes successful action immediately', () async {
      final manager = RequestManager(const NoopLogger(), () {});
      final future = manager.request({
        'type': 'Action',
        'requestId': 1,
        'udfPath': 'act',
        'args': [],
      }, true);
      manager.onResponse({
        'type': 'ActionResponse',
        'requestId': 1,
        'success': true,
        'result': 'done',
        'logLines': [],
      });
      final result = await future;
      expect(result['success'], isTrue);
      expect(result['value'], 'done');
      expect(manager.hasInflightRequests(), isFalse);
    });

    test('mutation failure completes on response', () async {
      final manager = RequestManager(const NoopLogger(), () {});
      final future = manager.request({
        'type': 'Mutation',
        'requestId': 2,
        'udfPath': 'mut',
        'args': [],
      }, true);
      manager.onResponse({
        'type': 'MutationResponse',
        'requestId': 2,
        'success': false,
        'result': 'failed',
        'logLines': [],
      });
      final result = await future;
      expect(result['success'], isFalse);
      expect(manager.inflightMutations(), 0);
    });

    test('tracks concurrent mutations', () {
      final manager = RequestManager(const NoopLogger(), () {});
      manager.request({
        'type': 'Mutation',
        'requestId': 1,
        'udfPath': 'a',
        'args': [],
      }, true);
      manager.request({
        'type': 'Action',
        'requestId': 2,
        'udfPath': 'b',
        'args': [],
      }, true);
      expect(manager.inflightMutations(), 1);
      expect(manager.inflightActions(), 1);
      expect(manager.hasInflightRequests(), isTrue);
    });

    test('resume sends not-sent requests', () {
      final manager = RequestManager(const NoopLogger(), () {});
      manager.request({
        'type': 'Mutation',
        'requestId': 3,
        'udfPath': 'mut',
        'args': [],
      }, false);
      final messages = manager.resume();
      expect(messages, hasLength(1));
      expect(messages.single['requestId'], 3);
    });

    test('removeCompleted clears mutations at timestamp', () async {
      final manager = RequestManager(const NoopLogger(), () {});
      final future = manager.request({
        'type': 'Mutation',
        'requestId': 4,
        'udfPath': 'mut',
        'args': [],
      }, true);
      manager.onResponse({
        'type': 'MutationResponse',
        'requestId': 4,
        'success': true,
        'result': 'ok',
        'ts': BigInt.from(5),
        'logLines': [],
      });
      final completed = manager.removeCompleted(BigInt.from(5));
      expect(completed[4]!['value'], 'ok');
      expect(await future, completed[4]);
      expect(manager.hasInflightRequests(), isFalse);
    });
  });
}
