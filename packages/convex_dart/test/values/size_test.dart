import 'dart:typed_data';

import 'package:convex_dart/browser.dart';
import 'package:test/test.dart';

void main() {
  group('getConvexSize parity', () {
    test('matches upstream primitive size formula', () {
      expect(getConvexSize(convexUndefined), 0);
      expect(getConvexSize(null), 1);
      expect(getConvexSize(true), 1);
      expect(getConvexSize(BigInt.zero), 9);
      expect(getConvexSize(1.0), 9);
      expect(getConvexSize('abc'), 5);
      expect(getConvexSize('é'), 4);
      expect(getConvexSize('😀'), 6);
      expect(getConvexSize(Uint8List.fromList([1, 2, 3])), 5);
    });

    test('matches upstream collection size formula', () {
      expect(getConvexSize([null, true, 'x']), 2 + 1 + 1 + 3);
      expect(
        getConvexSize({'a': null, 'emoji': '😀', 'skip': convexUndefined}),
        2 +
            ('a'.codeUnits.length + 1 + getConvexSize(null)) +
            ('emoji'.codeUnits.length + 1 + getConvexSize('😀')),
      );
    });

    test('getDocumentSize adds missing system field estimates', () {
      final document = {'name': 'Ada'};
      expect(
        getDocumentSize(document),
        getConvexSize(document) +
            systemFieldIdEstimate +
            systemFieldCreationTimeSize,
      );
      expect(
        getDocumentSize({...document, '_id': 'abc'}, customIdLength: 12),
        getConvexSize({...document, '_id': 'abc'}) +
            systemFieldCreationTimeSize,
      );
      expect(
        getDocumentSize({...document, '_id': 'abc', '_creationTime': 1.0}),
        getConvexSize({...document, '_id': 'abc', '_creationTime': 1.0}),
      );
      expect(
        getDocumentSize(document, customIdLength: 12),
        getConvexSize(document) + 18 + systemFieldCreationTimeSize,
      );
    });
  });
}
