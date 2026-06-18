import 'package:example/src/convex/client.dart';
import 'package:test/test.dart';

void main() {
  test('generated API is available', () {
    expect(api.tasks.createTask.path, 'tasks:createTask');
    expect(api.primitiveReturns.anyReturn.path, 'primitive_returns:anyReturn');
  });
}
