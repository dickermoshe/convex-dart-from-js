import 'dart:async';

import 'package:convex_dart/convex_dart.dart';
import 'package:example/src/convex/client.dart';
import 'package:test/test.dart';

void main() {
  late MyConvexWebsocketClient client;

  setUp(() {
    client = MyConvexWebsocketClient();
  });

  tearDown(() async {
    await client.close();
  });

  test('query calls through the websocket Convex client', () async {
    final result = await client.query(api.primitiveReturns.anyReturn, null);

    expect(result, 'Hello');
  });

  test('query stream emits and can be cancelled', () async {
    final firstValue = Completer<Object?>();
    late final StreamSubscription<Object?> subscription;

    subscription = client
        .watch(api.primitiveReturns.anyReturn, null)
        .listen(firstValue.complete, onError: firstValue.completeError);

    final result = await firstValue.future.timeout(const Duration(seconds: 15));
    expect(result, 'Hello');

    await subscription.cancel();
  });
}
