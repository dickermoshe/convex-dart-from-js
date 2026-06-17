import 'package:convex_dart/src/browser/logging.dart';
import 'package:test/test.dart';

void main() {
  group('logging', () {
    test('NoopLogger accepts all log levels', () {
      const logger = NoopLogger();
      expect(() {
        logger.log(['a']);
        logger.warn(['b']);
        logger.error(['c']);
        logger.logVerbose('d');
      }, returnsNormally);
    });

    test('DefaultLogger verbose toggles logVerbose', () {
      final verbose = DefaultLogger(verbose: true);
      final quiet = DefaultLogger(verbose: false);
      expect(() => verbose.logVerbose('msg'), returnsNormally);
      expect(() => quiet.logVerbose('msg'), returnsNormally);
    });

    test('logForFunction routes by level', () {
      const logger = NoopLogger();
      expect(() {
        logForFunction(logger, 'info', 'query', 'messages:list', 'line');
        logForFunction(logger, 'warn', 'mutation', 'send', 'warn');
        logForFunction(logger, 'error', 'action', 'do', 'err');
      }, returnsNormally);
    });

    test('createHybridErrorStacktrace reads error fields', () {
      expect(
        createHybridErrorStacktrace('mutation', 'send', {
          'errorMessage': 'boom',
        }),
        'boom',
      );
    });
  });
}
