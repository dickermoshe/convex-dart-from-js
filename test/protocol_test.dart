import 'dart:convert';

import 'package:convex_dart_from_js/src/browser/sync/protocol.dart';
import 'package:convex_dart_from_js/src/browser/sync/udf_path_utils.dart';
import 'package:convex_dart_from_js/src/common/index.dart';
import 'package:test/test.dart';

void main() {
  group('common', () {
    test('parses omitted args as empty map', () {
      expect(parseArgs(null), isEmpty);
      expect(parseArgs({'a': 1.0}), {'a': 1.0});
    });

    test('validates deployment urls', () {
      expect(
        () => validateDeploymentUrl('https://happy-animal-123.convex.cloud'),
        returnsNormally,
      );
      expect(
        () => validateDeploymentUrl('http://localhost:3210'),
        returnsNormally,
      );
      expect(
        () => validateDeploymentUrl('ftp://example.com'),
        throwsArgumentError,
      );
      expect(
        () => validateDeploymentUrl('https://example.com'),
        throwsArgumentError,
      );
    });
  });

  group('protocol', () {
    test('round trips u64 timestamps exactly', () {
      final value = (BigInt.one << 63) + BigInt.from(5);
      expect(u64ToLong(longToU64(value)), value);
    });

    test('encodes connect max observed timestamp', () {
      expect(
        encodeClientMessage({
          'type': 'Connect',
          'sessionId': 's',
          'connectionCount': 0,
          'lastCloseReason': null,
          'maxObservedTimestamp': BigInt.one,
          'clientTs': 10,
        })['maxObservedTimestamp'],
        'AQAAAAAAAAA=',
      );
    });

    test('decodes transition versions', () {
      final decoded = parseServerMessage({
        'type': 'Transition',
        'startVersion': {'querySet': 0, 'ts': 'AAAAAAAAAAA=', 'identity': 0},
        'endVersion': {'querySet': 1, 'ts': 'AQAAAAAAAAA=', 'identity': 0},
        'modifications': [],
      });
      expect((decoded['startVersion'] as Map)['ts'], BigInt.zero);
      expect((decoded['endVersion'] as Map)['ts'], BigInt.one);
    });

    test('decodes mutation success timestamp', () {
      final decoded = decodeServerMessage(
        jsonEncode({
          'type': 'MutationResponse',
          'requestId': 7,
          'success': true,
          'result': null,
          'ts': 'AQAAAAAAAAA=',
          'logLines': [],
        }),
      );
      expect(decoded['ts'], BigInt.one);
    });
  });

  group('udf path utils', () {
    test('canonicalizes paths', () {
      expect(canonicalizeUdfPath('messages'), 'messages:default');
      expect(canonicalizeUdfPath('messages.js:list'), 'messages:list');
      expect(canonicalizeUdfPath('a:b:c'), 'a:b:c');
    });

    test('serializes path and args in Convex JSON form', () {
      expect(
        serializePathAndArgs('messages.js:list', {'n': BigInt.one}),
        '{"udfPath":"messages:list","args":{"n":{"\$integer":"AQAAAAAAAAA="}}}',
      );
    });
  });
}
