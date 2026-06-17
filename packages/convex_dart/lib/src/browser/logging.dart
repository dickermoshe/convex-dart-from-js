import '../values/errors.dart';
import '../values/value.dart';

typedef UdfType = String;
typedef LogLevel = String;

abstract interface class Logger {
  void log(List<Object?> args);
  void warn(List<Object?> args);
  void error(List<Object?> args);
  void logVerbose(String message);
}

class DefaultLogger implements Logger {
  DefaultLogger({required this.verbose});

  final bool verbose;

  @override
  void error(List<Object?> args) {}

  @override
  void log(List<Object?> args) {}

  @override
  void logVerbose(String message) {
    if (verbose) log([message]);
  }

  @override
  void warn(List<Object?> args) {}
}

class NoopLogger implements Logger {
  const NoopLogger();
  @override
  void error(List<Object?> args) {}
  @override
  void log(List<Object?> args) {}
  @override
  void logVerbose(String message) {}
  @override
  void warn(List<Object?> args) {}
}

Logger instantiateDefaultLogger({required bool verbose}) =>
    DefaultLogger(verbose: verbose);

Logger instantiateNoopLogger({required bool verbose}) => const NoopLogger();

void logForFunction(
  Logger logger,
  String level,
  String udfType,
  String udfPath,
  String message,
) {
  final args = ['[$udfType:$udfPath] $message'];
  switch (level) {
    case 'error':
      logger.error(args);
      break;
    case 'warn':
      logger.warn(args);
      break;
    default:
      logger.log(args);
  }
}

StateError logFatalError(Logger logger, String message) {
  logger.error([message]);
  return StateError(message);
}

String createHybridErrorStacktrace(
  String udfType,
  String udfPath,
  Map<String, Object?> result,
) => result['errorMessage'] as String? ?? result['result'] as String? ?? '';

ConvexError<Object?> forwardData(
  Map<String, Object?> result,
  ConvexError<Object?> error,
) {
  final data = result['errorData'];
  if (data != null) {
    error.data = data is Map || data is List ? jsonToConvex(data) : data;
  }
  return error;
}
