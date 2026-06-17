import 'value.dart';

typedef ValidatorJson = Map<String, Object?>;

abstract class Validator {
  Validator({this.isOptional = false});

  final bool isOptional;
  bool get isConvexValidator => true;
  String get kind;
  ValidatorJson get json;
  Validator asOptional();
}

class VId extends Validator {
  VId(this.tableName, {super.isOptional}) {
    if (tableName.isEmpty) {
      throw ArgumentError('v.id(tableName) requires a string');
    }
  }
  final String tableName;
  @override
  String get kind => 'id';
  @override
  ValidatorJson get json => {'type': 'id', 'tableName': tableName};
  @override
  VId asOptional() => VId(tableName, isOptional: true);
}

class VFloat64 extends Validator {
  VFloat64({super.isOptional});
  @override
  String get kind => 'float64';
  @override
  ValidatorJson get json => {'type': 'number'};
  @override
  VFloat64 asOptional() => VFloat64(isOptional: true);
}

class VInt64 extends Validator {
  VInt64({super.isOptional});
  @override
  String get kind => 'int64';
  @override
  ValidatorJson get json => {'type': 'bigint'};
  @override
  VInt64 asOptional() => VInt64(isOptional: true);
}

class VBoolean extends Validator {
  VBoolean({super.isOptional});
  @override
  String get kind => 'boolean';
  @override
  ValidatorJson get json => {'type': 'boolean'};
  @override
  VBoolean asOptional() => VBoolean(isOptional: true);
}

class VBytes extends Validator {
  VBytes({super.isOptional});
  @override
  String get kind => 'bytes';
  @override
  ValidatorJson get json => {'type': 'bytes'};
  @override
  VBytes asOptional() => VBytes(isOptional: true);
}

class VString extends Validator {
  VString({super.isOptional});
  @override
  String get kind => 'string';
  @override
  ValidatorJson get json => {'type': 'string'};
  @override
  VString asOptional() => VString(isOptional: true);
}

class VNull extends Validator {
  VNull({super.isOptional});
  @override
  String get kind => 'null';
  @override
  ValidatorJson get json => {'type': 'null'};
  @override
  VNull asOptional() => VNull(isOptional: true);
}

class VAny extends Validator {
  VAny({super.isOptional});
  @override
  String get kind => 'any';
  @override
  ValidatorJson get json => {'type': 'any'};
  @override
  VAny asOptional() => VAny(isOptional: true);
}

class VObject extends Validator {
  VObject(this.fields, {super.isOptional}) {
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
    'type': 'object',
    'value': {
      for (final entry in fields.entries)
        entry.key: {
          'fieldType': entry.value.json,
          'optional': entry.value.isOptional,
        },
    },
  };
  @override
  VObject asOptional() => VObject(fields, isOptional: true);
  VObject omit(List<String> names) => VObject(
    Map.of(fields)..removeWhere((key, _) => names.contains(key)),
    isOptional: isOptional,
  );
  VObject pick(List<String> names) => VObject({
    for (final name in names)
      if (fields.containsKey(name)) name: fields[name]!,
  }, isOptional: isOptional);
  VObject partial() => VObject({
    for (final entry in fields.entries) entry.key: entry.value.asOptional(),
  }, isOptional: isOptional);
  VObject extend(Map<String, Validator> extra) =>
      VObject({...fields, ...extra}, isOptional: isOptional);
}

class VLiteral extends Validator {
  VLiteral(this.value, {super.isOptional}) {
    if (value is! String &&
        value is! bool &&
        value is! double &&
        value is! int &&
        value is! BigInt) {
      throw ArgumentError(
        'v.literal(value) must be a string, number, or boolean',
      );
    }
  }
  final Object value;
  @override
  String get kind => 'literal';
  @override
  ValidatorJson get json => {'type': 'literal', 'value': convexToJson(value)};
  @override
  VLiteral asOptional() => VLiteral(value, isOptional: true);
}

class VArray extends Validator {
  VArray(this.element, {super.isOptional});
  final Validator element;
  @override
  String get kind => 'array';
  @override
  ValidatorJson get json => {'type': 'array', 'value': element.json};
  @override
  VArray asOptional() => VArray(element, isOptional: true);
}

class VRecord extends Validator {
  VRecord(this.key, this.value, {super.isOptional}) {
    if (key.isOptional) {
      throw ArgumentError('Record validator cannot have optional keys');
    }
    if (value.isOptional) {
      throw ArgumentError('Record validator cannot have optional values');
    }
  }
  final Validator key;
  final Validator value;
  @override
  String get kind => 'record';
  @override
  ValidatorJson get json => {
    'type': 'record',
    'keys': key.json,
    'values': {'fieldType': value.json, 'optional': false},
  };
  @override
  VRecord asOptional() => VRecord(key, value, isOptional: true);
}

class VUnion extends Validator {
  VUnion(this.members, {super.isOptional});
  final List<Validator> members;
  @override
  String get kind => 'union';
  @override
  ValidatorJson get json => {
    'type': 'union',
    'value': members.map((v) => v.json).toList(growable: false),
  };
  @override
  VUnion asOptional() => VUnion(members, isOptional: true);
}
