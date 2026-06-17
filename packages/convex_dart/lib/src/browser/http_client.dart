import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../common/index.dart';
import '../values/errors.dart';
import '../values/value.dart';
import 'logging.dart';

const statusCodeOk = 200;
const statusCodeBadRequest = 400;
const statusCodeUdfFailed = 560;
const convexClientVersion = 'npm-1.41.0';

class HttpMutationOptions {
  const HttpMutationOptions({this.skipQueue = false});

  final bool skipQueue;
}

class ConvexHttpClientOptions {
  const ConvexHttpClientOptions({
    this.skipConvexDeploymentUrlCheck = false,
    this.logger,
    this.auth,
    this.httpClient,
  });

  final bool skipConvexDeploymentUrlCheck;
  final Logger? logger;
  final String? auth;
  final http.Client? httpClient;
}

class ConvexHttpClient {
  ConvexHttpClient(String address, {ConvexHttpClientOptions? options})
    : _address = address,
      _client = options?.httpClient ?? http.Client(),
      _logger = options?.logger ?? instantiateDefaultLogger(verbose: false) {
    if (options?.skipConvexDeploymentUrlCheck != true) {
      validateDeploymentUrl(address);
    }
    if (options?.auth != null) setAuth(options!.auth!);
  }

  final String _address;
  final http.Client _client;
  final Logger _logger;
  String? _auth;
  String? _adminAuth;
  Future<String>? _encodedTsFuture;
  bool _debug = true;
  final List<_QueuedMutation> _mutationQueue = [];
  bool _isProcessingQueue = false;

  String backendUrl() => '$_address/api';
  String get url => _address;

  void setAuth(String value) {
    clearAuth();
    _auth = value;
  }

  void setAdminAuth(String token, [Map<String, Object?>? actingAs]) {
    clearAuth();
    if (actingAs != null) {
      final encoded = base64Encode(utf8.encode(jsonEncode(actingAs)));
      _adminAuth = '$token:$encoded';
    } else {
      _adminAuth = token;
    }
  }

  void clearAuth() {
    _auth = null;
    _adminAuth = null;
  }

  void setDebug(bool debug) {
    _debug = debug;
  }

  Future<Object?> consistentQuery(
    String path, [
    Map<String, Object?>? args,
  ]) async {
    final timestamp = await _getTimestamp();
    return _run(
      'query',
      path,
      parseArgs(args),
      endpoint: 'query_at_ts',
      timestamp: timestamp,
    );
  }

  Future<Object?> query(String path, [Map<String, Object?>? args]) async =>
      _run('query', path, parseArgs(args), endpoint: 'query');

  Future<Object?> mutation(
    String path, [
    Map<String, Object?>? args,
    HttpMutationOptions options = const HttpMutationOptions(),
  ]) {
    final parsedArgs = parseArgs(args);
    if (options.skipQueue) {
      return _run('mutation', path, parsedArgs, endpoint: 'mutation');
    }
    final completer = Completer<Object?>();
    _mutationQueue.add(_QueuedMutation(path, parsedArgs, completer));
    unawaited(_processMutationQueue());
    return completer.future;
  }

  Future<Object?> action(String path, [Map<String, Object?>? args]) async =>
      _run('action', path, parseArgs(args), endpoint: 'action');

  Future<Object?> function(
    String path, {
    String? componentPath,
    Map<String, Object?>? args,
  }) async => _run(
    'any',
    path,
    parseArgs(args),
    endpoint: 'function',
    componentPath: componentPath,
    wrapArgsInArray: false,
  );

  void close() => _client.close();

  Future<String> _getTimestamp() {
    final existing = _encodedTsFuture;
    if (existing != null) return existing;
    return _encodedTsFuture = _getTimestampInner();
  }

  Future<String> _getTimestampInner() async {
    final response = await _client.post(
      Uri.parse('$_address/api/query_ts'),
      headers: _baseHeaders(),
    );
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw StateError(response.body);
    }
    final json = jsonDecode(response.body) as Map<String, Object?>;
    return json['ts']! as String;
  }

  Future<void> _processMutationQueue() async {
    if (_isProcessingQueue) return;
    _isProcessingQueue = true;
    while (_mutationQueue.isNotEmpty) {
      final queued = _mutationQueue.removeAt(0);
      try {
        queued.completer.complete(
          await _run(
            'mutation',
            queued.path,
            queued.args,
            endpoint: 'mutation',
          ),
        );
      } catch (error, stackTrace) {
        queued.completer.completeError(error, stackTrace);
      }
    }
    _isProcessingQueue = false;
  }

  Future<Object?> _run(
    String udfType,
    String path,
    Map<String, Object?> args, {
    required String endpoint,
    String? timestamp,
    String? componentPath,
    bool wrapArgsInArray = true,
  }) async {
    final encodedArgs = convexToJson(args);
    final body = jsonEncode({
      'componentPath': ?componentPath,
      'path': path,
      'format': 'convex_encoded_json',
      'args': wrapArgsInArray ? [encodedArgs] : encodedArgs,
      'ts': ?timestamp,
    });
    final response = await _client.post(
      Uri.parse('$_address/api/$endpoint'),
      headers: _headers(),
      body: body,
    );
    if (response.statusCode < 200 ||
        response.statusCode >= 300 &&
            response.statusCode != statusCodeUdfFailed) {
      throw StateError(response.body);
    }
    final json = jsonDecode(response.body) as Map<String, Object?>;
    if (_debug) {
      for (final line in (json['logLines'] as List? ?? const [])) {
        logForFunction(_logger, 'info', udfType, path, line as String);
      }
    }
    switch (json['status']) {
      case 'success':
        return jsonToConvex(json['value']);
      case 'error':
        final errorData = json['errorData'];
        if (errorData != null) {
          throw ConvexError<Object?>(
            jsonToConvex(errorData),
            message: json['errorMessage'] as String?,
          );
        }
        throw StateError(json['errorMessage'] as String? ?? 'Convex error');
      default:
        throw StateError('Invalid response: ${response.body}');
    }
  }

  Map<String, String> _baseHeaders() => {
    'Content-Type': 'application/json',
    'Convex-Client': convexClientVersion,
  };

  Map<String, String> _headers() => {
    ..._baseHeaders(),
    if (_adminAuth != null)
      'Authorization': 'Convex $_adminAuth'
    else if (_auth != null)
      'Authorization': 'Bearer $_auth',
  };
}

class _QueuedMutation {
  _QueuedMutation(this.path, this.args, this.completer);

  final String path;
  final Map<String, Object?> args;
  final Completer<Object?> completer;
}
