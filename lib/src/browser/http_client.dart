import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../common/args.dart';
import '../common/deployment_url.dart';
import '../values/errors.dart';
import '../values/value.dart';

const statusCodeOk = 200;
const statusCodeBadRequest = 400;
const statusCodeUdfFailed = 560;
const _clientHeader = 'dart-convex-port';

class HttpMutationOptions {
  const HttpMutationOptions({this.skipQueue = false});

  final bool skipQueue;
}

class ConvexHttpClientOptions {
  const ConvexHttpClientOptions({
    this.skipConvexDeploymentUrlCheck = false,
    this.auth,
    this.client,
  });

  final bool skipConvexDeploymentUrlCheck;
  final String? auth;
  final http.Client? client;
}

/// Convex client for one-shot HTTP query, mutation, and action calls.
class ConvexHttpClient {
  ConvexHttpClient(String address, [ConvexHttpClientOptions? options])
    : _address = address,
      _client = options?.client ?? http.Client() {
    final opts = options ?? const ConvexHttpClientOptions();
    if (!opts.skipConvexDeploymentUrlCheck) validateDeploymentUrl(address);
    _auth = opts.auth;
  }

  final String _address;
  final http.Client _client;
  String? _auth;
  Future<void> _mutationTail = Future.value();

  String get url => _address;
  String backendUrl() => '$_address/api';

  void setAuth(String value) {
    _auth = value;
  }

  void clearAuth() {
    _auth = null;
  }

  Future<Object?> query(String name, [Map<String, Object?>? args]) async {
    return _postFunction('/api/query', name, parseArgs(args));
  }

  Future<Object?> mutation(
    String name, [
    Map<String, Object?>? args,
    HttpMutationOptions options = const HttpMutationOptions(),
  ]) {
    final parsedArgs = parseArgs(args);
    if (options.skipQueue) {
      return _postFunction('/api/mutation', name, parsedArgs);
    }
    final completer = Completer<Object?>();
    _mutationTail = _mutationTail.then((_) async {
      try {
        completer.complete(
          await _postFunction('/api/mutation', name, parsedArgs),
        );
      } catch (error, stackTrace) {
        completer.completeError(error, stackTrace);
      }
    });
    return completer.future;
  }

  Future<Object?> action(String name, [Map<String, Object?>? args]) async {
    return _postFunction('/api/action', name, parseArgs(args));
  }

  Future<Object?> _postFunction(
    String endpoint,
    String name,
    Map<String, Object?> args,
  ) async {
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Convex-Client': _clientHeader,
      if (_auth != null) 'Authorization': 'Bearer $_auth',
    };
    final response = await _client.post(
      Uri.parse('$_address$endpoint'),
      headers: headers,
      body: jsonEncode({
        'path': name,
        'format': 'convex_encoded_json',
        'args': [convexToJson(args)],
      }),
    );
    if (response.statusCode < 200 ||
        response.statusCode >= 300 &&
            response.statusCode != statusCodeUdfFailed) {
      throw Exception(response.body);
    }
    final body = jsonDecode(response.body) as Map<String, Object?>;
    switch (body['status']) {
      case 'success':
        return jsonToConvex(body['value']);
      case 'error':
        final errorMessage = body['errorMessage']?.toString() ?? 'Convex error';
        if (body.containsKey('errorData')) {
          throw ConvexError<Object?>(
            jsonToConvex(body['errorData']),
            errorMessage,
          );
        }
        throw Exception(errorMessage);
      default:
        throw FormatException('Invalid response: ${response.body}');
    }
  }

  void close() => _client.close();
}
