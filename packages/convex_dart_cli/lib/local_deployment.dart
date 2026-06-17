import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;

class LocalDeploymentConfig {
  const LocalDeploymentConfig({
    required this.adminKey,
    required this.cloudPort,
    this.deploymentName,
  });

  final String adminKey;
  final int cloudPort;
  final String? deploymentName;

  factory LocalDeploymentConfig.fromJson(Map<String, Object?> json) {
    final ports = json['ports'];
    if (ports is! Map) {
      throw FormatException('Missing ports in local deployment config');
    }
    final cloud = ports['cloud'];
    if (cloud is! num) {
      throw FormatException('Missing ports.cloud in local deployment config');
    }
    final adminKey = json['adminKey'];
    if (adminKey is! String || adminKey.isEmpty) {
      throw FormatException('Missing adminKey in local deployment config');
    }
    return LocalDeploymentConfig(
      adminKey: adminKey,
      cloudPort: cloud.toInt(),
      deploymentName: json['deploymentName'] as String?,
    );
  }
}

String projectLocalStateDir({String? projectDir}) {
  final base = projectDir ?? Directory.current.path;
  return p.join(base, '.convex', 'local', 'default');
}

String localDeploymentUrl(int cloudPort) => 'http://127.0.0.1:$cloudPort';

LocalDeploymentConfig? loadProjectLocalConfig({String? projectDir}) {
  final configFile = File(
    p.join(projectLocalStateDir(projectDir: projectDir), 'config.json'),
  );
  if (!configFile.existsSync()) return null;

  try {
    final json =
        jsonDecode(configFile.readAsStringSync()) as Map<String, Object?>;
    return LocalDeploymentConfig.fromJson(json);
  } on Object {
    return null;
  }
}

LocalDeploymentConfig? loadLegacyLocalDeploymentConfig(
  String deploymentName, {
  String? homeDir,
}) {
  final home =
      homeDir ??
      Platform.environment['USERPROFILE'] ??
      Platform.environment['HOME'] ??
      '';
  final configFile = File(
    p.join(
      home,
      '.convex',
      'convex-backend-state',
      deploymentName,
      'config.json',
    ),
  );
  if (!configFile.existsSync()) return null;

  try {
    final json =
        jsonDecode(configFile.readAsStringSync()) as Map<String, Object?>;
    return LocalDeploymentConfig.fromJson(json);
  } on Object {
    return null;
  }
}

LocalDeploymentConfig? loadLocalDeploymentConfig(
  String deploymentName, {
  String? projectDir,
}) =>
    loadProjectLocalConfig(projectDir: projectDir) ??
    loadLegacyLocalDeploymentConfig(deploymentName);
