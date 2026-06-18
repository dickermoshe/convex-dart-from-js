import 'dart:convert';

import '../../values/value.dart';

/// Opaque token identifying a subscribed query and its arguments.
typedef QueryToken = String;

/// Opaque token identifying a subscribed paginated query.
typedef PaginatedQueryToken = String;

String canonicalizeUdfPath(String udfPath) {
  final pieces = udfPath.split(':');
  String moduleName;
  String functionName;
  if (pieces.length == 1) {
    moduleName = pieces[0];
    functionName = 'default';
  } else {
    moduleName = pieces.sublist(0, pieces.length - 1).join(':');
    functionName = pieces.last;
  }
  if (moduleName.endsWith('.js')) {
    moduleName = moduleName.substring(0, moduleName.length - 3);
  }
  return '$moduleName:$functionName';
}

QueryToken serializePathAndArgs(String udfPath, Map<String, Object?> args) =>
    jsonEncode({
      'udfPath': canonicalizeUdfPath(udfPath),
      'args': convexToJson(args),
    });

PaginatedQueryToken serializePaginatedPathAndArgs(
  String udfPath,
  Map<String, Object?> args, {
  required int initialNumItems,
  required int id,
}) => jsonEncode({
  'type': 'paginated',
  'udfPath': canonicalizeUdfPath(udfPath),
  'args': convexToJson(args),
  'options': convexToJson({'initialNumItems': initialNumItems, 'id': id}),
});

bool serializedQueryTokenIsPaginated(String token) =>
    (jsonDecode(token) as Map)['type'] == 'paginated';
