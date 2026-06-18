import 'dart:async';
import 'dart:io';

import 'package:cli_tools/cli_tools.dart';
import 'package:config/config.dart';
import 'package:convex_dart_cli/credentials.dart';
import 'package:convex_dart_cli/function_spec.dart';
import 'package:convex_dart_cli/messages.dart';
import 'package:convex_dart_cli/types.dart';
import 'package:locked_async/locked_async.dart';
import 'package:path/path.dart' as p;

Future<void> main(List<String> args) async {
  final commandRunner = BetterCommandRunner<StandardGlobalOption, int>(
    'convex_dart_cli',
    'CLI for generating a Dart Convex client.',
    globalOptions: [StandardGlobalOption.quiet, StandardGlobalOption.verbose],
  )..addCommand(GenerateCommand());

  try {
    exitCode = await commandRunner.run(args) ?? 0;
  } on UsageException catch (error) {
    stderr.writeln(error);
    exitCode = 64;
  }
}

class GenerateCommand extends BetterCommand<CliOptions<dynamic>, int> {
  GenerateCommand() : super(options: CliOptions.values);

  @override
  String get name => 'generate';

  @override
  String get description => 'Generate the Dart Convex client.';

  Logger? _logger;
  Logger get logger {
    final existing = _logger;
    if (existing != null) {
      return existing;
    }

    final globalConfiguration = runner?.globalConfiguration;
    final logLevel =
        globalConfiguration?.value(StandardGlobalOption.verbose) ?? false
        ? LogLevel.debug
        : globalConfiguration?.value(StandardGlobalOption.quiet) ?? false
        ? LogLevel.error
        : LogLevel.info;

    return _logger = StdOutLogger(
      logLevel,
      logToStderrLevelThreshold: LogLevel.error,
    );
  }

  final _lockedTask = LockedAsync();

  Future<bool> buildDartClient({
    required String json,
    required Directory outputDirectory,
    required Duration debounce,
    required bool publicSerialize,
  }) {
    return _lockedTask.run((state) async {
      if (debounce > Duration.zero) {
        await state.wait(() => Future<void>.delayed(debounce));
      }

      logger.info('Generating Dart client...', type: TextLogType.init);
      logger.debug('Function spec JSON size: ${json.length} characters');
      logger.debug('Output directory: ${outputDirectory.path}');
      logger.debug('Public serialization helpers: $publicSerialize');

      final FunctionsSpec spec;
      try {
        spec = FunctionsSpecMapper.fromJson(json);
      } on Object catch (error, stackTrace) {
        logger.error('Failed to parse convex function-spec JSON output.');
        logger.error(
          'Error: $error\n'
          'Output preview: ${_preview(json)}',
        );
        logger.debug('Stack trace: $stackTrace');
        logger.debug(json);
        return false;
      }

      logger.info('Parsed ${spec.functions.length} Convex function specs.');
      final context = ClientBuildContext();
      try {
        await spec.build(context, publicSerialize: publicSerialize);
      } on Object catch (error, stackTrace) {
        logger.error('Failed to build Dart client from function spec.');
        logger.error('Error: $error');
        logger.debug('Stack trace: $stackTrace');
        return false;
      }
      logger.info('Built ${context.outputs.length} generated Dart files.');

      await state.wait(() => _wipeDartFiles(outputDirectory));
      await state.wait(() => _writeGeneratedFiles(outputDirectory, context));
      logger.info('Dart client generated.', type: TextLogType.success);
      return true;
    });
  }

  Future<void> _wipeDartFiles(Directory directory) async {
    if (!await directory.exists()) {
      logger.debug('Output directory does not exist; skipping cleanup.');
      return;
    }

    var deletedCount = 0;
    await for (final entity in directory.list(recursive: true)) {
      if (entity is File && p.extension(entity.path) == '.dart') {
        logger.debug(
          'Deleting ${p.relative(entity.path, from: directory.path)}',
        );
        await entity.delete();
        deletedCount++;
      }
    }

    _removeEmptyDirectories(directory, preserveRoot: true);
    if (deletedCount == 0) {
      logger.debug('No existing Dart files found to clean up.');
    } else {
      logger.info('Cleaned $deletedCount existing Dart files.');
    }
  }

  Future<void> _writeGeneratedFiles(
    Directory outputDirectory,
    ClientBuildContext context,
  ) async {
    logger.info(
      'Writing ${context.outputs.length} Dart files to ${outputDirectory.path}.',
    );

    for (final entry in context.outputs.entries) {
      final outputPath = p.join(outputDirectory.path, entry.key);
      final file = File(outputPath);
      await file.create(recursive: true);
      await file.writeAsString(entry.value);
      logger.debug(
        'Wrote ${p.relative(outputPath, from: outputDirectory.path)}',
      );
    }
  }

  void _removeEmptyDirectories(
    Directory directory, {
    bool preserveRoot = false,
  }) {
    for (final entity in directory.listSync()) {
      if (entity is Directory) {
        _removeEmptyDirectories(entity);
      }
    }

    if (!preserveRoot && directory.listSync().isEmpty) {
      directory.deleteSync();
      logger.debug('Removed empty directory: ${directory.path}');
    }
  }

  @override
  Future<int> runWithConfig(Configuration<CliOptions<dynamic>> config) async {
    final outputDirectory = config.value(CliOptions.outputDir);
    final once = config.value(CliOptions.once);
    final publicSerialize = config.value(CliOptions.publicSerialize);
    final prod = config.value(CliOptions.prod);

    logger.info('Resolving Convex deployment credentials...');
    final DeploymentCredentials creds;
    try {
      creds = await resolveCredentials(
        workingDirectory: Directory.current.path,
        prod: prod,
      );
    } on Object catch (error) {
      logger.error(formatCredentialError(error));
      return 1;
    }

    logger.info('Connected to ${creds.url}.');
    logger.info(
      once
          ? 'Waiting for initial function spec...'
          : 'Watching function spec for changes...',
      type: TextLogType.init,
    );

    final completed = Completer<int>();
    late final StreamSubscription<String> subscription;
    var isFirstSpec = true;

    subscription =
        watchFunctionSpec(
          deploymentUrl: creds.url,
          adminKey: creds.adminKey,
        ).distinct().listen(
          (json) async {
            logger.info(
              isFirstSpec
                  ? 'Received function spec.'
                  : 'Function spec changed; regenerating Dart client.',
            );
            isFirstSpec = false;

            final success = await buildDartClient(
              json: json,
              outputDirectory: outputDirectory,
              debounce: Duration.zero,
              publicSerialize: publicSerialize,
            );
            if (!success && !completed.isCompleted) {
              await subscription.cancel();
              completed.complete(1);
              return;
            }
            if (once && !completed.isCompleted) {
              await subscription.cancel();
              completed.complete(success ? 0 : 1);
            }
          },
          onError: (Object error, StackTrace stackTrace) {
            logger.error('Function spec stream failed: $error');
            logger.debug('Stack trace: $stackTrace');
            if (!completed.isCompleted) {
              completed.complete(1);
            }
          },
          onDone: () {
            logger.debug('Function spec stream closed.');
            if (!completed.isCompleted) {
              completed.complete(0);
            }
          },
        );

    final sigintSubscription = ProcessSignal.sigint.watch().listen((_) async {
      logger.info('Stopping.');
      await subscription.cancel();
      if (!completed.isCompleted) {
        completed.complete(0);
      }
    });

    final result = await completed.future;
    await sigintSubscription.cancel();
    return result;
  }
}

Directory _defaultOutputDir() {
  return Directory('lib/src/convex');
}

String _preview(String output) {
  const maxLength = 500;
  if (output.length <= maxLength) {
    return output;
  }
  return '${output.substring(0, maxLength)}...';
}

enum CliOptions<V> implements OptionDefinition<V> {
  outputDir(
    DirOption(
      argName: 'output',
      argAbbrev: 'o',
      fromDefault: _defaultOutputDir,
      helpText: 'The directory to write generated Dart client files to.',
      mode: PathExistMode.mayExist,
    ),
  ),
  publicSerialize(
    FlagOption(
      argName: 'public-serialize',
      helpText: 'Generate public serialize and deserialize helpers for tests.',
      defaultsTo: false,
      negatable: false,
      hide: true,
    ),
  ),
  prod(
    FlagOption(
      argName: 'prod',
      helpText: 'Generate the Dart client for the production deployment.',
      defaultsTo: false,
      negatable: false,
    ),
  ),
  once(
    FlagOption(
      argName: 'once',
      helpText:
          'Generate the Dart client once and exit instead of watching for changes.',
      defaultsTo: false,
      negatable: false,
    ),
  );

  const CliOptions(this.option);

  @override
  final ConfigOptionBase<V> option;
}
