import '../../values/value.dart';
import 'protocol.dart';
import 'udf_path_utils.dart';

typedef AuthState = Map<String, Object?>;

class LocalSyncState {
  int _nextQueryId = 0;
  int _querySetVersion = 0;
  int _identityVersion = 0;
  final Map<QueryToken, _LocalQuery> _querySet = {};
  final Map<int, QueryToken> _queryIdToToken = {};
  final Set<int> _outstandingQueriesOlderThanRestart = {};
  bool _outstandingAuthOlderThanRestart = false;
  bool _paused = false;
  final Map<int, Map<String, Object?>> _pendingQuerySetModifications = {};
  AuthState? _auth;

  bool hasSyncedPastLastReconnect() =>
      _outstandingQueriesOlderThanRestart.isEmpty &&
      !_outstandingAuthOlderThanRestart;

  void markAuthCompletion() {
    _outstandingAuthOlderThanRestart = false;
  }

  ({
    QueryToken queryToken,
    Map<String, Object?>? modification,
    Map<String, Object?>? Function() unsubscribe,
  })
  subscribe(
    String udfPath,
    Map<String, Object?> args, [
    QueryJournal journal,
    String? componentPath,
  ]) {
    final canonicalizedUdfPath = canonicalizeUdfPath(udfPath);
    final queryToken = serializePathAndArgs(canonicalizedUdfPath, args);
    final existingEntry = _querySet[queryToken];
    if (existingEntry != null) {
      existingEntry.numSubscribers += 1;
      return (
        queryToken: queryToken,
        modification: null,
        unsubscribe: () => _removeSubscriber(queryToken),
      );
    }
    final queryId = _nextQueryId++;
    final query = _LocalQuery(
      id: queryId,
      canonicalizedUdfPath: canonicalizedUdfPath,
      args: args,
      numSubscribers: 1,
      journal: journal,
      componentPath: componentPath,
    );
    _querySet[queryToken] = query;
    _queryIdToToken[queryId] = queryToken;
    final baseVersion = _querySetVersion;
    final newVersion = _querySetVersion + 1;
    final add = <String, Object?>{
      'type': 'Add',
      'queryId': queryId,
      'udfPath': canonicalizedUdfPath,
      'args': [convexToJson(args)],
      'journal': ?journal,
      'componentPath': ?componentPath,
    };
    if (_paused) {
      _pendingQuerySetModifications[queryId] = add;
    } else {
      _querySetVersion = newVersion;
    }
    return (
      queryToken: queryToken,
      modification: {
        'type': 'ModifyQuerySet',
        'baseVersion': baseVersion,
        'newVersion': newVersion,
        'modifications': [add],
      },
      unsubscribe: () => _removeSubscriber(queryToken),
    );
  }

  void transition(Map<String, Object?> transition) {
    for (final raw
        in (transition['modifications'] as List).cast<Map<String, Object?>>()) {
      final modification = raw.cast<String, Object?>();
      switch (modification['type']) {
        case 'QueryUpdated':
        case 'QueryFailed':
          _outstandingQueriesOlderThanRestart.remove(modification['queryId']);
          final journal = modification['journal'] as String?;
          if (journal != null) {
            final queryToken = _queryIdToToken[modification['queryId']];
            if (queryToken != null) _querySet[queryToken]?.journal = journal;
          }
          break;
        case 'QueryRemoved':
          _outstandingQueriesOlderThanRestart.remove(modification['queryId']);
          break;
        default:
          throw StateError('Invalid modification ${modification['type']}');
      }
    }
  }

  int? queryId(String udfPath, Map<String, Object?> args) {
    final queryToken = serializePathAndArgs(canonicalizeUdfPath(udfPath), args);
    return _querySet[queryToken]?.id;
  }

  bool isCurrentOrNewerAuthVersion(int version) => version >= _identityVersion;
  AuthState? getAuth() => _auth;

  Map<String, Object?> setAuth(String value) {
    _auth = {'tokenType': 'User', 'value': value};
    final baseVersion = _identityVersion;
    if (!_paused) _identityVersion = baseVersion + 1;
    return {'type': 'Authenticate', 'baseVersion': baseVersion, ..._auth!};
  }

  Map<String, Object?> setAdminAuth(
    String value, [
    Map<String, Object?>? actingAs,
  ]) {
    _auth = {'tokenType': 'Admin', 'value': value, 'impersonating': ?actingAs};
    final baseVersion = _identityVersion;
    if (!_paused) _identityVersion = baseVersion + 1;
    return {'type': 'Authenticate', 'baseVersion': baseVersion, ..._auth!};
  }

  Map<String, Object?> clearAuth() {
    _auth = null;
    markAuthCompletion();
    final baseVersion = _identityVersion;
    if (!_paused) _identityVersion = baseVersion + 1;
    return {
      'type': 'Authenticate',
      'tokenType': 'None',
      'baseVersion': baseVersion,
    };
  }

  bool hasAuth() => _auth != null;
  bool isNewAuth(String value) => _auth?['value'] != value;
  String? queryPath(int queryId) {
    final token = _queryIdToToken[queryId];
    return token == null ? null : _querySet[token]?.canonicalizedUdfPath;
  }

  Map<String, Object?>? queryArgs(int queryId) {
    final token = _queryIdToToken[queryId];
    return token == null ? null : _querySet[token]?.args;
  }

  QueryToken? queryToken(int queryId) => _queryIdToToken[queryId];
  QueryJournal queryJournal(QueryToken queryToken) =>
      _querySet[queryToken]?.journal;

  (Map<String, Object?>, Map<String, Object?>?) restart() {
    _unpause();
    _outstandingQueriesOlderThanRestart.clear();
    final modifications = <Map<String, Object?>>[];
    for (final localQuery in _querySet.values) {
      final add = {
        'type': 'Add',
        'queryId': localQuery.id,
        'udfPath': localQuery.canonicalizedUdfPath,
        'args': [convexToJson(localQuery.args)],
        if (localQuery.journal != null) 'journal': localQuery.journal,
        if (localQuery.componentPath != null)
          'componentPath': localQuery.componentPath,
      };
      modifications.add(add);
      _outstandingQueriesOlderThanRestart.add(localQuery.id);
    }
    _querySetVersion = 1;
    final querySet = {
      'type': 'ModifyQuerySet',
      'baseVersion': 0,
      'newVersion': 1,
      'modifications': modifications,
    };
    if (_auth == null) {
      _identityVersion = 0;
      return (querySet, null);
    }
    _outstandingAuthOlderThanRestart = true;
    final authenticate = {'type': 'Authenticate', 'baseVersion': 0, ..._auth!};
    _identityVersion = 1;
    return (querySet, authenticate);
  }

  void pause() {
    _paused = true;
  }

  (Map<String, Object?>?, Map<String, Object?>?) resume() {
    final querySet = _pendingQuerySetModifications.isNotEmpty
        ? {
            'type': 'ModifyQuerySet',
            'baseVersion': _querySetVersion,
            'newVersion': ++_querySetVersion,
            'modifications': _pendingQuerySetModifications.values.toList(),
          }
        : null;
    final authenticate = _auth == null
        ? null
        : {
            'type': 'Authenticate',
            'baseVersion': _identityVersion++,
            ..._auth!,
          };
    _unpause();
    return (querySet, authenticate);
  }

  void _unpause() {
    _paused = false;
    _pendingQuerySetModifications.clear();
  }

  Map<String, Object?>? _removeSubscriber(QueryToken queryToken) {
    final localQuery = _querySet[queryToken]!;
    if (localQuery.numSubscribers > 1) {
      localQuery.numSubscribers -= 1;
      return null;
    }
    _querySet.remove(queryToken);
    _queryIdToToken.remove(localQuery.id);
    _outstandingQueriesOlderThanRestart.remove(localQuery.id);
    final baseVersion = _querySetVersion;
    final newVersion = _querySetVersion + 1;
    final remove = {'type': 'Remove', 'queryId': localQuery.id};
    if (_paused) {
      if (_pendingQuerySetModifications.containsKey(localQuery.id)) {
        _pendingQuerySetModifications.remove(localQuery.id);
      } else {
        _pendingQuerySetModifications[localQuery.id] = remove;
      }
    } else {
      _querySetVersion = newVersion;
    }
    return {
      'type': 'ModifyQuerySet',
      'baseVersion': baseVersion,
      'newVersion': newVersion,
      'modifications': [remove],
    };
  }
}

class _LocalQuery {
  _LocalQuery({
    required this.id,
    required this.canonicalizedUdfPath,
    required this.args,
    required this.numSubscribers,
    this.journal,
    this.componentPath,
  });

  final int id;
  final String canonicalizedUdfPath;
  final Map<String, Object?> args;
  int numSubscribers;
  QueryJournal journal;
  final String? componentPath;
}
