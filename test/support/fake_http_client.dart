import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

/// Records requests and returns a configured response.
class FakeHttpClient extends http.BaseClient {
  FakeHttpClient(this.handler);

  final FutureOr<http.Response> Function(http.Request request) handler;
  final requests = <http.Request>[];

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final req = request as http.Request;
    requests.add(req);
    final response = await handler(req);
    return http.StreamedResponse(
      Stream.value(response.bodyBytes),
      response.statusCode,
      headers: response.headers,
      reasonPhrase: response.reasonPhrase,
    );
  }
}

http.Response jsonResponse(Map<String, Object?> body, {int statusCode = 200}) =>
    http.Response(
      jsonEncode(body),
      statusCode,
      headers: {'content-type': 'application/json'},
    );
