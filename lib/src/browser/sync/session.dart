import 'dart:math';

String newSessionId() {
  final random = Random.secure();
  final parts = List.generate(
    16,
    (_) => random.nextInt(256).toRadixString(16).padLeft(2, '0'),
  ).join();
  return parts;
}
