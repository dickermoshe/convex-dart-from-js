import 'dart:convert';

import 'package:convex_dart_from_js/convex_dart_from_js.dart';
import 'package:convex_dart_from_js/src/browser/sync/web_socket_manager.dart';
import 'package:test/test.dart';

void main() {
  group('BaseConvexClient', () {
    test('sends connect and query set on open, then applies transition', () {
      late _FakeSocket socket;
      final updated = <List<QueryToken>>[];
      final client = BaseConvexClient(
        'https://x.convex.cloud',
        (queries) => updated.add(queries),
        options: BaseConvexClientOptions(
          webSocketFactory: (_) => socket = _FakeSocket(),
        ),
      );
      final sub = client.subscribe('messages.js:list', {'n': BigInt.one});

      socket.open();
      expect(_sentTypes(socket), ['Connect', 'ModifyQuerySet']);
      final add = _sent(socket, 1);
      expect(
        ((add['modifications'] as List).single as Map)['udfPath'],
        'messages:list',
      );

      socket.message(
        _transitionJson(
          startQuerySet: 0,
          endQuerySet: 1,
          modifications: [
            {
              'type': 'QueryUpdated',
              'queryId': 0,
              'value': 'hello',
              'logLines': [],
              'journal': null,
            },
          ],
        ),
      );

      expect(updated.last, [sub.queryToken]);
      expect(client.localQueryResultByToken(sub.queryToken), 'hello');
    });

    test(
      'mutation resolves after transition reaches mutation timestamp',
      () async {
        late _FakeSocket socket;
        final client = BaseConvexClient(
          'https://x.convex.cloud',
          (_) {},
          options: BaseConvexClientOptions(
            webSocketFactory: (_) => socket = _FakeSocket(),
          ),
        );
        socket.open();
        socket.message(
          _transitionJson(startQuerySet: 0, endQuerySet: 1, modifications: []),
        );
        final mutation = client.mutation('send', {'body': 'hi'});
        final mutationMessage = _sent(socket, socket.sent.length - 1);
        expect(mutationMessage['type'], 'Mutation');

        socket.message(
          jsonEncode({
            'type': 'MutationResponse',
            'requestId': mutationMessage['requestId'],
            'success': true,
            'result': 'ok',
            'ts': 'AQAAAAAAAAA=',
            'logLines': [],
          }),
        );
        await Future<void>.delayed(Duration.zero);
        expect(client.connectionState().hasInflightRequests, isTrue);

        socket.message(
          _transitionJson(
            startQuerySet: 1,
            endQuerySet: 1,
            startTs: 'AAAAAAAAAAA=',
            endTs: 'AQAAAAAAAAA=',
            modifications: [],
          ),
        );
        expect(await mutation, 'ok');
        expect(client.connectionState().hasInflightRequests, isFalse);
      },
    );

    test('optimistic update changes local subscribed query immediately', () {
      late _FakeSocket socket;
      final updated = <List<QueryToken>>[];
      final client = BaseConvexClient(
        'https://x.convex.cloud',
        (queries) => updated.add(queries),
        options: BaseConvexClientOptions(
          webSocketFactory: (_) => socket = _FakeSocket(),
        ),
      );
      final sub = client.subscribe('messages:list', {});
      socket.open();
      socket.message(
        _transitionJson(
          startQuerySet: 0,
          endQuerySet: 1,
          modifications: [
            {
              'type': 'QueryUpdated',
              'queryId': 0,
              'value': [],
              'logLines': [],
              'journal': null,
            },
          ],
        ),
      );

      client.enqueueMutation(
        'send',
        {'body': 'hi'},
        MutationOptions(
          optimisticUpdate: (store, args) {
            final current =
                (store.getQuery('messages:list', {}) as List?) ?? [];
            store.setQuery('messages:list', {}, [...current, args['body']]);
          },
        ),
      );

      expect(client.localQueryResultByToken(sub.queryToken), ['hi']);
      expect(updated.last, [sub.queryToken]);
    });
  });
}

List<String> _sentTypes(_FakeSocket socket) => socket.sent
    .map((raw) => (jsonDecode(raw) as Map)['type'] as String)
    .toList();

Map<String, Object?> _sent(_FakeSocket socket, int index) =>
    (jsonDecode(socket.sent[index]) as Map).cast<String, Object?>();

String _transitionJson({
  required int startQuerySet,
  required int endQuerySet,
  String startTs = 'AAAAAAAAAAA=',
  String endTs = 'AAAAAAAAAAA=',
  required List<Map<String, Object?>> modifications,
}) => jsonEncode({
  'type': 'Transition',
  'startVersion': {'querySet': startQuerySet, 'ts': startTs, 'identity': 0},
  'endVersion': {'querySet': endQuerySet, 'ts': endTs, 'identity': 0},
  'modifications': modifications,
});

class _FakeSocket implements SyncWebSocket {
  final sent = <String>[];
  @override
  void Function(int code, String reason)? onClose;
  @override
  void Function(Object error)? onError;
  @override
  void Function(Object? data)? onMessage;
  @override
  void Function()? onOpen;

  void open() => onOpen?.call();
  void message(String data) => onMessage?.call(data);

  @override
  void close() {}

  @override
  void send(String message) {
    sent.add(message);
  }
}
