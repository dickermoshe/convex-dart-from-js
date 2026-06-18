/// A type-safe alternative to nullable types that explicitly represents optional values.
///
/// This sealed class provides two variants:
/// - [Defined<T>]: Contains a value of type T
/// - [Undefined<T>]: Represents the absence of a value
///
/// Example:
/// ```dart
/// Optional<String> name = Optional.defined('John');
/// Optional<String> empty = Optional.undefined();
///
/// if (name.isDefined) {
///   print(name.value); // 'John'
/// }
/// ```
sealed class Optional<T> {
  const Optional();

  /// Creates an [Optional] containing the given [value].
  const factory Optional.defined(T value) = Defined<T>;

  /// Creates an [Optional] representing the absence of a value.
  const factory Optional.undefined() = Undefined<T>;

  /// Returns the contained value if defined, otherwise null.
  T? get value;

  /// Returns true if this [Optional] contains a value.
  bool get isDefined => this is Defined;

  /// Casts this [Optional] to [Defined<T>].
  ///
  /// Throws a [TypeError] if this is [Undefined].
  Defined<T> asDefined() => this as Defined<T>;
}

/// Represents the absence of a value in an [Optional].
class Undefined<T> extends Optional<T> {
  const Undefined();
  @override
  String toString() {
    return 'Undefined()';
  }

  @override
  bool operator ==(Object other) {
    return other is Undefined;
  }

  @override
  int get hashCode => 0;
  @override
  T? get value => null;
}

/// Represents a defined value in an [Optional].
class Defined<T> extends Optional<T> {
  @override
  final T value;
  const Defined(this.value);
  @override
  String toString() {
    return 'Defined($value)';
  }

  @override
  bool operator ==(Object other) {
    return other is Defined && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;
}
