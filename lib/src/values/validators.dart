import 'value.dart';

typedef ValidatorJson = Map<String, Object?>;
typedef ObjectFieldType = Map<String, Object?>;
typedef RecordKeyValidatorJson = Map<String, Object?>;
typedef RecordValueValidatorJson = Map<String, Object?>;

/// Whether a validator is required or optional inside an object.
enum OptionalProperty { required, optional }

/// Base class for Convex validators.
abstract class Validator {
  const Validator({this.isOptional = OptionalProperty.required});

  final OptionalProperty isOptional;
  bool get isConvexValidator => true;
  String get kind;
  ValidatorJson get json;
  Validator asOptional();
}

class VId extends Validator {
  const VId({
    required this.tableName,
    super.isOptional = OptionalProperty.required,
  });

  final String tableName;
  @override
  String get kind => 'id';
  @override
  ValidatorJson get json => {'type': 'id', 'tableName': tableName};
  @override
  VId asOptional() =>
      VId(tableName: tableName, isOptional: OptionalProperty.optional);
}

class VFloat64 extends Validator {
  const VFloat64({super.isOptional = OptionalProperty.required});

  @override
  String get kind => 'float64';
  @override
  ValidatorJson get json => {'type': 'number'};
  @override
  VFloat64 asOptional() =>
      const VFloat64(isOptional: OptionalProperty.optional);
}

class VInt64 extends Validator {
  const VInt64({super.isOptional = OptionalProperty.required});

  @override
  String get kind => 'int64';
  @override
  ValidatorJson get json => {'type': 'bigint'};
  @override
  VInt64 asOptional() => const VInt64(isOptional: OptionalProperty.optional);
}

class VBoolean extends Validator {
  const VBoolean({super.isOptional = OptionalProperty.required});

  @override
  String get kind => 'boolean';
  @override
  ValidatorJson get json => {'type': kind};
  @override
  VBoolean asOptional() =>
      const VBoolean(isOptional: OptionalProperty.optional);
}

class VBytes extends Validator {
  const VBytes({super.isOptional = OptionalProperty.required});

  @override
  String get kind => 'bytes';
  @override
  ValidatorJson get json => {'type': kind};
  @override
  VBytes asOptional() => const VBytes(isOptional: OptionalProperty.optional);
}

class VString extends Validator {
  const VString({super.isOptional = OptionalProperty.required});

  @override
  String get kind => 'string';
  @override
  ValidatorJson get json => {'type': kind};
  @override
  VString asOptional() => const VString(isOptional: OptionalProperty.optional);
}

class VNull extends Validator {
  const VNull({super.isOptional = OptionalProperty.required});

  @override
  String get kind => 'null';
  @override
  ValidatorJson get json => {'type': kind};
  @override
  VNull asOptional() => const VNull(isOptional: OptionalProperty.optional);
}

class VAny extends Validator {
  const VAny({super.isOptional = OptionalProperty.required});

  @override
  String get kind => 'any';
  @override
  ValidatorJson get json => {'type': kind};
  @override
  VAny asOptional() => const VAny(isOptional: OptionalProperty.optional);
}

class VLiteral extends Validator {
  const VLiteral(this.value, {super.isOptional = OptionalProperty.required});

  final Object value;
  @override
  String get kind => 'literal';
  @override
  ValidatorJson get json => {'type': kind, 'value': convexToJson(value)};
  @override
  VLiteral asOptional() =>
      VLiteral(value, isOptional: OptionalProperty.optional);
}

class VObject extends Validator {
  VObject(this.fields, {super.isOptional = OptionalProperty.required}) {
    for (final entry in fields.entries) {
      if (!entry.value.isConvexValidator) {
        throw ArgumentError('v.object() entries must be validators');
      }
    }
  }

  final Map<String, Validator> fields;
  @override
  String get kind => 'object';
  @override
  ValidatorJson get json => {
    'type': kind,
    'value': {
      for (final entry in fields.entries)
        entry.key: {
          'fieldType': entry.value.json,
          'optional': entry.value.isOptional == OptionalProperty.optional,
        },
    },
  };
  @override
  VObject asOptional() =>
      VObject(fields, isOptional: OptionalProperty.optional);

  VObject omit(Iterable<String> fieldNames) {
    final next = Map<String, Validator>.from(fields);
    for (final name in fieldNames) {
      next.remove(name);
    }
    return VObject(next, isOptional: isOptional);
  }

  VObject pick(Iterable<String> fieldNames) {
    final next = <String, Validator>{};
    for (final name in fieldNames) {
      final validator = fields[name];
      if (validator != null) next[name] = validator;
    }
    return VObject(next, isOptional: isOptional);
  }

  VObject partial() => VObject({
    for (final entry in fields.entries) entry.key: entry.value.asOptional(),
  }, isOptional: isOptional);

  VObject extend(Map<String, Validator> newFields) =>
      VObject({...fields, ...newFields}, isOptional: isOptional);
}

class VArray extends Validator {
  VArray(this.element, {super.isOptional = OptionalProperty.required});

  final Validator element;
  @override
  String get kind => 'array';
  @override
  ValidatorJson get json => {'type': kind, 'value': element.json};
  @override
  VArray asOptional() => VArray(element, isOptional: OptionalProperty.optional);
}

class VRecord extends Validator {
  VRecord(
    this.key,
    this.value, {
    super.isOptional = OptionalProperty.required,
  }) {
    if (key.isOptional == OptionalProperty.optional) {
      throw ArgumentError('Record validator cannot have optional keys');
    }
    if (value.isOptional == OptionalProperty.optional) {
      throw ArgumentError('Record validator cannot have optional values');
    }
    if (key is! VString && key is! VId && key is! VUnion) {
      throw ArgumentError('Record key validator must be string, id, or union');
    }
  }

  final Validator key;
  final Validator value;
  @override
  String get kind => 'record';
  @override
  ValidatorJson get json => {
    'type': kind,
    'keys': key.json,
    'values': {'fieldType': value.json, 'optional': false},
  };
  @override
  VRecord asOptional() =>
      VRecord(key, value, isOptional: OptionalProperty.optional);
}

class VUnion extends Validator {
  VUnion(this.members, {super.isOptional = OptionalProperty.required}) {
    if (members.isEmpty) {
      throw ArgumentError('v.union() requires at least one validator');
    }
    for (final member in members) {
      if (!member.isConvexValidator) {
        throw ArgumentError('All members of v.union() must be validators');
      }
    }
  }

  final List<Validator> members;
  @override
  String get kind => 'union';
  @override
  ValidatorJson get json => {
    'type': kind,
    'value': members.map((member) => member.json).toList(growable: false),
  };
  @override
  VUnion asOptional() => VUnion(members, isOptional: OptionalProperty.optional);
}
