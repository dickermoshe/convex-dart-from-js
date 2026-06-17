import 'validators.dart';

bool isValidator(Object? value) => value is Validator;

Validator asObjectValidator(Object value) => value is Validator
    ? value
    : v.object((value as Map).cast<String, Validator>());

const v = ValidatorBuilder();

class ValidatorBuilder {
  const ValidatorBuilder();

  VId id(String tableName) => VId(tableName);
  VNull null_() => VNull();
  VNull nil() => VNull();
  VFloat64 number() => VFloat64();
  VFloat64 float64() => VFloat64();
  VInt64 bigint() => VInt64();
  VInt64 int64() => VInt64();
  VBoolean boolean() => VBoolean();
  VString string() => VString();
  VBytes bytes() => VBytes();
  VLiteral literal(Object value) => VLiteral(value);
  VArray array(Validator element) => VArray(element);
  VObject object(Map<String, Validator> fields) => VObject(fields);
  VRecord record(Validator keys, Validator values) => VRecord(keys, values);
  VUnion union(
    Validator first,
    Validator second, [
    Validator? third,
    Validator? fourth,
  ]) {
    final members = [first, second];
    if (third != null) {
      members.add(third);
    }
    if (fourth != null) {
      members.add(fourth);
    }
    return VUnion(members);
  }

  VUnion unionOf(List<Validator> members) => VUnion(members);
  VAny any() => VAny();
  Validator optional(Validator value) => value.asOptional();
  VUnion nullable(Validator value) => VUnion([value, VNull()]);
}
