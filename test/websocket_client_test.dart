import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:convex_dart_from_js/convex_dart_from_js.dart';
import 'package:test/test.dart';
import 'package:web_socket_channel/io.dart';

void main() {
  test(
    'WebSocket client subscribes, receives transitions, and resolves mutations',
    () async {
      final sent = <Map<String, Object?>>[];
      final received = <Object?>[];
      final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
      final serverSub = server.listen((request) async {
        final socket = await WebSocketTransformer.upgrade(request);
        socket.listen((message) {
          final decoded = jsonDecode(message as String) as Map<String, Object?>;
          sent.add(decoded);
          if (decoded['type'] == 'ModifyQuerySet') {
            socket.add(
              jsonEncode({
                'type': 'Transition',
                'startVersion': {
                  'querySet': 0,
                  'ts': 'AAAAAAAAAAA=',
                  'identity': 0,
                },
                'endVersion': {
                  'querySet': 1,
                  'ts': 'AQAAAAAAAAA=',
                  'identity': 0,
                },
                'modifications': [
                  {
                    'type': 'QueryUpdated',
                    'queryId': 0,
                    'value': 'ok',
                    'logLines': <String>[],
                    'journal': null,
                  },
                ],
              }),
            );
          }
          if (decoded['type'] == 'Mutation') {
            socket.add(
              jsonEncode({
                'type': 'MutationResponse',
                'requestId': decoded['requestId'],
                'success': true,
                'result': {r'$integer': 'AgAAAAAAAAA='},
                'ts': 'AgAAAAAAAAA=',
                'logLines': <String>[],
              }),
            );
          }
        });
      });

      final client = ConvexClient(
        'http://${server.address.host}:${server.port}',
        ConvexClientOptions(
          skipConvexDeploymentUrlCheck: true,
          webSocketConnector: IOWebSocketChannel.connect,
        ),
      );

      final sub = client.onUpdate<Object?>('messages:list', {}, received.add);
      for (var i = 0; i < 50 && received.isEmpty; i++) {
        await Future<void>.delayed(const Duration(milliseconds: 20));
      }
      expect(received, ['ok']);
      expect(await client.mutation('messages:send', {'body': 'hi'}), 2);
      expect(
        sent.map((m) => m['type']),
        containsAll(['Connect', 'ModifyQuerySet', 'Mutation']),
      );

      sub.unsubscribe();
      await client.close();
      await serverSub.cancel();
      await server.close(force: true);
    },
  );
}
