import 'package:convex_dart/src/browser/logging.dart';
import 'package:convex_dart/src/browser/sync/remote_query_set.dart';
import 'package:test/test.dart';

void main() {
  group('RemoteQuerySet', () {
    RemoteQuerySet makeSet() =>
        RemoteQuerySet((id) => 'path:$id', const NoopLogger());

    Map<String, Object?> transition({
      required int startQuerySet,
      required int endQuerySet,
      required List<Map<String, Object?>> modifications,
      BigInt? startTs,
      BigInt? endTs,
      int identity = 0,
    }) {
      final start = startTs ?? BigInt.zero;
      final end = endTs ?? BigInt.zero;
      return {
        'startVersion': {
          'querySet': startQuerySet,
          'ts': start,
          'identity': identity,
        },
        'endVersion': {
          'querySet': endQuerySet,
          'ts': end,
          'identity': identity,
        },
        'modifications': modifications,
      };
    }

    test('applies QueryUpdated and advances version', () {
      final set = makeSet();
      set.transition(
        transition(
          startQuerySet: 0,
          endQuerySet: 1,
          endTs: BigInt.one,
          modifications: [
            {
              'type': 'QueryUpdated',
              'queryId': 0,
              'value': 'hello',
              'logLines': [],
              'journal': null,
            },
          ],
        ),
      );
      final results = set.remoteQueryResults();
      expect(results[0]!['success'], isTrue);
      expect(results[0]!['value'], 'hello');
      expect(set.version['querySet'], 1);
      expect(set.timestamp(), BigInt.one);
    });

    test('applies QueryFailed with errorData', () {
      final set = makeSet();
      set.transition(
        transition(
          startQuerySet: 0,
          endQuerySet: 1,
          modifications: [
            {
              'type': 'QueryFailed',
              'queryId': 1,
              'errorMessage': 'bad',
              'logLines': [],
              'errorData': {'code': 'x'},
            },
          ],
        ),
      );
      final result = set.remoteQueryResults()[1]!;
      expect(result['success'], isFalse);
      expect(result['errorMessage'], 'bad');
      expect(result['errorData'], {'code': 'x'});
    });

    test('removes queries on QueryRemoved', () {
      final set = makeSet();
      set.transition(
        transition(
          startQuerySet: 0,
          endQuerySet: 1,
          modifications: [
            {'type': 'QueryUpdated', 'queryId': 0, 'value': 1, 'logLines': []},
          ],
        ),
      );
      set.transition(
        transition(
          startQuerySet: 1,
          endQuerySet: 2,
          modifications: [
            {'type': 'QueryRemoved', 'queryId': 0},
          ],
        ),
      );
      expect(set.remoteQueryResults().containsKey(0), isFalse);
    });

    test('throws on invalid start version', () {
      final set = makeSet();
      expect(
        () => set.transition(
          transition(startQuerySet: 5, endQuerySet: 6, modifications: []),
        ),
        throwsStateError,
      );
    });

    test('throws on unknown modification type', () {
      final set = makeSet();
      expect(
        () => set.transition(
          transition(
            startQuerySet: 0,
            endQuerySet: 1,
            modifications: [
              {'type': 'Bad', 'queryId': 0},
            ],
          ),
        ),
        throwsStateError,
      );
    });
  });
}
