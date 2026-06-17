import '../common/index.dart';
import 'sync/authentication_manager.dart';
import 'sync/client.dart';
import 'sync/optimistic_updates.dart';
import 'sync/udf_path_utils.dart';

class ConvexClientOptions extends BaseConvexClientOptions {
  const ConvexClientOptions({
    super.webSocketFactory,
    super.verbose,
    super.logger,
    super.reportDebugInfoToConvex,
    super.skipConvexDeploymentUrlCheck,
    super.expectAuth,
  });
}

class Unsubscribe<T> {
  Unsubscribe({
    required this.unsubscribe,
    required this.getCurrentValue,
    required this.getQueryLogs,
  });

  final void Function() unsubscribe;
  final T? Function() getCurrentValue;
  final List<String>? Function() getQueryLogs;
}

class ConvexClient {
  ConvexClient(
    String address, {
    ConvexClientOptions options = const ConvexClientOptions(),
  }) {
    if (!options.skipConvexDeploymentUrlCheck) validateDeploymentUrl(address);
    _client = BaseConvexClient(address, _transition, options: options);
  }

  late BaseConvexClient _client;
  bool _closed = false;
  final Map<QueryToken, List<void Function()>> _listeners = {};

  bool get closed => _closed;
  BaseConvexClient get client => _client;
  bool get disabled => false;

  Future<void> close() async {
    _closed = true;
    await _client.close();
  }

  Future<void> setAuth(
    AuthTokenFetcher fetchToken,
    void Function(bool isAuthenticated) onChange, [
    void Function(bool isRefreshing)? onRefreshChange,
  ]) => _client.setAuth(fetchToken, onChange, onRefreshChange);

  void clearAuth() => _client.clearAuth();

  ConnectionState connectionState() => _client.connectionState();

  void Function() subscribeToConnectionState(
    void Function(ConnectionState) cb,
  ) => _client.subscribeToConnectionState(cb);

  Unsubscribe<T> onUpdate<T>(
    String query,
    Map<String, Object?> args,
    void Function() callback, {
    SubscribeOptions options = const SubscribeOptions(),
  }) {
    final subscription = _client.subscribe(query, args, options);
    _listeners.putIfAbsent(subscription.queryToken, () => []).add(callback);
    return Unsubscribe<T>(
      unsubscribe: () {
        _listeners[subscription.queryToken]?.remove(callback);
        subscription.unsubscribe();
      },
      getCurrentValue: () =>
          _client.localQueryResultByToken(subscription.queryToken) as T?,
      getQueryLogs: () => _client.localQueryLogs(query, args),
    );
  }

  Future<Object?> mutation(
    String mutation,
    Map<String, Object?> args, {
    OptimisticUpdate? optimisticUpdate,
  }) => _client.mutation(
    mutation,
    args,
    MutationOptions(optimisticUpdate: optimisticUpdate),
  );

  Future<Object?> action(String action, Map<String, Object?> args) =>
      _client.action(action, args);

  Future<Object?> query(String query, Map<String, Object?> args) async =>
      _client.localQueryResult(query, args);

  void _transition(List<QueryToken> updatedQueries) {
    for (final token in updatedQueries) {
      for (final listener in List.of(_listeners[token] ?? const [])) {
        listener();
      }
    }
  }
}
