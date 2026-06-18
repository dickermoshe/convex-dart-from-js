import 'dart:async';

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
    this.disabled = false,
  });

  /// Makes subscription registration a no-op and query, mutation, and action
  /// calls throw.
  final bool disabled;
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
/// Optimistic updates for mutations are supported via [rawMutation].
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
    _disabled = options.disabled;
    if (!_disabled) {
      _client = BaseConvexClient(address, _transition, options: options);
    }
  }

  BaseConvexClient? _client;
  bool _closed = false;
  var _disabled = false;
  final Set<_QueryInfo> _listeners = {};
  bool _callNewListenersWithCurrentValuesScheduled = false;

  /// Whether [close] has been called. Once closed, no registered callbacks
  /// will fire again.
  bool get closed => _closed;

  /// The underlying [BaseConvexClient].
  BaseConvexClient get client {
    final activeClient = _client;
    if (activeClient == null) {
      throw StateError('ConvexClient is disabled');
    }
    return activeClient;
  }

  /// Whether the client is disabled.
  bool get disabled => _disabled;

  /// Closes the client and stops all subscriptions.
  Future<void> close() async {
    if (disabled) return;
    _listeners.clear();
    _closed = true;
    await client.close();
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
  ]) {
    if (disabled) return Future<void>.value();
    return client.setAuth(fetchToken, onChange, onRefreshChange);
  }

  /// Clears the current authentication token.
  void clearAuth() {
    if (disabled) return;
    client.clearAuth();
  }

  /// Gets the current JWT auth token and decoded claims, if user auth is set.
  ({String token, Map<String, Object?> decoded})? getAuth() {
    if (disabled) return null;
    return client.getCurrentAuthClaims();
  }

  /// Sets admin auth to allow calling internal functions and acting as an
  /// identity.
  void setAdminAuth(String token, [Map<String, Object?>? identity]) {
    if (closed) {
      throw StateError('ConvexClient has already been closed.');
    }
    if (disabled) return;
    client.setAdminAuth(token, identity);
  }

  /// Returns the current [ConnectionState] between the client and the Convex
  /// backend.
  ConnectionState connectionState() {
    if (disabled) {
      throw StateError('ConvexClient is disabled');
    }
    return client.connectionState();
  }

  /// Subscribes to [ConnectionState] changes.
  ///
  /// Subscribed callbacks are called when any part of [ConnectionState] changes.
  /// [ConnectionState] may grow in future versions, in which case callbacks
  /// would be called more frequently.
  void Function() subscribeToConnectionState(
    void Function(ConnectionState) cb,
  ) {
    if (disabled) return () {};
    return client.subscribeToConnectionState(cb);
  }

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
    void Function(T? value) callback, {
    void Function(Object error, StackTrace stackTrace)? onError,
    SubscribeOptions options = const SubscribeOptions(),
  }) {
    if (disabled) {
      return _createDisabledUnsubscribe<T>();
    }
    final subscription = client.subscribe(query, args, options);
    final queryInfo = _QueryInfo(
      queryToken: subscription.queryToken,
      callback: (value) => callback(value as T?),
      onError: onError,
      unsubscribe: subscription.unsubscribe,
    );
    _listeners.add(queryInfo);

    if (client.hasLocalQueryResultByToken(subscription.queryToken) &&
        !_callNewListenersWithCurrentValuesScheduled) {
      _callNewListenersWithCurrentValuesScheduled = true;
      scheduleMicrotask(_callNewListenersWithCurrentValues);
    }

    return Unsubscribe<T>(
      unsubscribe: () {
        if (closed) return;
        _listeners.remove(queryInfo);
        queryInfo.unsubscribe();
      },
      getCurrentValue: () =>
          client.localQueryResultByToken(subscription.queryToken) as T?,
      getQueryLogs: () => client.localQueryLogs(query, args),
    );
  }

  /// Executes a mutation function.
  ///
  /// [mutation] is the name of the mutation. [args] are the mutation arguments.
  /// [optimisticUpdate] optionally applies a local update while the mutation
  /// is pending.
  Future<Object?> rawMutation(
    String mutation,
    Map<String, Object?> args, {
    OptimisticUpdate? optimisticUpdate,
  }) {
    if (disabled) {
      throw StateError('ConvexClient is disabled');
    }
    return client.mutation(
      mutation,
      args,
      MutationOptions(optimisticUpdate: optimisticUpdate),
    );
  }

  /// Executes an action function.
  ///
  /// [action] is the name of the action. [args] are the action arguments.
  Future<Object?> rawAction(String action, Map<String, Object?> args) {
    if (disabled) {
      throw StateError('ConvexClient is disabled');
    }
    return client.action(action, args);
  }

  /// Fetches a query result once.
  ///
  /// Returns a cached result if present. Otherwise subscribes to the query,
  /// waits for the first result, and then unsubscribes.
  Future<Object?> rawQuery(String query, Map<String, Object?> args) {
    if (disabled) {
      throw StateError('ConvexClient is disabled');
    }
    final queryToken = serializePathAndArgs(query, parseArgs(args));
    if (client.hasLocalQueryResultByToken(queryToken)) {
      return Future<Object?>.value(client.localQueryResultByToken(queryToken));
    }

    final completer = Completer<Object?>();
    late final Unsubscribe<Object?> subscription;
    subscription = onUpdate<Object?>(
      query,
      args,
      (value) {
        subscription.unsubscribe();
        if (!completer.isCompleted) {
          completer.complete(value);
        }
      },
      onError: (error, stackTrace) {
        subscription.unsubscribe();
        if (!completer.isCompleted) {
          completer.completeError(error, stackTrace);
        }
      },
    );
    return completer.future;
  }

  Unsubscribe<T> _createDisabledUnsubscribe<T>() {
    void unsubscribe() {}
    return Unsubscribe<T>(
      unsubscribe: unsubscribe,
      getCurrentValue: () => null,
      getQueryLogs: () => null,
    );
  }

  void _callNewListenersWithCurrentValues() {
    _callNewListenersWithCurrentValuesScheduled = false;
    _transition(const [], callNewListeners: true);
  }

  void _transition(
    List<QueryToken> updatedQueries, {
    bool callNewListeners = false,
  }) {
    if (closed) return;

    final updated = updatedQueries.toSet();
    for (final queryInfo in List.of(_listeners)) {
      final hasResultReady = client.hasLocalQueryResultByToken(
        queryInfo.queryToken,
      );
      if (!updated.contains(queryInfo.queryToken) &&
          !(callNewListeners && !queryInfo.hasEverRun && hasResultReady)) {
        continue;
      }

      queryInfo.hasEverRun = true;
      try {
        final value = client.localQueryResultByToken(queryInfo.queryToken);
        queryInfo.call(value);
      } on Object catch (error, stackTrace) {
        final onError = queryInfo.onError;
        if (onError != null) {
          onError(error, stackTrace);
        } else {
          scheduleMicrotask(() {
            Error.throwWithStackTrace(error, stackTrace);
          });
        }
      }
    }
  }
}

class _QueryInfo {
  _QueryInfo({
    required this.queryToken,
    required this.callback,
    required this.onError,
    required this.unsubscribe,
  });

  final QueryToken queryToken;
  final void Function(Object? value) callback;
  final void Function(Object error, StackTrace stackTrace)? onError;
  final void Function() unsubscribe;
  bool hasEverRun = false;

  void call(Object? value) {
    callback(value);
  }
}
