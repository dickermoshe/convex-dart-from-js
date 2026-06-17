import 'dart:convert';

import '../../values/errors.dart';
import 'function_result.dart';
import 'optimistic_updates.dart';
import 'udf_path_utils.dart';

typedef QueryResultsMap = Map<QueryToken, Query>;

class Query {
  Query({required this.result, required this.udfPath, required this.args});

  FunctionResult? result;
  final String udfPath;
  final Map<String, Object?> args;

  Map<String, Object?> toJsonLike() => {
    'result': result,
    'udfPath': udfPath,
    'args': args,
  };
}

class OptimisticQueryResults {
  QueryResultsMap _serverResults = {};
  QueryResultsMap _optimisticResults = {};
  final Map<int, OptimisticUpdate> _optimisticUpdates = {};
  final Map<int, Map<String, Object?>> _mutationArgs = {};

  List<QueryToken> ingestQueryResultsFromServer(
    QueryResultsMap queryTokenToValue,
    Set<int> completedRequests,
  ) {
    final old = _snapshot(_optimisticResults);
    _serverResults = Map.of(queryTokenToValue);
    for (final requestId in completedRequests) {
      _optimisticUpdates.remove(requestId);
      _mutationArgs.remove(requestId);
    }
    _recompute();
    return _changedTokens(old, _snapshot(_optimisticResults));
  }

  List<QueryToken> applyOptimisticUpdate(
    OptimisticUpdate update,
    int requestId,
    Map<String, Object?> args,
  ) {
    final old = _snapshot(_optimisticResults);
    _optimisticUpdates[requestId] = update;
    _mutationArgs[requestId] = args;
    _recompute();
    return _changedTokens(old, _snapshot(_optimisticResults));
  }

  FunctionResult? rawQueryResult(QueryToken token) =>
      _optimisticResults[token]?.result;

  Object? queryResult(QueryToken token) =>
      _queryValue(_optimisticResults[token]?.result);

  bool hasQueryResult(QueryToken token) =>
      _optimisticResults.containsKey(token) &&
      _optimisticResults[token]?.result != null;

  List<String>? queryLogs(QueryToken token) =>
      (_optimisticResults[token]?.result?['logLines'] as List?)?.cast<String>();

  void _recompute() {
    _optimisticResults = {
      for (final entry in _serverResults.entries)
        entry.key: Query(
          result: entry.value.result == null
              ? null
              : Map.of(entry.value.result!),
          udfPath: entry.value.udfPath,
          args: Map.of(entry.value.args),
        ),
    };
    final store = _OptimisticLocalStoreImpl(_optimisticResults);
    for (final entry in _optimisticUpdates.entries) {
      entry.value(store, _mutationArgs[entry.key] ?? const {});
    }
  }

  static Object? _queryValue(FunctionResult? result) {
    if (result == null) return null;
    if (result['success'] == true) return result['value'];
    throw ConvexError<Object?>(
      result['errorData'] ?? result['errorMessage'],
      message: result['errorMessage'] as String?,
    );
  }

  Map<String, String> _snapshot(QueryResultsMap map) => {
    for (final entry in map.entries)
      entry.key: jsonEncode(
        entry.value.toJsonLike(),
        toEncodable: (value) =>
            value is BigInt ? '${value}n' : value.toString(),
      ),
  };

  List<QueryToken> _changedTokens(
    Map<String, String> old,
    Map<String, String> next,
  ) {
    final keys = {...old.keys, ...next.keys};
    return [
      for (final key in keys)
        if (old[key] != next[key]) key,
    ];
  }
}

class _OptimisticLocalStoreImpl implements OptimisticLocalStore {
  _OptimisticLocalStoreImpl(this.results);

  final QueryResultsMap results;

  @override
  Object? getQuery(String query, [Map<String, Object?>? args]) {
    final token = serializePathAndArgs(query, args ?? const {});
    return OptimisticQueryResults._queryValue(results[token]?.result);
  }

  @override
  List<({Map<String, Object?> args, Object? value})> getAllQueries(
    String query,
  ) {
    final canonical = canonicalizeUdfPath(query);
    return [
      for (final result in results.values)
        if (result.udfPath == canonical)
          (
            args: result.args,
            value: OptimisticQueryResults._queryValue(result.result),
          ),
    ];
  }

  @override
  void setQuery(String query, Map<String, Object?> args, Object? value) {
    final canonical = canonicalizeUdfPath(query);
    final token = serializePathAndArgs(canonical, args);
    results[token] = Query(
      result: functionSuccess(value, const []),
      udfPath: canonical,
      args: args,
    );
  }
}
