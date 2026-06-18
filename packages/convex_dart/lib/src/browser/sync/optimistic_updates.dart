/// A view of the query results currently in the Convex client for use within
/// optimistic updates.
abstract interface class OptimisticLocalStore {
  /// Retrieves the result of a query from the client.
  ///
  /// Important: Query results should be treated as immutable. Always make new
  /// copies of structures within query results to avoid corrupting data within
  /// the client.
  ///
  /// [query] is the name of the query. [args] are the query arguments.
  /// Returns the query result, or `null` if the query is not currently in the
  /// client.
  Object? getQuery(String query, [Map<String, Object?>? args]);

  /// Retrieves the results and arguments of all queries with a given name.
  ///
  /// This is useful for complex optimistic updates that need to inspect and
  /// update many query results (for example updating a paginated list).
  ///
  /// Important: Query results should be treated as immutable. Always make new
  /// copies of structures within query results to avoid corrupting data within
  /// the client.
  ///
  /// [query] is the name of the query. Returns one entry per active query of
  /// that name, each with `args` and `value` (which may be `null` while
  /// loading).
  List<({Map<String, Object?> args, Object? value})> getAllQueries(
    String query,
  );

  /// Optimistically updates the result of a query.
  ///
  /// [value] may be derived from the old value from [getQuery], or `null` to
  /// remove the query. Removing a query is useful to create loading states while
  /// Convex recomputes the query results.
  ///
  /// [query] is the name of the query. [args] are the query arguments.
  /// [value] is the new value to set the query to, or `null` to remove it from
  /// the client.
  void setQuery(String query, Map<String, Object?> args, Object? value);
}

/// A temporary, local update to query results within this client.
///
/// This update will always be executed when a mutation is synced to the Convex
/// server and rolled back when the mutation completes.
///
/// Note that optimistic updates can be called multiple times. If the client
/// loads new data while the mutation is in progress, the update will be
/// replayed again.
///
/// [localQueryStore] is an interface to read and edit local query results.
/// [args] are the arguments to the mutation.
typedef OptimisticUpdate =
    void Function(
      OptimisticLocalStore localQueryStore,
      Map<String, Object?> args,
    );
