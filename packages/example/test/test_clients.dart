import 'package:convex_dart/convex_dart.dart';
import 'package:example/src/convex/client.dart';

final httpClient = MyConvexClient();
final wsClient = MyConvexWebsocketClient();

extension TestQueryCall<Args, Returns> on ConvexQuery<Args, Returns> {
  Future<Returns> call([Args? args]) => httpClient.query(this, args as Args);

  Stream<Returns> watch([Args? args]) => wsClient.watch(this, args as Args);
}

extension TestMutationCall<Args, Returns> on ConvexMutation<Args, Returns> {
  Future<Returns> call([Args? args]) => httpClient.mutation(this, args as Args);
}

extension TestActionCall<Args, Returns> on ConvexAction<Args, Returns> {
  Future<Returns> call([Args? args]) => httpClient.action(this, args as Args);
}
