import 'dart:convert';

import 'package:convex_dart/src/browser/sync/protocol.dart';
import 'package:convex_dart/src/browser/sync/udf_path_utils.dart';
import 'package:convex_dart/src/common/index.dart';
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
        () => validateDeploymentUrl('https://example.com'),
        returnsNormally,
      );
      expect(
        () => validateDeploymentUrl('ftp://example.com'),
        throwsArgumentError,
      );
      expect(
        () => validateDeploymentUrl('https://example.convex.site'),
        throwsArgumentError,
      );
    });
  });

  group('protocol u64', () {
    test('round trips u64 timestamps exactly', () {
      final value = (BigInt.one << 63) + BigInt.from(5);
      expect(u64ToLong(longToU64(value)), value);
    });

    test('longToU64 edge cases', () {
      expect(u64ToLong(longToU64(BigInt.zero)), BigInt.zero);
      expect(u64ToLong(longToU64(BigInt.one)), BigInt.one);
      expect(
        u64ToLong(longToU64((BigInt.one << 64) - BigInt.one)),
        (BigInt.one << 64) - BigInt.one,
      );
      expect(() => longToU64(-BigInt.one), throwsArgumentError);
    });
  });

  group('protocol client messages', () {
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

    test('encodeClientMessageToJson round trips mutation', () {
      final json = encodeClientMessageToJson({
        'type': 'Mutation',
        'requestId': 1,
        'udfPath': 'send',
        'args': [<Object?>[]],
      });
      final decoded = jsonDecode(json) as Map;
      expect(decoded['type'], 'Mutation');
      expect(decoded['requestId'], 1);
    });
  });

  group('protocol server messages', () {
    test('decodes transition versions', () {
      final decoded = parseServerMessage({
        'type': 'Transition',
        'startVersion': {'querySet': 0, 'ts': 'AAAAAAAAAAA=', 'identity': 0},
        'endVersion': {'querySet': 1, 'ts': 'AQAAAAAAAAA=', 'identity': 0},
        'modifications': <Object?>[],
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
          'logLines': <Object?>[],
        }),
      );
      expect(decoded['ts'], BigInt.one);
    });

    test('passes through AuthError and Ping', () {
      expect(parseServerMessage({'type': 'AuthError'})['type'], 'AuthError');
      expect(parseServerMessage({'type': 'Ping'})['type'], 'Ping');
    });

    test('throws on unknown server message type', () {
      expect(
        () => parseServerMessage({'type': 'Unknown'}),
        throwsFormatException,
      );
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

    test('serializes paginated query tokens', () {
      final token = serializePaginatedPathAndArgs(
        'messages:list',
        {},
        initialNumItems: 10,
        id: 1,
      );
      expect(token, contains('"type":"paginated"'));
    });
  });
}
