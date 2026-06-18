import 'package:flutter_test/flutter_test.dart';
import 'package:api/src/convex/client.dart';

void main() {
  test('GET request with pathPrefix returns "1"', () async {
    // Without setting a suffix, we will resolve to the other route
    final response = await ConvexClient.get$api$v1$$(suffix: "sdfsdf");
    expect(response.statusCode, 200);
    expect(response.body, '1');
  });

  test('GET request with exact path returns "2}"', () async {
    final response = await ConvexClient.get$api$v1$();
    expect(response.statusCode, 200);
    expect(response.body, '2');
  });

  test('POST request returns "3"', () async {
    final response = await ConvexClient.post$api$v1$();
    expect(response.statusCode, 200);
    expect(response.body, '3');
  });

  test('PUT request returns "4"', () async {
    final response = await ConvexClient.put$api$v1$();
    expect(response.statusCode, 200);
    expect(response.body, '4');
  });

  test('DELETE request returns "5"', () async {
    final response = await ConvexClient.delete$api$v1$();
    expect(response.statusCode, 200);
    expect(response.body, '5');
  });

  test('PATCH request returns "6"', () async {
    final response = await ConvexClient.patch$api$v1$();
    expect(response.statusCode, 200);
    expect(response.body, '6');
  });

  test('GET request with custom headers', () async {
    final headers = {'Custom-Header': 'test-value'};
    final response = await ConvexClient.get$api$v1$(headers: headers);
    expect(response.statusCode, 200);
    expect(response.body, '2');
  });

  test('POST request with body', () async {
    final response = await ConvexClient.post$api$v1$(body: 'test body');
    expect(response.statusCode, 200);
    expect(response.body, '3');
  });

  test('PUT request with body', () async {
    final response = await ConvexClient.put$api$v1$(body: 'test body');
    expect(response.statusCode, 200);
    expect(response.body, '4');
  });

  test('DELETE request with body', () async {
    final response = await ConvexClient.delete$api$v1$(body: 'test body');
    expect(response.statusCode, 200);
    expect(response.body, '5');
  });

  test('PATCH request with body', () async {
    final response = await ConvexClient.patch$api$v1$(body: 'test body');
    expect(response.statusCode, 200);
    expect(response.body, '6');
  });
}
