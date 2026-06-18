import 'package:convex_dart/convex_dart.dart';

class Client {
  final ConvexClient _wsClient;
  final ConvexHttpClient _httpClient;

  static const String httpDeploymentUrl = 'https://x.convex.cloud';
  static const String wsDeploymentUrl = 'wss://x.convex.cloud';

  Client({
    required ConvexHttpClientOptions httpOptions,
    required ConvexClientOptions wsOptions,
  }) : _wsClient = ConvexClient(wsDeploymentUrl, options: wsOptions),
       _httpClient = ConvexHttpClient(httpDeploymentUrl, options: httpOptions);

  Future<void> close() async {
    await _wsClient.close();
    _httpClient.close();
  }
}

extension on ConvexClient {}
