import '../common/index.dart';
import 'sync/authentication_manager.dart';
import 'sync/client.dart';
import 'sync/optimistic_updates.dart';
import 'sync/udf_path_utils.dart';

/// Options for constructing a [ConvexClient].
class ConvexClientOptions extends BaseConvexClientOptions {
  /// Creates client options.
  const ConvexClientOptions({
    super.webSocketFactory,
    super.verbose,
    super.logger,
    super.reportDebugInfoToConvex,
    super.skipConvexDeploymentUrlCheck,
    super.expectAuth,
  });
}

/// Stops callbacks from running.
class Unsubscribe<T> {
  /// Creates an unsubscribe handle.
  Unsubscribe({
    required this.unsubscribe,
    required this.getCurrentValue,
    required this.getQueryLogs,
  });

  /// Stops calling the callback when query results change. If this is the last
  /// listener on this query, stop receiving updates.
  final void Function() unsubscribe;

  /// Returns the last known value, possibly with local optimistic updates
  /// applied.
  final T? Function() getCurrentValue;

  /// Returns log lines forwarded from the server for this query, if available.
  final List<String>? Function() getQueryLogs;
}

/// Subscribes to Convex query functions and executes mutations and actions
/// over a WebSocket.
///
/// Optimistic updates for mutations are supported via [mutation].
/// Third-party clients may choose to wrap [BaseConvexClient] for additional
/// control.
class ConvexClient {
  /// Constructs a client and immediately initiates a WebSocket connection to
  /// [address].
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

  /// Whether [close] has been called. Once closed, no registered callbacks
  /// will fire again.
  bool get closed => _closed;

  /// The underlying [BaseConvexClient].
  BaseConvexClient get client => _client;

  /// Whether the client is disabled. Always `false` for this implementation.
  bool get disabled => false;

  /// Closes the client and stops all subscriptions.
  Future<void> close() async {
    _closed = true;
    await _client.close();
  }

  /// Sets the authentication token to be used for subsequent queries and
  /// mutations.
  ///
  /// [fetchToken] will be called automatically again if a token expires.
  /// [fetchToken] should return `null` if the token cannot be retrieved, for
  /// example when the user's rights were permanently revoked.
  ///
  /// [onChange] is called when the authentication status changes.
  /// [onRefreshChange] is called with `true` when the socket is paused to fetch
  /// a replacement token after a server rejection, and `false` when refresh
  /// completes.
  Future<void> setAuth(
    AuthTokenFetcher fetchToken,
    void Function(bool isAuthenticated) onChange, [
    void Function(bool isRefreshing)? onRefreshChange,
  ]) => _client.setAuth(fetchToken, onChange, onRefreshChange);

  /// Clears the current authentication token.
  void clearAuth() => _client.clearAuth();

  /// Returns the current [ConnectionState] between the client and the Convex
  /// backend.
  ConnectionState connectionState() => _client.connectionState();

  /// Subscribes to [ConnectionState] changes.
  ///
  /// Subscribed callbacks are called when any part of [ConnectionState] changes.
  /// [ConnectionState] may grow in future versions, in which case callbacks
  /// would be called more frequently.
  void Function() subscribeToConnectionState(
    void Function(ConnectionState) cb,
  ) => _client.subscribeToConnectionState(cb);

  /// Registers a callback whenever a new result for a query is received.
  ///
  /// The callback runs soon after registration if a result for the query is
  /// already in memory.
  ///
  /// [query] is the name of the query. [args] are the query arguments.
  /// [callback] is called when the query result updates.
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

  /// Executes a mutation function.
  ///
  /// [mutation] is the name of the mutation. [args] are the mutation arguments.
  /// [optimisticUpdate] optionally applies a local update while the mutation
  /// is pending.
  Future<Object?> mutation(
    String mutation,
    Map<String, Object?> args, {
    OptimisticUpdate? optimisticUpdate,
  }) => _client.mutation(
    mutation,
    args,
    MutationOptions(optimisticUpdate: optimisticUpdate),
  );

  /// Executes an action function.
  ///
  /// [action] is the name of the action. [args] are the action arguments.
  Future<Object?> action(String action, Map<String, Object?> args) =>
      _client.action(action, args);

  /// Fetches a query result once from local state.
  ///
  /// Returns a cached result only if the client is already subscribed to the
  /// query or has an optimistic value.
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
