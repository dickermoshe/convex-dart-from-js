import '../values/errors.dart';
import '../values/value.dart';

/// Identifies the kind of Convex function whose logs are being forwarded.
typedef UdfType = String;

/// Log level for client logging.
typedef LogLevel = String;

/// A logger that can be used to log Convex client messages.
///
/// By default, logging is a no-op in Dart unless a custom implementation is
/// supplied via client options.
abstract interface class Logger {
  /// Logs an informational message.
  void log(List<Object?> args);

  /// Logs a warning.
  void warn(List<Object?> args);

  /// Logs an error.
  void error(List<Object?> args);

  /// Logs a verbose debug message.
  void logVerbose(String message);
}

/// Default logger implementation.
class DefaultLogger implements Logger {
  /// Creates a logger with the given [verbose] flag.
  DefaultLogger({required this.verbose});

  /// Whether verbose messages are emitted.
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

/// Logger that discards all output.
class NoopLogger implements Logger {
  /// Creates a no-op logger.
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

/// Creates the default logger used by Convex clients.
Logger instantiateDefaultLogger({required bool verbose}) =>
    DefaultLogger(verbose: verbose);

/// Creates a logger that discards all output.
Logger instantiateNoopLogger({required bool verbose}) => const NoopLogger();

/// Forwards a server log line from a Convex function to [logger].
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

/// Logs a fatal Convex client error and returns it as a [StateError].
StateError logFatalError(Logger logger, String message) {
  logger.error([message]);
  return StateError(message);
}

/// Builds a hybrid error stack trace string from a failed function result.
String createHybridErrorStacktrace(
  String udfType,
  String udfPath,
  Map<String, Object?> result,
) => result['errorMessage'] as String? ?? result['result'] as String? ?? '';

/// Attaches structured error data from [result] onto [error].
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
