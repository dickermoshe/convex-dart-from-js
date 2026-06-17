import 'dart:async';
import 'dart:convert';

import 'package:convex_dart/browser.dart';
import 'package:rxdart/rxdart.dart';

const apiSpecQuery = '_system/cli/modules:apiSpec';
const cloudUrlQuery = '_system/cli/convexUrl:cloudUrl';

/// Subscribes to function spec system queries over WebSocket and emits
/// indented JSON whenever either query changes.
///
/// Cancel the returned stream (or break out of `await for`) to unsubscribe
/// and close the connection.
Stream<String> watchFunctionSpec({
  required String deploymentUrl,
  required String adminKey,
}) {
  final functions$ = PublishSubject<Object?>();
  final url$ = PublishSubject<Object?>();

  BaseConvexClient? client;
  QueryToken? apiSpecToken;
  QueryToken? cloudUrlToken;
  void Function()? unsubscribeApiSpec;
  void Function()? unsubscribeCloudUrl;
  var closed = false;

  Future<void> close() async {
    if (closed) return;
    closed = true;

    unsubscribeApiSpec?.call();
    unsubscribeCloudUrl?.call();
    unsubscribeApiSpec = null;
    unsubscribeCloudUrl = null;

    await client?.close();
    client = null;

    await functions$.close();
    await url$.close();
  }

  void onTransition(List<QueryToken> updatedTokens) {
    final activeClient = client;
    if (activeClient == null || closed) return;

    for (final token in updatedTokens) {
      if (token == apiSpecToken) {
        functions$.add(activeClient.localQueryResultByToken(token));
      } else if (token == cloudUrlToken) {
        url$.add(activeClient.localQueryResultByToken(token));
      }
    }
  }

  final activeClient = BaseConvexClient(
    deploymentUrl,
    onTransition,
    options: const BaseConvexClientOptions(),
  );
  client = activeClient;
  activeClient.setAdminAuth(adminKey);

  final apiSpecSub = activeClient.subscribe(apiSpecQuery, {});
  final cloudUrlSub = activeClient.subscribe(cloudUrlQuery, {});
  apiSpecToken = apiSpecSub.queryToken;
  cloudUrlToken = cloudUrlSub.queryToken;
  unsubscribeApiSpec = apiSpecSub.unsubscribe;
  unsubscribeCloudUrl = cloudUrlSub.unsubscribe;

  return Rx.combineLatest2(
    functions$,
    url$,
    (Object? functions, Object? url) => const JsonEncoder.withIndent(
      '  ',
    ).convert({'url': convexToJson(url), 'functions': convexToJson(functions)}),
  ).distinct().doOnCancel(() => unawaited(close()));
}
