/// Dart client library for [Convex](https://convex.dev).
///
/// This package is a port of the Convex JavaScript browser client from
/// `convex-js` at `npm/1.41.0`. Import `package:convex_dart/browser.dart` for
/// HTTP and WebSocket clients, value encoding, and validators.
library;

import 'dart:async';

import 'package:convex_dart/src/browser.dart';
export 'src/browser.dart';

sealed class ConvexFunction<Args, Returns> {
  final String path;
  ConvexFunction(this.path);
  Map<String, Object?> parseArgs(Args args);
  Args parseArgsFromRaw(Map<String, Object?> rawArgs);
  Returns parseReturns(Object? returns);
}

abstract class ConvexQuery<Args, Returns>
    extends ConvexFunction<Args, Returns> {
  ConvexQuery(super.path);
}

abstract class ConvexMutation<Args, Returns>
    extends ConvexFunction<Args, Returns> {
  ConvexMutation(super.path);
}

abstract class ConvexAction<Args, Returns>
    extends ConvexFunction<Args, Returns> {
  ConvexAction(super.path);
}

extension ConvexHttpClientExtension on ConvexHttpClient {
  /// Runs [query] with [args] and returns its typed result.
  Future<Returns> query<
    Args,
    Returns,
    Query extends ConvexQuery<Args, Returns>
  >(Query query, Args args) async {
    final raw = await rawQuery(query.path, query.parseArgs(args));
    return query.parseReturns(raw);
  }

  /// Runs [mutation] with [args] and returns its typed result.
  Future<Returns>
  mutation<Args, Returns, Mutation extends ConvexMutation<Args, Returns>>(
    Mutation mutation,
    Args args, [
    HttpMutationOptions options = const HttpMutationOptions(),
  ]) async {
    final raw = await rawMutation(
      mutation.path,
      mutation.parseArgs(args),
      options,
    );
    return mutation.parseReturns(raw);
  }

  /// Runs [action] with [args] and returns its typed result.
  Future<Returns> action<
    Args,
    Returns,
    Action extends ConvexAction<Args, Returns>
  >(Action action, Args args) async {
    final raw = await rawAction(action.path, action.parseArgs(args));
    return action.parseReturns(raw);
  }
}

extension ConvexClientExtension on ConvexClient {
  /// Runs [query] with [args] and returns its typed result.
  Future<Returns> query<
    Args,
    Returns,
    Query extends ConvexQuery<Args, Returns>
  >(Query query, Args args) async {
    final raw = await rawQuery(query.path, query.parseArgs(args));
    return query.parseReturns(raw);
  }

  /// Runs [mutation] with [args] and returns its typed result.
  ///
  /// Use [optimisticUpdate] to update local query results immediately while the
  /// mutation is pending.
  Future<Returns> mutation<
    Args,
    Returns,
    Mutation extends ConvexMutation<Args, Returns>
  >(Mutation mutation, Args args, [OptimisticUpdate? optimisticUpdate]) async {
    final raw = await rawMutation(
      mutation.path,
      mutation.parseArgs(args),
      optimisticUpdate: optimisticUpdate,
    );
    return mutation.parseReturns(raw);
  }

  /// Runs [action] with [args] and returns its typed result.
  Future<Returns> action<
    Args,
    Returns,
    Action extends ConvexAction<Args, Returns>
  >(Action action, Args args) async {
    final raw = await rawAction(action.path, action.parseArgs(args));
    return action.parseReturns(raw);
  }

  /// Watches [query] with [args] and emits a typed result each time it changes.
  Stream<Returns> watch<
    Args,
    Returns,
    Query extends ConvexQuery<Args, Returns>
  >(Query query, Args args) {
    final c = StreamController<Returns>();
    final sub = onUpdate<Object?>(query.path, query.parseArgs(args), (result) {
      c.add(query.parseReturns(result));
    }, onError: c.addError);
    c.onCancel = sub.unsubscribe;
    return c.stream;
  }

  /// Watches the client's connection state.
  Stream<ConnectionState> watchConnectionState() {
    final c = StreamController<ConnectionState>();
    c.onCancel = subscribeToConnectionState(c.add);
    return c.stream;
  }
}

extension OptimisticLocalStoreExtention on OptimisticLocalStore {
  /// Reads the current local value for [query] and [args].
  ///
  /// Returns `null` when there is no local value for this query.
  Returns? getQuery<Args, Returns>(
    ConvexQuery<Args, Returns> query,
    Args args,
  ) {
    final raw = getRawQuery(query.path, query.parseArgs(args));
    if (raw == null) {
      return null;
    }
    return query.parseReturns(raw);
  }

  /// Reads every local value for [query].
  ///
  /// This is useful when the same query is active with multiple argument sets.
  List<({Args args, Returns? value})> getAllQueries<Args, Returns>(
    ConvexQuery<Args, Returns> query,
  ) {
    return [
      for (final rawQuery in getAllRawQueries(query.path))
        (
          args: query.parseArgsFromRaw(rawQuery.args),
          value: rawQuery.value == null
              ? null
              : query.parseReturns(rawQuery.value),
        ),
    ];
  }

  /// Sets the local value for [query] and [args].
  void setQuery<Args, Returns>(
    ConvexQuery<Args, Returns> query,
    Args args,
    Returns value,
  ) {
    setRawQuery(query.path, query.parseArgs(args), value);
  }
}

/// An interface for a Convex table ID.
abstract interface class TableId {
  String get name;
}

/// Base class for all literal types.
abstract interface class Literal<T> {
  T get value;
}
