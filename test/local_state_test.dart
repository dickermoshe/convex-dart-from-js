import 'package:convex_dart/src/browser/sync/local_state.dart';
import 'package:test/test.dart';

void main() {
  group('LocalSyncState extended', () {
    test('transition updates journal on QueryUpdated', () {
      final state = LocalSyncState();
      final sub = state.subscribe('messages:list', {});
      final queryId =
          (sub.modification!['modifications']! as List)
                  .cast<Map<String, Object?>>()
                  .single['queryId']
              as int;
      state.transition({
        'modifications': [
          {'type': 'QueryUpdated', 'queryId': queryId, 'journal': 'j1'},
        ],
      });
      expect(state.queryJournal(sub.queryToken), 'j1');
    });

    test('pause buffers subscribe modifications until resume', () {
      final state = LocalSyncState();
      state.pause();
      final sub = state.subscribe('messages:list', {});
      expect(sub.modification, isNotNull);
      expect(state.restart().$1['newVersion'], 1);
      final (querySet, auth) = state.resume();
      expect(querySet, isNull);
      expect(auth, isNull);
      sub.unsubscribe();
    });

    test('setAdminAuth and clearAuth messages', () {
      final state = LocalSyncState();
      final admin = state.setAdminAuth('admin-token', {'user': 'x'});
      expect(admin['tokenType'], 'Admin');
      expect(admin['impersonating'], {'user': 'x'});
      final cleared = state.clearAuth();
      expect(cleared['tokenType'], 'None');
      expect(state.hasAuth(), isFalse);
    });

    test('isNewAuth detects token changes', () {
      final state = LocalSyncState();
      state.setAuth('a');
      expect(state.isNewAuth('a'), isFalse);
      expect(state.isNewAuth('b'), isTrue);
    });

    test('hasSyncedPastLastReconnect tracks outstanding queries', () {
      final state = LocalSyncState();
      state.subscribe('a:list', {});
      state.restart();
      expect(state.hasSyncedPastLastReconnect(), isFalse);
      state.transition({
        'modifications': [
          {'type': 'QueryUpdated', 'queryId': 0},
        ],
      });
      expect(state.hasSyncedPastLastReconnect(), isTrue);
    });

    test('queryPath and queryArgs resolve by id', () {
      final state = LocalSyncState();
      final sub = state.subscribe('messages:list', {'n': 1.0});
      final id = state.queryId('messages:list', {'n': 1.0});
      expect(state.queryPath(id!), 'messages:list');
      expect(state.queryArgs(id), {'n': 1.0});
      expect(state.queryToken(id), sub.queryToken);
    });
  });
}
