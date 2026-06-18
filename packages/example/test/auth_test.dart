import 'package:example/src/convex/client.dart';
import 'package:test/test.dart';

void main() {
  test('setAuth with invalid token can be configured', () {
    final client = MyConvexClient();
    expect(() => client.setAuth('invalid_token'), returnsNormally);
  });
}
