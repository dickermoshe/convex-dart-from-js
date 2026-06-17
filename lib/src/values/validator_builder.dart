import 'validators.dart';

/// Coerce a field map or existing validator into an object validator.
Validator asObjectValidator(Object value) {
  if (value is Validator) return value;
  if (value is Map<String, Validator>) return v.object(value);
  throw ArgumentError('Expected a validator or a map of validators.');
}

/// Builder for Convex validators.
const v = ValidatorBuilder();

class ValidatorBuilder {
  const ValidatorBuilder();

  VId id(String tableName) {
    if (tableName.isEmpty) {
      throw ArgumentError('v.id(tableName) requires a non-empty string');
    }
    return VId(tableName: tableName);
  }

  VNull nullValue() => const VNull();
  VNull null_() => const VNull();
  VFloat64 number() => const VFloat64();
  VFloat64 float64() => const VFloat64();
  VInt64 int64() => const VInt64();
  VBoolean boolean() => const VBoolean();
  VString string() => const VString();
  VBytes bytes() => const VBytes();

  VLiteral literal(Object value) {
    if (value is! String && value is! bool && value is! num) {
      throw ArgumentError(
        'v.literal(value) must be a string, number, or boolean',
      );
    }
    return VLiteral(value);
  }

  VArray array(Validator element) => VArray(element);
  VObject object(Map<String, Validator> fields) => VObject(fields);
  VRecord record(Validator keys, Validator values) => VRecord(keys, values);
  VUnion union(List<Validator> members) => VUnion(members);
  VAny any() => const VAny();
  Validator optional(Validator value) => value.asOptional();
  VUnion nullable(Validator value) => VUnion([value, const VNull()]);
}
