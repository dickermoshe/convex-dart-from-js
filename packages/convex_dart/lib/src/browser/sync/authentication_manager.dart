import '../logging.dart';
import 'local_state.dart';

/// Fetches a JWT auth token for Convex.
///
/// [args.forceRefreshToken] is `true` when the server rejected the previous
/// token and a fresh token is required.
typedef AuthTokenFetcher =
    Future<String?> Function(({bool forceRefreshToken}) args);

class AuthenticationManager {
  AuthenticationManager(
    this.syncState, {
    required this.authenticate,
    required this.stopSocket,
    required this.tryRestartSocket,
    required this.pauseSocket,
    required this.resumeSocket,
    required this.clearAuth,
    required this.logger,
  });

  final LocalSyncState syncState;
  final int Function(String token) authenticate;
  final Future<void> Function() stopSocket;
  final void Function() tryRestartSocket;
  final void Function() pauseSocket;
  final void Function() resumeSocket;
  final void Function() clearAuth;
  final Logger logger;
  AuthTokenFetcher? _fetchToken;
  void Function(bool isAuthenticated)? _onChange;
  int _configVersion = 0;

  Future<void> setConfig(
    AuthTokenFetcher fetchToken,
    void Function(bool isAuthenticated) onChange, [
    void Function(bool isRefreshing)? onRefreshChange,
  ]) async {
    _configVersion++;
    final version = _configVersion;
    _fetchToken = fetchToken;
    _onChange = onChange;
    pauseSocket();
    final token = await fetchToken((forceRefreshToken: false));
    if (version != _configVersion) return;
    if (token != null) {
      authenticate(token);
    } else {
      clearAuth();
      onChange(false);
    }
    resumeSocket();
  }

  void onTransition(Map<String, Object?> serverMessage) {
    final endVersion = (serverMessage['endVersion'] as Map)
        .cast<String, Object?>();
    final startVersion = (serverMessage['startVersion'] as Map)
        .cast<String, Object?>();
    if (!syncState.isCurrentOrNewerAuthVersion(
      endVersion['identity']! as int,
    )) {
      return;
    }
    if ((endVersion['identity']! as int) <=
        (startVersion['identity']! as int)) {
      return;
    }
    syncState.markAuthCompletion();
    _onChange?.call(true);
  }

  void onAuthError(Map<String, Object?> serverMessage) {
    final fetchToken = _fetchToken;
    if (fetchToken == null) return;
    () async {
      await stopSocket();
      final token = await fetchToken((forceRefreshToken: true));
      if (token != null) {
        authenticate(token);
      } else {
        clearAuth();
        _onChange?.call(false);
      }
      tryRestartSocket();
    }();
  }

  void stop() {
    _configVersion++;
    _fetchToken = null;
  }
}
