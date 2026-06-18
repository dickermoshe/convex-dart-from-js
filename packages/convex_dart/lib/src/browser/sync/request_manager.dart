import 'dart:async';

import '../../values/value.dart';
import '../logging.dart';
import 'function_result.dart';

class RequestManager {
  RequestManager(this.logger, this.markConnectionStateDirty);

  final Logger logger;
  final void Function() markConnectionStateDirty;
  final Map<int, _RequestInfo> _inflightRequests = {};
  Set<int> _requestsOlderThanRestart = {};
  int _inflightMutationsCount = 0;
  int _inflightActionsCount = 0;

  Future<FunctionResult> request(Map<String, Object?> message, bool sent) {
    final completer = Completer<FunctionResult>();
    final requestId = message['requestId']! as int;
    _inflightRequests[requestId] = _RequestInfo(
      message: message,
      status: _RequestedStatus(
        status: sent ? 'Requested' : 'NotSent',
        requestedAt: DateTime.now(),
        completer: completer,
      ),
    );
    if (message['type'] == 'Mutation') {
      _inflightMutationsCount++;
    } else if (message['type'] == 'Action') {
      _inflightActionsCount++;
    }
    markConnectionStateDirty();
    return completer.future;
  }

  ({int requestId, FunctionResult result})? onResponse(
    Map<String, Object?> response,
  ) {
    final requestId = response['requestId']! as int;
    final requestInfo = _inflightRequests[requestId];
    if (requestInfo == null || requestInfo.status is _CompletedStatus) {
      return null;
    }
    final udfType = requestInfo.message['type'] == 'Mutation'
        ? 'mutation'
        : 'action';
    final udfPath = requestInfo.message['udfPath']! as String;
    for (final line in (response['logLines'] as List).cast<String>()) {
      logForFunction(logger, 'info', udfType, udfPath, line);
    }
    final status = requestInfo.status as _RequestedStatus;
    late final FunctionResult result;
    if (response['success'] == true) {
      result = functionSuccess(
        jsonToConvex(response['result']),
        (response['logLines'] as List).cast<String>(),
      );
    } else {
      final errorMessage = response['result']! as String;
      logForFunction(logger, 'error', udfType, udfPath, errorMessage);
      result = functionFailure(
        errorMessage,
        (response['logLines'] as List).cast<String>(),
        errorData: response.containsKey('errorData')
            ? jsonToConvex(response['errorData'])
            : null,
        hasErrorData: response.containsKey('errorData'),
      );
    }
    if (response['type'] == 'ActionResponse' || response['success'] != true) {
      status.completer.complete(result);
      _deleteRequest(requestId, requestInfo.message);
      markConnectionStateDirty();
      return (requestId: requestId, result: result);
    }
    requestInfo.status = _CompletedStatus(
      result: result,
      ts: response['ts']! as BigInt,
      complete: () => status.completer.complete(result),
    );
    return null;
  }

  Map<int, FunctionResult> removeCompleted(BigInt ts) {
    final completeRequests = <int, FunctionResult>{};
    for (final entry in _inflightRequests.entries.toList()) {
      final status = entry.value.status;
      if (status is _CompletedStatus && status.ts <= ts) {
        status.complete();
        completeRequests[entry.key] = status.result;
        _deleteRequest(entry.key, entry.value.message);
      }
    }
    if (completeRequests.isNotEmpty) markConnectionStateDirty();
    return completeRequests;
  }

  List<Map<String, Object?>> restart() {
    _requestsOlderThanRestart = _inflightRequests.keys.toSet();
    final messages = <Map<String, Object?>>[];
    for (final entry in _inflightRequests.entries.toList()) {
      final requestId = entry.key;
      final info = entry.value;
      final status = info.status;
      if (status is _RequestedStatus && status.status == 'NotSent') {
        status.status = 'Requested';
        messages.add(info.message);
        continue;
      }
      if (info.message['type'] == 'Mutation') {
        messages.add(info.message);
      } else if (info.message['type'] == 'Action') {
        _deleteRequest(requestId, info.message);
        _requestsOlderThanRestart.remove(requestId);
        if (status is _CompletedStatus) {
          throw StateError("Action should never be in 'Completed' state");
        }
        (status as _RequestedStatus).completer.complete(
          functionFailure('Connection lost while action was in flight', []),
        );
      }
    }
    markConnectionStateDirty();
    return messages;
  }

  List<Map<String, Object?>> resume() {
    final messages = <Map<String, Object?>>[];
    for (final info in _inflightRequests.values) {
      final status = info.status;
      if (status is _RequestedStatus && status.status == 'NotSent') {
        status.status = 'Requested';
        messages.add(info.message);
      }
    }
    return messages;
  }

  bool hasIncompleteRequests() => _inflightRequests.values.any((info) {
    final status = info.status;
    return status is _RequestedStatus && status.status == 'Requested';
  });

  bool hasInflightRequests() => _inflightRequests.isNotEmpty;
  bool hasSyncedPastLastReconnect() => _requestsOlderThanRestart.isEmpty;

  DateTime? timeOfOldestInflightRequest() {
    DateTime? oldest;
    for (final info in _inflightRequests.values) {
      final status = info.status;
      if (status is _RequestedStatus) {
        oldest = oldest == null || status.requestedAt.isBefore(oldest)
            ? status.requestedAt
            : oldest;
      }
    }
    return oldest;
  }

  int inflightMutations() => _inflightMutationsCount;
  int inflightActions() => _inflightActionsCount;

  void _deleteRequest(int requestId, Map<String, Object?> message) {
    _inflightRequests.remove(requestId);
    _requestsOlderThanRestart.remove(requestId);
    if (message['type'] == 'Mutation') {
      _inflightMutationsCount--;
    } else if (message['type'] == 'Action') {
      _inflightActionsCount--;
    }
  }
}

class _RequestInfo {
  _RequestInfo({required this.message, required this.status});

  final Map<String, Object?> message;
  Object status;
}

class _RequestedStatus {
  _RequestedStatus({
    required this.status,
    required this.requestedAt,
    required this.completer,
  });

  String status;
  final DateTime requestedAt;
  final Completer<FunctionResult> completer;
}

class _CompletedStatus {
  _CompletedStatus({
    required this.result,
    required this.ts,
    required this.complete,
  });

  final FunctionResult result;
  final BigInt ts;
  final void Function() complete;
}
