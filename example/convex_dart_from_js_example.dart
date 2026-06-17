import 'package:convex_dart_from_js/convex_dart_from_js.dart';

void main() {
  final encoded = convexToJson({'count': 1, 'name': 'Ada'});
  print(encoded);
}
