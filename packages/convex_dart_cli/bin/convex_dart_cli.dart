import 'dart:async';
import 'dart:io';

import 'package:convex_dart_cli/credentials.dart';
import 'package:convex_dart_cli/function_spec.dart';
import 'package:convex_dart_cli/messages.dart';
import 'package:path/path.dart' as p;

const _defaultOutputFile = 'function_spec.json';

Future<void> main(List<String> args) async {
  final options = _parseArgs(args);
  if (options.showHelp) {
    stdout.writeln(_usage);
    return;
  }

  final outputPath = p.isAbsolute(options.outputPath)
      ? options.outputPath
      : p.join(options.workingDirectory, options.outputPath);

  try {
    final creds = await resolveCredentials(
      workingDirectory: options.workingDirectory,
      prod: options.prod,
    );

    stderr.writeln('Watching function spec for ${creds.url}...');

    late final StreamSubscription<String> subscription;
    subscription =
        watchFunctionSpec(
          deploymentUrl: creds.url,
          adminKey: creds.adminKey,
        ).listen(
          (json) {
            writeJsonFile(outputPath, json);
            stderr.writeln('Wrote function spec to $outputPath');
          },
          onError: (Object error) {
            stderr.writeln('Error: $error');
            exit(1);
          },
          onDone: () => exit(0),
        );

    ProcessSignal.sigint.watch().listen((_) async {
      await subscription.cancel();
      exit(0);
    });

    // ignore: inference_failure_on_function_invocation
    await subscription.asFuture();
  } on Object catch (error) {
    stderr.writeln('Error: $error');
    exit(1);
  }
}

void writeJsonFile(String path, String json) {
  final file = File(path);
  final temp = File('$path.tmp');
  temp.writeAsStringSync(json);
  if (file.existsSync()) {
    file.deleteSync();
  }
  temp.renameSync(path);
}

class _CliOptions {
  const _CliOptions({
    required this.workingDirectory,
    required this.outputPath,
    required this.prod,
    required this.showHelp,
  });

  final String workingDirectory;
  final String outputPath;
  final bool prod;
  final bool showHelp;
}

_CliOptions _parseArgs(List<String> args) {
  var workingDirectory = Directory.current.path;
  var outputPath = _defaultOutputFile;
  var prod = false;
  var showHelp = false;

  for (var i = 0; i < args.length; i++) {
    final arg = args[i];
    if (_isUnsupportedDeploymentSelectionArg(arg)) {
      throw Exception(deploymentSelectionUnsupportedMessage);
    }
    switch (arg) {
      case '-h':
      case '--help':
        showHelp = true;
      case '--prod':
        prod = true;
      case '-o':
      case '--output':
        if (i + 1 >= args.length) {
          throw Exception('Missing value for $arg');
        }
        outputPath = args[++i];
      case '--cwd':
        if (i + 1 >= args.length) {
          throw Exception('Missing value for $arg');
        }
        workingDirectory = args[++i];
      default:
        if (arg.startsWith('-')) {
          throw Exception('Unknown option: $arg');
        }
        throw Exception('Unexpected argument: $arg');
    }
  }

  return _CliOptions(
    workingDirectory: workingDirectory,
    outputPath: outputPath,
    prod: prod,
    showHelp: showHelp,
  );
}

bool _isUnsupportedDeploymentSelectionArg(String arg) {
  if (arg == '--deployment' ||
      arg == '--deployment-name' ||
      arg == '--preview-name') {
    return true;
  }
  return arg.startsWith('--deployment=') ||
      arg.startsWith('--deployment-name=') ||
      arg.startsWith('--preview-name=');
}

const _usage = '''
Watch Convex function metadata and write JSON to a file.

Usage: convex_dart_cli [options]

Options:
  -o, --output <path>  Output file path (default: function_spec.json)
      --cwd <path>     Project directory (default: current directory)
      --prod           Use the production deployment
  -h, --help           Show this help
''';
