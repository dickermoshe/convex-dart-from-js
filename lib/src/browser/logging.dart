/// Logger used by Convex clients.
class ConvexLogger {
  const ConvexLogger({
    this.log = _noop,
    this.warn = _noop,
    this.error = _noop,
    this.verbose = _noop,
  });

  final void Function(Object? message) log;
  final void Function(Object? message) warn;
  final void Function(Object? message) error;
  final void Function(Object? message) verbose;

  static void _noop(Object? _) {}
}
