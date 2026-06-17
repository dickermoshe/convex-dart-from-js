import 'dart:convert';

import 'package:http/http.dart' as http;

const productionProvisionHost = 'https://api.convex.dev';
const bigBrainUrl = '$productionProvisionHost/api/';
const convexClientHeader = 'dart-cli-0.1.0';

class DeploymentAuthResponse {
  const DeploymentAuthResponse({
    required this.adminKey,
    required this.url,
    this.deploymentName,
    this.deploymentType,
  });

  final String adminKey;
  final String url;
  final String? deploymentName;
  final String? deploymentType;

  factory DeploymentAuthResponse.fromJson(Map<String, Object?> json) {
    final adminKey = json['adminKey'];
    final url = json['url'];
    if (adminKey is! String || url is! String) {
      throw BigBrainException(
        'Unexpected authorization response: ${jsonEncode(json)}',
      );
    }
    return DeploymentAuthResponse(
      adminKey: adminKey,
      url: url,
      deploymentName: json['deploymentName'] as String?,
      deploymentType: json['deploymentType'] as String?,
    );
  }
}

class BigBrainException implements Exception {
  BigBrainException(this.message, {this.statusCode});

  final String message;
  final int? statusCode;

  @override
  String toString() => message;
}

class BigBrainClient {
  BigBrainClient({
    http.Client? httpClient,
    String? accessToken,
    String? bearerToken,
    String provisionHost = productionProvisionHost,
  }) : _http = httpClient ?? http.Client(),
       _bearerToken = bearerToken ?? accessToken,
       _baseUrl = '$provisionHost/api/';

  final http.Client _http;
  final String? _bearerToken;
  final String _baseUrl;

  String? get bearerToken => _bearerToken;

  Future<DeploymentAuthResponse> authorizeWithinCurrentProject({
    required String deploymentName,
    required String deploymentType,
  }) async {
    final body = jsonEncode({
      'selectedDeploymentName': deploymentName,
      'projectSelection': {
        'kind': 'deploymentName',
        'deploymentName': deploymentName,
        'deploymentType': deploymentType,
      },
    });
    final json = await _post(
      'deployment/authorize_within_current_project',
      body,
    );
    return DeploymentAuthResponse.fromJson(json);
  }

  Future<DeploymentAuthResponse> authorizeProd({
    required String deploymentName,
  }) async {
    final body = jsonEncode({'deploymentName': deploymentName});
    final json = await _post('deployment/authorize_prod', body);
    return DeploymentAuthResponse.fromJson(json);
  }

  Future<DeploymentAuthResponse> provisionAndAuthorize({
    String? teamSlug,
    String? projectSlug,
    required String deploymentType,
  }) async {
    final body = jsonEncode({
      'teamSlug': teamSlug,
      'projectSlug': projectSlug,
      'deploymentType': deploymentType,
    });
    final json = await _post('deployment/provision_and_authorize', body);
    return DeploymentAuthResponse.fromJson(json);
  }

  Future<String> urlForDeployKey(String deployKey) async {
    final body = jsonEncode({'deployKey': deployKey});
    final json = await _post('deployment/url_for_key', body);
    final url = json['url'] ?? json;
    if (url is String) return url;
    throw BigBrainException(
      'Unexpected url_for_key response: ${jsonEncode(json)}',
    );
  }

  Future<Map<String, Object?>> _post(String path, String body) async {
    final response = await _http.post(
      Uri.parse('$_baseUrl$path'),
      headers: {
        'Content-Type': 'application/json',
        'Convex-Client': convexClientHeader,
        if (_bearerToken != null) 'Authorization': 'Bearer $_bearerToken',
      },
      body: body,
    );

    if (response.statusCode != 200) {
      throw BigBrainException(
        'Convex API request failed (${response.statusCode}): ${response.body}',
        statusCode: response.statusCode,
      );
    }

    final decoded = jsonDecode(response.body);
    if (decoded is! Map) {
      throw BigBrainException(
        'Unexpected Convex API response: ${response.body}',
      );
    }
    return decoded.cast<String, Object?>();
  }

  void close() => _http.close();
}
