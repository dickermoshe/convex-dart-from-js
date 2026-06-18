typedef FunctionResult = Map<String, Object?>;

FunctionResult functionSuccess(Object? value, List<String> logLines) => {
  'success': true,
  'value': value,
  'logLines': logLines,
};

FunctionResult functionFailure(
  String errorMessage,
  List<String> logLines, {
  Object? errorData,
  bool hasErrorData = false,
}) {
  final result = <String, Object?>{
    'success': false,
    'errorMessage': errorMessage,
    'logLines': logLines,
  };
  if (hasErrorData || errorData != null) {
    result['errorData'] = errorData;
  }
  return result;
}
