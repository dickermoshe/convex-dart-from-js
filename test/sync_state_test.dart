import 'package:convex_dart_from_js/src/browser/logging.dart';
import 'package:convex_dart_from_js/src/browser/sync/local_state.dart';
import 'package:convex_dart_from_js/src/browser/sync/request_manager.dart';
import 'package:test/test.dart';

void main() {
  group('LocalSyncState', () {
    test(
      'deduplicates subscriptions and emits remove after final unsubscribe',
      () {
        final state = LocalSyncState();
        final first = state.subscribe('messages.js:list', {'n': BigInt.one});
        final second = state.subscribe('messages:list', {'n': BigInt.one});

        expect(first.queryToken, second.queryToken);
        expect(first.modification, isNotNull);
        expect(second.modification, isNull);
        expect(second.unsubscribe(), isNull);
        final remove = first.unsubscribe();
        expect(remove?['type'], 'ModifyQuerySet');
        expect(
          ((remove?['modifications'] as List).single as Map)['type'],
          'Remove',
        );
      },
    );

    test('restart resends active queries and auth from base version zero', () {
      final state = LocalSyncState();
      state.subscribe('messages:list', {});
      state.setAuth('token');

      final (querySet, auth) = state.restart();
      expect(querySet['baseVersion'], 0);
      expect(querySet['newVersion'], 1);
      expect((querySet['modifications'] as List), hasLength(1));
      expect(auth?['type'], 'Authenticate');
      expect(auth?['baseVersion'], 0);
    });
  });

  group('RequestManager', () {
    test('replays mutations but fails actions on restart', () async {
      final manager = RequestManager(const NoopLogger(), () {});
      final mutation = manager.request({
        'type': 'Mutation',
        'requestId': 1,
        'udfPath': 'mutate',
        'args': [],
      }, true);
      final action = manager.request({
        'type': 'Action',
        'requestId': 2,
        'udfPath': 'act',
        'args': [],
      }, true);

      final restartMessages = manager.restart();
      expect(restartMessages.map((m) => m['type']), ['Mutation']);
      expect((await action)['success'], false);
      expect(manager.inflightMutations(), 1);
      expect(manager.inflightActions(), 0);

      manager.onResponse({
        'type': 'MutationResponse',
        'requestId': 1,
        'success': true,
        'result': 'ok',
        'ts': BigInt.one,
        'logLines': [],
      });
      expect(manager.hasInflightRequests(), isTrue);
      manager.removeCompleted(BigInt.one);
      expect((await mutation)['value'], 'ok');
      expect(manager.hasInflightRequests(), isFalse);
    });
  });
}
