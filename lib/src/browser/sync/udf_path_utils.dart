import 'dart:convert';

import '../../values/value.dart';

typedef QueryToken = String;

String canonicalizeUdfPath(String udfPath) {
  final pieces = udfPath.split(':');
  final moduleName = pieces.length == 1
      ? pieces.first
      : pieces.take(pieces.length - 1).join(':');
  final functionName = pieces.length == 1 ? 'default' : pieces.last;
  final canonicalModule = moduleName.endsWith('.js')
      ? moduleName.substring(0, moduleName.length - 3)
      : moduleName;
  return '$canonicalModule:$functionName';
}

QueryToken serializePathAndArgs(String udfPath, Map<String, Object?> args) {
  return jsonEncode({
    'udfPath': canonicalizeUdfPath(udfPath),
    'args': convexToJson(args),
  });
}
