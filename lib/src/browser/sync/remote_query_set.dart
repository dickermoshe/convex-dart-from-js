import '../../values/value.dart';
import '../logging.dart';
import 'function_result.dart';

class RemoteQuerySet {
  RemoteQuerySet(this.queryPath, this.logger)
    : version = {'querySet': 0, 'ts': BigInt.zero, 'identity': 0};

  Map<String, Object?> version;
  final Map<int, FunctionResult> _remoteQuerySet = {};
  final String? Function(int queryId) queryPath;
  final Logger logger;

  void transition(Map<String, Object?> transition) {
    final start = (transition['startVersion'] as Map).cast<String, Object?>();
    if (version['querySet'] != start['querySet'] ||
        version['ts'] != start['ts'] ||
        version['identity'] != start['identity']) {
      throw StateError(
        'Invalid start version: ${start['ts']}:${start['querySet']}:${start['identity']}, transitioning from ${version['ts']}:${version['querySet']}:${version['identity']}',
      );
    }
    for (final modification
        in (transition['modifications'] as List).cast<Map<String, Object?>>()) {
      final mod = modification;
      switch (mod['type']) {
        case 'QueryUpdated':
          final path = queryPath(mod['queryId']! as int);
          if (path != null) {
            for (final line in (mod['logLines'] as List).cast<String>()) {
              logForFunction(logger, 'info', 'query', path, line);
            }
          }
          _remoteQuerySet[mod['queryId']! as int] = functionSuccess(
            jsonToConvex(mod['value']),
            (mod['logLines'] as List).cast<String>(),
          );
          break;
        case 'QueryFailed':
          _remoteQuerySet[mod['queryId']! as int] = functionFailure(
            mod['errorMessage']! as String,
            (mod['logLines'] as List).cast<String>(),
            errorData: mod.containsKey('errorData')
                ? jsonToConvex(mod['errorData'])
                : null,
          );
          break;
        case 'QueryRemoved':
          _remoteQuerySet.remove(mod['queryId']! as int);
          break;
        default:
          throw StateError('Invalid modification ${mod['type']}');
      }
    }
    version = (transition['endVersion'] as Map).cast<String, Object?>();
  }

  Map<int, FunctionResult> remoteQueryResults() => _remoteQuerySet;
  BigInt timestamp() => version['ts']! as BigInt;
}
