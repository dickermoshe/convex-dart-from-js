import 'package:example/src/convex/client.dart';
import 'package:test/test.dart';

import 'test_clients.dart';

void main() {
  test('anyReturn', () async {
    final result = await api.primitiveReturns.anyReturn(wsClient, null);
    expect(result, 'Hello');
  });
  test('objectReturn', () async {
    final result = await api.primitiveReturns.objectReturn(wsClient, null);
    expect(result.i, "Hello");
  });
  test('recordReturn', () async {
    final result = await api.primitiveReturns.recordReturn(wsClient, null);
    expect(result, {'i': 'Hello'});
  });
  test('arrayReturn', () async {
    final result = await api.primitiveReturns.arrayReturn(wsClient, null);
    expect(result, ['Hi', 'Hello']);
  });
  test('strReturn', () async {
    final result = await api.primitiveReturns.strReturn(wsClient, null);
    expect(result, 'Hi');
  });
  test('numReturn', () async {
    final result = await api.primitiveReturns.numReturn(wsClient, null);
    expect(result, 1.0);
  });
  test('boolReturn', () async {
    final result = await api.primitiveReturns.boolReturn(wsClient, null);
    expect(result, true);
  });
  test('int64Return', () async {
    final result = await api.primitiveReturns.int64Return(wsClient, null);
    expect(result, BigInt.one);
  });
  test('bytesReturn', () async {
    final result = await api.primitiveReturns.bytesReturn(wsClient, null);
    expect(result, [1, 2, 3, 4, 5, 6, 7, 8]);
  });
  test('nullReturn', () async {
    await api.primitiveReturns.nullReturn(wsClient, null);
    // expect(result, null); Cannot test this because it is a void return
  });
  test('unionReturn', () async {
    final result = await api.primitiveReturns.unionReturn(wsClient, null);
    expect(result.split((value) => value, (value) => value), 'Hi');
  });
  test('emptyObjectArgsReturn', () async {
    final result = await api.primitiveReturns.emptyObjectArgsReturn(
      wsClient,
      null,
    );
    expect(result, isNotNull);
  });
}
