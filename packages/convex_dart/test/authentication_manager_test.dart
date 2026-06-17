import 'package:convex_dart/src/browser/logging.dart';
import 'package:convex_dart/src/browser/sync/authentication_manager.dart';
import 'package:convex_dart/src/browser/sync/local_state.dart';
import 'package:test/test.dart';

AuthTokenFetcher tokenFetcher(String? value) =>
    (args) async => value;

AuthTokenFetcher refreshTokenFetcher(String initial, String refreshed) =>
    (args) async => args.forceRefreshToken ? refreshed : initial;

void main() {
  group('AuthenticationManager', () {
    late LocalSyncState state;
    late List<String> socketEvents;
    late String? authToken;
    late bool? authChanged;

    setUp(() {
      state = LocalSyncState();
      socketEvents = [];
      authToken = null;
      authChanged = null;
    });

    AuthenticationManager makeManager() => AuthenticationManager(
      state,
      authenticate: (token) {
        authToken = token;
        return state.setAuth(token)['baseVersion']! as int;
      },
      stopSocket: () async => socketEvents.add('stop'),
      tryRestartSocket: () => socketEvents.add('restart'),
      pauseSocket: () => socketEvents.add('pause'),
      resumeSocket: () => socketEvents.add('resume'),
      clearAuth: () {
        authToken = null;
        state.clearAuth();
      },
      logger: const NoopLogger(),
    );

    test('setConfig fetches token and authenticates', () async {
      final manager = makeManager();
      await manager.setConfig(
        tokenFetcher('token-a'),
        (isAuth) => authChanged = isAuth,
      );
      expect(socketEvents, ['pause', 'resume']);
      expect(authToken, 'token-a');
      expect(authChanged, isNull);
    });

    test('setConfig with null token clears auth', () async {
      final manager = makeManager();
      await manager.setConfig(
        tokenFetcher(null),
        (isAuth) => authChanged = isAuth,
      );
      expect(authToken, isNull);
      expect(authChanged, isFalse);
    });

    test('onTransition marks auth completion on identity bump', () async {
      final manager = makeManager();
      await manager.setConfig(
        tokenFetcher('token'),
        (isAuth) => authChanged = isAuth,
      );
      manager.onTransition({
        'startVersion': {'querySet': 0, 'ts': BigInt.zero, 'identity': 0},
        'endVersion': {'querySet': 0, 'ts': BigInt.zero, 'identity': 1},
        'modifications': [],
      });
      expect(authChanged, isTrue);
    });

    test('onTransition ignores stale identity versions', () {
      final manager = makeManager();
      manager.onTransition({
        'startVersion': {'querySet': 0, 'ts': BigInt.zero, 'identity': 5},
        'endVersion': {'querySet': 0, 'ts': BigInt.zero, 'identity': 6},
        'modifications': [],
      });
      expect(authChanged, isNull);
    });

    test('onAuthError refreshes token and restarts socket', () async {
      final manager = makeManager();
      await manager.setConfig(
        refreshTokenFetcher('token-a', 'token-b'),
        (isAuth) => authChanged = isAuth,
      );
      socketEvents.clear();
      manager.onAuthError({'type': 'AuthError'});
      await Future<void>.delayed(const Duration(milliseconds: 10));
      expect(socketEvents, contains('stop'));
      expect(socketEvents, contains('restart'));
      expect(authToken, 'token-b');
    });

    test('stop invalidates pending setConfig', () async {
      final manager = makeManager();
      final config = manager.setConfig((args) async {
        await Future<void>.delayed(const Duration(milliseconds: 20));
        return 'late';
      }, (_) {});
      manager.stop();
      await config;
      expect(authToken, isNull);
    });
  });
}
