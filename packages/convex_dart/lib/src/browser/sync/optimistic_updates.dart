abstract interface class OptimisticLocalStore {
  Object? getQuery(String query, [Map<String, Object?>? args]);
  List<({Map<String, Object?> args, Object? value})> getAllQueries(
    String query,
  );
  void setQuery(String query, Map<String, Object?> args, Object? value);
}

typedef OptimisticUpdate =
    void Function(
      OptimisticLocalStore localQueryStore,
      Map<String, Object?> args,
    );
