import 'dart:convert';

/// Helpers for building Convex sync protocol JSON in tests.
String transitionJson({
  required int startQuerySet,
  required int endQuerySet,
  String startTs = 'AAAAAAAAAAA=',
  String endTs = 'AAAAAAAAAAA=',
  int startIdentity = 0,
  int endIdentity = 0,
  required List<Map<String, Object?>> modifications,
}) => jsonEncode({
  'type': 'Transition',
  'startVersion': {
    'querySet': startQuerySet,
    'ts': startTs,
    'identity': startIdentity,
  },
  'endVersion': {'querySet': endQuerySet, 'ts': endTs, 'identity': endIdentity},
  'modifications': modifications,
});

Map<String, Object?> queryUpdated({
  required int queryId,
  required Object? value,
  List<String> logLines = const [],
  String? journal,
}) => {
  'type': 'QueryUpdated',
  'queryId': queryId,
  'value': value,
  'logLines': logLines,
  'journal': journal,
};

Map<String, Object?> queryFailed({
  required int queryId,
  required String errorMessage,
  List<String> logLines = const [],
  Object? errorData,
}) => {
  'type': 'QueryFailed',
  'queryId': queryId,
  'errorMessage': errorMessage,
  'logLines': logLines,
  if (errorData != null) 'errorData': errorData,
};

Map<String, Object?> queryRemoved({required int queryId}) => {
  'type': 'QueryRemoved',
  'queryId': queryId,
};

String mutationResponseJson({
  required int requestId,
  required bool success,
  Object? result,
  String ts = 'AQAAAAAAAAA=',
  List<String> logLines = const [],
  Object? errorData,
}) => jsonEncode({
  'type': 'MutationResponse',
  'requestId': requestId,
  'success': success,
  'result': result,
  'ts': ts,
  'logLines': logLines,
  if (errorData != null) 'errorData': errorData,
});

String actionResponseJson({
  required int requestId,
  required bool success,
  Object? result,
  List<String> logLines = const [],
  Object? errorData,
}) => jsonEncode({
  'type': 'ActionResponse',
  'requestId': requestId,
  'success': success,
  'result': result,
  'logLines': logLines,
  if (errorData != null) 'errorData': errorData,
});

String authErrorJson() => jsonEncode({'type': 'AuthError'});

List<String> sentMessageTypes(List<String> sent) =>
    sent.map((raw) => (jsonDecode(raw) as Map)['type'] as String).toList();

Map<String, Object?> sentMessage(List<String> sent, int index) =>
    (jsonDecode(sent[index]) as Map).cast<String, Object?>();
