import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../common/index.dart';
import '../values/errors.dart';
import '../values/value.dart';
import 'logging.dart';

/// HTTP status code for a successful response.
const statusCodeOk = 200;

/// HTTP status code for a bad request.
const statusCodeBadRequest = 400;

/// Custom HTTP status code indicating that a UDF returned an error.
///
/// Must match the constant of the same name in the Convex backend.
const statusCodeUdfFailed = 560;

/// Client version string sent in the `Convex-Client` header.
const convexClientVersion = 'npm-1.41.0';

/// Options for [ConvexHttpClient.rawMutation].
class HttpMutationOptions {
  /// Creates mutation options.
  const HttpMutationOptions({this.skipQueue = false});

  /// Skip the default queue of mutations and run this immediately.
  ///
  /// This allows the same [ConvexHttpClient] to request multiple mutations in
  /// parallel, something not possible with WebSocket-based clients.
  final bool skipQueue;
}

/// Options for constructing a [ConvexHttpClient].
class ConvexHttpClientOptions {
  /// Creates HTTP client options.
  const ConvexHttpClientOptions({
    this.skipConvexDeploymentUrlCheck = false,
    this.logger,
    this.auth,
    this.httpClient,
  });

  /// Skip validating that the Convex deployment URL looks like
  /// `https://happy-animal-123.convex.cloud` or localhost.
  ///
  /// This can be useful when running a self-hosted Convex backend that uses a
  /// different URL.
  final bool skipConvexDeploymentUrlCheck;

  /// A custom logger, or `null` to use the default console logger.
  final Logger? logger;

  /// A JWT containing identity claims accessible in Convex functions.
  ///
  /// This identity may expire, so it may be necessary to call [ConvexHttpClient.setAuth]
  /// later, but for short-lived clients it is convenient to specify this value
  /// here.
  final String? auth;

  /// A custom HTTP client to use for all requests made by this client.
  ///
  /// Dart equivalent of upstream `fetch` injection; upstream `setFetch` and
  /// `setFetchOptions` are intentionally not ported.
  final http.Client? httpClient;
}

/// A Convex client that runs queries and mutations over HTTP.
///
/// This client is stateful (it has user credentials and queues mutations), so
/// take care to avoid sharing it between requests in a server.
///
/// This is appropriate for server-side code or non-reactive applications.
class ConvexHttpClient {
  /// Creates a [ConvexHttpClient] connected to [address].
  ///
  /// [address] is the URL of your Convex deployment, often provided by an
  /// environment variable, e.g. `https://small-mouse-123.convex.cloud`.
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
  bool _debug = true;
  final List<_QueuedMutation> _mutationQueue = [];
  bool _isProcessingQueue = false;

  /// Returns the URL to the Convex backend API, including `/api`.
  ///
  /// Deprecated in upstream in favor of [url], which returns the address without
  /// `/api` at the end.
  String backendUrl() => '$_address/api';

  /// The address for this client, useful for creating a new client.
  ///
  /// Not guaranteed to match the address with which this client was constructed:
  /// it may be canonicalized.
  String get url => _address;

  /// Sets the authentication token to be used for subsequent queries and mutations.
  ///
  /// Should be called whenever the token changes (i.e. due to expiration and
  /// refresh).
  ///
  /// [value] is a JWT-encoded OpenID Connect identity token.
  void setAuth(String value) {
    clearAuth();
    _auth = value;
  }

  /// Sets admin auth to allow calling internal queries, mutations, and actions
  /// and acting as an identity.
  void setAdminAuth(String token, [Map<String, Object?>? actingAs]) {
    clearAuth();
    if (actingAs != null) {
      final encoded = base64Encode(utf8.encode(jsonEncode(actingAs)));
      _adminAuth = '$token:$encoded';
    } else {
      _adminAuth = token;
    }
  }

  /// Clears the current authentication token if set.
  void clearAuth() {
    _auth = null;
    _adminAuth = null;
  }

  /// Sets whether result log lines should be printed on the console.
  void setDebug(bool debug) {
    _debug = debug;
  }

  /// Executes a Convex query function.
  ///
  /// [path] is the name of the query. [args] are the query arguments.
  Future<Object?> rawQuery(String path, Map<String, Object?> args) async =>
      _run('query', path, parseArgs(args), endpoint: 'query');

  /// Executes a Convex mutation function. Mutations are queued by default.
  ///
  /// [path] is the name of the mutation. [args] are the mutation arguments. [options] can skip the mutation
  /// queue.
  Future<Object?> rawMutation(
    String path,
    Map<String, Object?>? args, [
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

  /// Executes a Convex action function. Actions are not queued.
  ///
  /// [path] is the name of the action. [args] are the action arguments; if
  /// omitted, the arguments default to `{}`.
  Future<Object?> rawAction(String path, Map<String, Object?> args) async =>
      _run('action', path, parseArgs(args), endpoint: 'action');

  /// Executes a Convex function of an unknown type. These function calls are
  /// not queued.
  ///
  /// [path] is the name of the function. [args] are the function arguments; if
  /// omitted, the arguments default to `{}`.
  Future<Object?> rawFunction(
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

  /// Closes the underlying HTTP client.
  void close() => _client.close();

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
        if (json.containsKey('errorData')) {
          throw ConvexError<Object?>(
            jsonToConvex(json['errorData']),
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
