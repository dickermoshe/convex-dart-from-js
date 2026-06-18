import 'package:convex_dart/src/browser.dart';
import 'package:convex_dart/src/browser/sync/function_result.dart';
import 'package:convex_dart/src/browser/sync/optimistic_updates_impl.dart';
import 'package:convex_dart/src/browser/sync/udf_path_utils.dart';
import 'package:test/test.dart';

void main() {
  group('OptimisticQueryResults', () {
    OptimisticQueryResults makeResults() => OptimisticQueryResults();

    test('ingestQueryResultsFromServer replaces optimistic view', () {
      final results = makeResults();
      final token = serializePathAndArgs('messages:list', {});
      results.ingestQueryResultsFromServer({
        token: Query(
          result: functionSuccess(['a'], const []),
          udfPath: 'messages:list',
          args: {},
        ),
      }, {});
      expect(results.queryResult(token), ['a']);
    });

    test('applyOptimisticUpdate patches query before server confirms', () {
      final results = makeResults();
      final token = serializePathAndArgs('messages:list', {});
      results.ingestQueryResultsFromServer({
        token: Query(
          result: functionSuccess([], const []),
          udfPath: 'messages:list',
          args: {},
        ),
      }, {});
      results.applyOptimisticUpdate(
        (store, args) {
          store.setRawQuery('messages:list', {}, [args['body']]);
        },
        1,
        {'body': 'hi'},
      );
      expect(results.queryResult(token), ['hi']);
    });

    test('completed request clears optimistic update', () {
      final results = makeResults();
      final token = serializePathAndArgs('messages:list', {});
      results.ingestQueryResultsFromServer({
        token: Query(
          result: functionSuccess([], const []),
          udfPath: 'messages:list',
          args: {},
        ),
      }, {});
      results.applyOptimisticUpdate(
        (store, args) {
          store.setRawQuery('messages:list', {}, ['opt']);
        },
        9,
        {},
      );
      results.ingestQueryResultsFromServer(
        {
          token: Query(
            result: functionSuccess(['server'], const []),
            udfPath: 'messages:list',
            args: {},
          ),
        },
        {9},
      );
      expect(results.queryResult(token), ['server']);
    });

    test('query failure throws ConvexError', () {
      final results = makeResults();
      final token = serializePathAndArgs('messages:list', {});
      results.ingestQueryResultsFromServer({
        token: Query(
          result: functionFailure('bad', const [], errorData: {'code': 1}),
          udfPath: 'messages:list',
          args: {},
        ),
      }, {});
      expect(
        () => results.queryResult(token),
        throwsA(isA<ConvexError<Object?>>()),
      );
    });

    test('optimistic store getAllQueries via callback', () {
      final results = makeResults();
      final token = serializePathAndArgs('messages:list', {'n': BigInt.one});
      results.ingestQueryResultsFromServer({
        token: Query(
          result: functionSuccess(1, const []),
          udfPath: 'messages:list',
          args: {'n': BigInt.one},
        ),
      }, {});
      var allCount = 0;
      results.applyOptimisticUpdate(
        (store, _) {
          allCount = store.getAllRawQueries('messages:list').length;
        },
        1,
        {},
      );
      expect(allCount, 1);
    });
  });
}
