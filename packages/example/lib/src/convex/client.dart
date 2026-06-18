// ignore_for_file: type=lint, unused_import, unnecessary_question_mark, dead_code, unnecessary_non_null_assertion
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter, invalid_use_of_internal_member
import "dart:convert" as $convert;

import "package:convex_dart/convex_dart.dart";
import "package:http/http.dart" as $http;

import "./functions/generic_functions.dart" as functions0;
import "./functions/primitive_returns.dart" as functions1;
import "./functions/tasks.dart" as functions2;

class MyConvexClient extends ConvexHttpClient {
  MyConvexClient({ConvexHttpClientOptions? options})
    : super("https://dependable-wolf-352.convex.cloud", options: options);

  final String httpUrl = "https://dependable-wolf-352.convex.site";

  Future<$http.Response> get$api$v1$$({
    Map<String, String>? headers,
    String suffix = '',
  }) {
    final uri = Uri.parse(httpUrl + r'/api/v1/' + suffix);
    return rawHttpAction('GET', uri, headers: headers);
  }

  Future<$http.Response> get$api$v1$({Map<String, String>? headers}) {
    final uri = Uri.parse(httpUrl + r'/api/v1/');
    return rawHttpAction('GET', uri, headers: headers);
  }

  Future<$http.Response> post$api$v1$({
    Map<String, String>? headers,
    Object? body,
    $convert.Encoding? encoding,
  }) {
    final uri = Uri.parse(httpUrl + r'/api/v1/');
    return rawHttpAction(
      'POST',
      uri,
      headers: headers,
      body: body,
      encoding: encoding,
    );
  }

  Future<$http.Response> put$api$v1$({
    Map<String, String>? headers,
    Object? body,
    $convert.Encoding? encoding,
  }) {
    final uri = Uri.parse(httpUrl + r'/api/v1/');
    return rawHttpAction(
      'PUT',
      uri,
      headers: headers,
      body: body,
      encoding: encoding,
    );
  }

  Future<$http.Response> delete$api$v1$({
    Map<String, String>? headers,
    Object? body,
    $convert.Encoding? encoding,
  }) {
    final uri = Uri.parse(httpUrl + r'/api/v1/');
    return rawHttpAction(
      'DELETE',
      uri,
      headers: headers,
      body: body,
      encoding: encoding,
    );
  }

  Future<$http.Response> patch$api$v1$({
    Map<String, String>? headers,
    Object? body,
    $convert.Encoding? encoding,
  }) {
    final uri = Uri.parse(httpUrl + r'/api/v1/');
    return rawHttpAction(
      'PATCH',
      uri,
      headers: headers,
      body: body,
      encoding: encoding,
    );
  }
}

class MyConvexWebsocketClient extends ConvexClient {
  MyConvexWebsocketClient({
    ConvexClientOptions options = const ConvexClientOptions(),
  }) : super("https://dependable-wolf-352.convex.cloud", options: options);
}

final api = (
  genericFunctions: (
    query1: functions0.query1,
    query2: functions0.query2,
    query3: functions0.query3,
    query4: functions0.query4,
    query5: functions0.query5,
    query6: functions0.query6,
    query7: functions0.query7,
    query9: functions0.query9,
    query10: functions0.query10,
    query11: functions0.query11,
    query13: functions0.query13,
    query14: functions0.query14,
    query15: functions0.query15,
    query16: functions0.query16,
    query17: functions0.query17,
    query18: functions0.query18,
    query19: functions0.query19,
    query20: functions0.query20,
    query21: functions0.query21,
    query22: functions0.query22,
    query24: functions0.query24,
    query25: functions0.query25,
    query26: functions0.query26,
    query27: functions0.query27,
    query28: functions0.query28,
    query29: functions0.query29,
    query30: functions0.query30,
    query31: functions0.query31,
    query32: functions0.query32,
    query33: functions0.query33,
    query34WithNull: functions0.query34WithNull,
    query34NonNull: functions0.query34NonNull,
    query35: functions0.query35,
    query36: functions0.query36,
    query37: functions0.query37,
    query38: functions0.query38,
    query39: functions0.query39,
    query40: functions0.query40,
    query41: functions0.query41,
    query42: functions0.query42,
    query43: functions0.query43,
    query44: functions0.query44,
    query45: functions0.query45,
    query58: functions0.query58,
    query59: functions0.query59,
    query60: functions0.query60,
    query61: functions0.query61,
    query62: functions0.query62,
    query63: functions0.query63,
    query64: functions0.query64,
    query65: functions0.query65,
    query66: functions0.query66,
    query67: functions0.query67,
    query69: functions0.query69,
    query70: functions0.query70,
    query71: functions0.query71,
    query72: functions0.query72,
    query73: functions0.query73,
    query74: functions0.query74,
    query75: functions0.query75,
    query76: functions0.query76,
    query77: functions0.query77,
    query78: functions0.query78,
    query79: functions0.query79,
    query81: functions0.query81,
    query82: functions0.query82,
    query83: functions0.query83,
    query84: functions0.query84,
    query85: functions0.query85,
    query86: functions0.query86,
    query87: functions0.query87,
    query88: functions0.query88,
    query89: functions0.query89,
    query90: functions0.query90,
    query92: functions0.query92,
    query93: functions0.query93,
    query94: functions0.query94,
    query95: functions0.query95,
    query96: functions0.query96,
    query97: functions0.query97,
    query98: functions0.query98,
    query100: functions0.query100,
    query101: functions0.query101,
    query102: functions0.query102,
    query103: functions0.query103,
    query104: functions0.query104,
    query105: functions0.query105,
    query106: functions0.query106,
    query107: functions0.query107,
    query110: functions0.query110,
    query111: functions0.query111,
    query112: functions0.query112,
    query113: functions0.query113,
    query114: functions0.query114,
    query115: functions0.query115,
    query116: functions0.query116,
    query117: functions0.query117,
    query118: functions0.query118,
    query119: functions0.query119,
    query120: functions0.query120,
    query121: functions0.query121,
    query122: functions0.query122,
    query123: functions0.query123,
    query124: functions0.query124,
    query125: functions0.query125,
    query126: functions0.query126,
    query127: functions0.query127,
    query128: functions0.query128,
    query129: functions0.query129,
    query130: functions0.query130,
    query131: functions0.query131,
    query132: functions0.query132,
    query133: functions0.query133,
    query134: functions0.query134,
    query135: functions0.query135,
    query137: functions0.query137,
    query138: functions0.query138,
    query139: functions0.query139,
    query141: functions0.query141,
    query144: functions0.query144,
    query146: functions0.query146,
    query148: functions0.query148,
    query149: functions0.query149,
    query150: functions0.query150,
    query151: functions0.query151,
    query152: functions0.query152,
    query153: functions0.query153,
    query154: functions0.query154,
    query155: functions0.query155,
    query156: functions0.query156,
    query157: functions0.query157,
    query158: functions0.query158,
    query159: functions0.query159,
    query161: functions0.query161,
    query163: functions0.query163,
    query164: functions0.query164,
    query165: functions0.query165,
    query166: functions0.query166,
    query167: functions0.query167,
    query168: functions0.query168,
    query169: functions0.query169,
    query170: functions0.query170,
    query171: functions0.query171,
    query172: functions0.query172,
    query173: functions0.query173,
    query174: functions0.query174,
    query175: functions0.query175,
    query176: functions0.query176,
    query177: functions0.query177,
    query178: functions0.query178,
    query179: functions0.query179,
    query180: functions0.query180,
    query181: functions0.query181,
    query183: functions0.query183,
    query184: functions0.query184,
    query185: functions0.query185,
    query186: functions0.query186,
    query187: functions0.query187,
    query188: functions0.query188,
    query189: functions0.query189,
    query190: functions0.query190,
    query191: functions0.query191,
    query192: functions0.query192,
    query193: functions0.query193,
    query194: functions0.query194,
    query195: functions0.query195,
    query196: functions0.query196,
    query197: functions0.query197,
    query198: functions0.query198,
    query199: functions0.query199,
    query201: functions0.query201,
    query203: functions0.query203,
    query204: functions0.query204,
    query205: functions0.query205,
    query206: functions0.query206,
    query208: functions0.query208,
    query209: functions0.query209,
    query210: functions0.query210,
    query211: functions0.query211,
    query212: functions0.query212,
    query213: functions0.query213,
    query214: functions0.query214,
    query215: functions0.query215,
    query216: functions0.query216,
    query217: functions0.query217,
    query218: functions0.query218,
    query219: functions0.query219,
    query220: functions0.query220,
    query221: functions0.query221,
    query223: functions0.query223,
    query224: functions0.query224,
    query225: functions0.query225,
  ),
  primitiveReturns: (
    voidReturn: functions1.voidReturn,
    strReturn: functions1.strReturn,
    numReturn: functions1.numReturn,
    boolReturn: functions1.boolReturn,
    int64Return: functions1.int64Return,
    bytesReturn: functions1.bytesReturn,
    nullReturn: functions1.nullReturn,
    unionReturn: functions1.unionReturn,
    arrayReturn: functions1.arrayReturn,
    idReturn: functions1.idReturn,
    recordReturn: functions1.recordReturn,
    anyReturn: functions1.anyReturn,
    objectReturn: functions1.objectReturn,
    privateObjectReturn: functions1.privateObjectReturn,
    emptyObjectArgsReturn: functions1.emptyObjectArgsReturn,
  ),
  tasks: (
    createTask: functions2.createTask,
    getAllTasks: functions2.getAllTasks,
    getTask: functions2.getTask,
    getTasksByStatus: functions2.getTasksByStatus,
    searchTasks: functions2.searchTasks,
    updateTaskText: functions2.updateTaskText,
    toggleTaskCompletion: functions2.toggleTaskCompletion,
    setTaskCompletion: functions2.setTaskCompletion,
    updateTask: functions2.updateTask,
    deleteTask: functions2.deleteTask,
    deleteCompletedTasks: functions2.deleteCompletedTasks,
    deleteAllTasks: functions2.deleteAllTasks,
    getTaskCount: functions2.getTaskCount,
  ),
);
