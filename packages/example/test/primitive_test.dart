import 'package:convex_dart/convex_dart.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:api/src/convex/client.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

void main() {
  test('anyReturn', () async {
    final result = await api.primitiveReturns.anyReturn();
    expect(result.body, "Hello");
  });
  test('objectReturn', () async {
    final result = await api.primitiveReturns.objectReturn();
    expect(result.i, "Hello");
  });
  test('recordReturn', () async {
    final result = await api.primitiveReturns.recordReturn();
    expect(result.body, {"i": "Hello"}.lock);
  });
  test('arrayReturn', () async {
    final result = await api.primitiveReturns.arrayReturn();
    expect(result.body, ["Hi", "Hello"].lock);
  });
  test('strReturn', () async {
    final result = await api.primitiveReturns.strReturn();
    expect(result.body, "Hi");
  });
  test('numReturn', () async {
    final result = await api.primitiveReturns.numReturn();
    expect(result.body, 1.0);
  });
  test('boolReturn', () async {
    final result = await api.primitiveReturns.boolReturn();
    expect(result.body, true);
  });
  test('int64Return', () async {
    final result = await api.primitiveReturns.int64Return();
    expect(result.body, 1);
  });
  test('bytesReturn', () async {
    final result = await api.primitiveReturns.bytesReturn();
    expect(
      result.body,
      Uint8ListWithEquality.fromList([1, 2, 3, 4, 5, 6, 7, 8]),
    );
  });
  test('nullReturn', () async {
    await api.primitiveReturns.nullReturn();
    // expect(result, null); Cannot test this because it is a void return
  });
  test('unionReturn', () async {
    final result = await api.primitiveReturns.unionReturn();
    expect(result.body, "Hi");
  });
  test('emptyObjectArgsReturn', () async {
    final result = await api.primitiveReturns.emptyObjectArgsReturn();
    expect(result.body != null, true);
  });
}
