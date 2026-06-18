// ignore_for_file: type=lint, unused_import, unnecessary_question_mark, dead_code, dead_null_aware_expression
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter, invalid_use_of_internal_member
import "dart:typed_data";
import "package:convex_dart/convex_dart.dart";
import "package:convex_dart/src/optional.dart";
import "package:convex_dart/src/union.dart";
import "../schema.dart";
import "../literals.dart";

final query1 = Query1();

class Query1 extends ConvexQuery<Query1Args, Query1Return> {
  Query1() : super("generic_functions:query1");

  @override
  Map<String, Object?> parseArgs(Query1Args args) {
    return (() {
      final _v0 = args;
      return {'i': _v0.i};
    })();
  }

  @override
  Query1Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (i: (_v0['i'] as String));
    })();
  }

  @override
  Query1Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (i: (_v0['i'] as String));
    })();
  }
}

final query2 = Query2();

class Query2 extends ConvexQuery<Query2Args, Query2Return> {
  Query2() : super("generic_functions:query2");

  @override
  Map<String, Object?> parseArgs(Query2Args args) {
    return (() {
      final _v0 = args;
      return {'i': _v0.i};
    })();
  }

  @override
  Query2Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (i: (_v0['i'] as num).toDouble());
    })();
  }

  @override
  Query2Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (i: (_v0['i'] as num).toDouble());
    })();
  }
}

final query3 = Query3();

class Query3 extends ConvexQuery<Query3Args, Query3Return> {
  Query3() : super("generic_functions:query3");

  @override
  Map<String, Object?> parseArgs(Query3Args args) {
    return (() {
      final _v0 = args;
      return {'i': _v0.i};
    })();
  }

  @override
  Query3Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (i: (_v0['i'] as bool));
    })();
  }

  @override
  Query3Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (i: (_v0['i'] as bool));
    })();
  }
}

final query4 = Query4();

class Query4 extends ConvexQuery<Query4Args, Query4Return> {
  Query4() : super("generic_functions:query4");

  @override
  Map<String, Object?> parseArgs(Query4Args args) {
    return (() {
      final _v0 = args;
      return {'i': _v0.i};
    })();
  }

  @override
  Query4Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (i: (_v0['i'] as BigInt));
    })();
  }

  @override
  Query4Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (i: (_v0['i'] as BigInt));
    })();
  }
}

final query5 = Query5();

class Query5 extends ConvexQuery<Query5Args, Query5Return> {
  Query5() : super("generic_functions:query5");

  @override
  Map<String, Object?> parseArgs(Query5Args args) {
    return (() {
      final _v0 = args;
      return {'i': _v0.i};
    })();
  }

  @override
  Query5Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (i: (_v0['i'] as Uint8List));
    })();
  }

  @override
  Query5Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (i: (_v0['i'] as Uint8List));
    })();
  }
}

final query6 = Query6();

class Query6 extends ConvexQuery<Query6Args, Query6Return> {
  Query6() : super("generic_functions:query6");

  @override
  Map<String, Object?> parseArgs(Query6Args args) {
    return (() {
      final _v0 = args;
      return {'i': _v0.i.name};
    })();
  }

  @override
  Query6Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (i: TasksId(_v0['i'] as String));
    })();
  }

  @override
  Query6Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (i: TasksId(_v0['i'] as String));
    })();
  }
}

final query7 = Query7();

class Query7 extends ConvexQuery<Query7Args, Query7Return> {
  Query7() : super("generic_functions:query7");

  @override
  Map<String, Object?> parseArgs(Query7Args args) {
    return (() {
      final _v0 = args;
      return {'i': _v0.i};
    })();
  }

  @override
  Query7Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (i: _v0['i']);
    })();
  }

  @override
  Query7Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (i: _v0['i']);
    })();
  }
}

final query9 = Query9();

class Query9 extends ConvexQuery<Query9Args, Query9Return> {
  Query9() : super("generic_functions:query9");

  @override
  Map<String, Object?> parseArgs(Query9Args args) {
    return (() {
      final _v0 = args;
      return {'i': _v0.i.value};
    })();
  }

  @override
  Query9Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (i: $hi.validate(_v0['i']));
    })();
  }

  @override
  Query9Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (i: $hi.validate(_v0['i']));
    })();
  }
}

final query10 = Query10();

class Query10 extends ConvexQuery<Query10Args, Query10Return> {
  Query10() : super("generic_functions:query10");

  @override
  Map<String, Object?> parseArgs(Query10Args args) {
    return (() {
      final _v0 = args;
      return {'i': _v0.i.value};
    })();
  }

  @override
  Query10Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (i: $1_0.validate(_v0['i']));
    })();
  }

  @override
  Query10Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (i: $1_0.validate(_v0['i']));
    })();
  }
}

final query11 = Query11();

class Query11 extends ConvexQuery<Query11Args, Query11Return> {
  Query11() : super("generic_functions:query11");

  @override
  Map<String, Object?> parseArgs(Query11Args args) {
    return (() {
      final _v0 = args;
      return {'i': _v0.i.value};
    })();
  }

  @override
  Query11Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (i: $true.validate(_v0['i']));
    })();
  }

  @override
  Query11Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (i: $true.validate(_v0['i']));
    })();
  }
}

final query13 = Query13();

class Query13 extends ConvexQuery<Query13Args, Query13Return> {
  Query13() : super("generic_functions:query13");

  @override
  Map<String, Object?> parseArgs(Query13Args args) {
    return (() {
      final _v0 = args;
      return {if (_v0.i.isDefined) 'i': _v0.i.asDefined().value};
    })();
  }

  @override
  Query13Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: _v0.containsKey('i')
            ? Defined<String>((_v0['i'] as String))
            : Undefined<String>(),
      );
    })();
  }

  @override
  Query13Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: _v0.containsKey('i')
            ? Defined<String>((_v0['i'] as String))
            : Undefined<String>(),
      );
    })();
  }
}

final query14 = Query14();

class Query14 extends ConvexQuery<Query14Args, Query14Return> {
  Query14() : super("generic_functions:query14");

  @override
  Map<String, Object?> parseArgs(Query14Args args) {
    return (() {
      final _v0 = args;
      return {if (_v0.i.isDefined) 'i': _v0.i.asDefined().value};
    })();
  }

  @override
  Query14Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: _v0.containsKey('i')
            ? Defined<double>((_v0['i'] as num).toDouble())
            : Undefined<double>(),
      );
    })();
  }

  @override
  Query14Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: _v0.containsKey('i')
            ? Defined<double>((_v0['i'] as num).toDouble())
            : Undefined<double>(),
      );
    })();
  }
}

final query15 = Query15();

class Query15 extends ConvexQuery<Query15Args, Query15Return> {
  Query15() : super("generic_functions:query15");

  @override
  Map<String, Object?> parseArgs(Query15Args args) {
    return (() {
      final _v0 = args;
      return {if (_v0.i.isDefined) 'i': _v0.i.asDefined().value};
    })();
  }

  @override
  Query15Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: _v0.containsKey('i')
            ? Defined<bool>((_v0['i'] as bool))
            : Undefined<bool>(),
      );
    })();
  }

  @override
  Query15Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: _v0.containsKey('i')
            ? Defined<bool>((_v0['i'] as bool))
            : Undefined<bool>(),
      );
    })();
  }
}

final query16 = Query16();

class Query16 extends ConvexQuery<Query16Args, Query16Return> {
  Query16() : super("generic_functions:query16");

  @override
  Map<String, Object?> parseArgs(Query16Args args) {
    return (() {
      final _v0 = args;
      return {if (_v0.i.isDefined) 'i': _v0.i.asDefined().value};
    })();
  }

  @override
  Query16Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: _v0.containsKey('i')
            ? Defined<BigInt>((_v0['i'] as BigInt))
            : Undefined<BigInt>(),
      );
    })();
  }

  @override
  Query16Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: _v0.containsKey('i')
            ? Defined<BigInt>((_v0['i'] as BigInt))
            : Undefined<BigInt>(),
      );
    })();
  }
}

final query17 = Query17();

class Query17 extends ConvexQuery<Query17Args, Query17Return> {
  Query17() : super("generic_functions:query17");

  @override
  Map<String, Object?> parseArgs(Query17Args args) {
    return (() {
      final _v0 = args;
      return {if (_v0.i.isDefined) 'i': _v0.i.asDefined().value};
    })();
  }

  @override
  Query17Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: _v0.containsKey('i')
            ? Defined<Uint8List>((_v0['i'] as Uint8List))
            : Undefined<Uint8List>(),
      );
    })();
  }

  @override
  Query17Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: _v0.containsKey('i')
            ? Defined<Uint8List>((_v0['i'] as Uint8List))
            : Undefined<Uint8List>(),
      );
    })();
  }
}

final query18 = Query18();

class Query18 extends ConvexQuery<Query18Args, Query18Return> {
  Query18() : super("generic_functions:query18");

  @override
  Map<String, Object?> parseArgs(Query18Args args) {
    return (() {
      final _v0 = args;
      return {if (_v0.i.isDefined) 'i': _v0.i.asDefined().value.name};
    })();
  }

  @override
  Query18Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: _v0.containsKey('i')
            ? Defined<TasksId>(TasksId(_v0['i'] as String))
            : Undefined<TasksId>(),
      );
    })();
  }

  @override
  Query18Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: _v0.containsKey('i')
            ? Defined<TasksId>(TasksId(_v0['i'] as String))
            : Undefined<TasksId>(),
      );
    })();
  }
}

final query19 = Query19();

class Query19 extends ConvexQuery<Query19Args, Query19Return> {
  Query19() : super("generic_functions:query19");

  @override
  Map<String, Object?> parseArgs(Query19Args args) {
    return (() {
      final _v0 = args;
      return {if (_v0.i.isDefined) 'i': _v0.i.asDefined().value};
    })();
  }

  @override
  Query19Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: _v0.containsKey('i')
            ? Defined<Object?>(_v0['i'])
            : Undefined<Object?>(),
      );
    })();
  }

  @override
  Query19Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: _v0.containsKey('i')
            ? Defined<Object?>(_v0['i'])
            : Undefined<Object?>(),
      );
    })();
  }
}

final query20 = Query20();

class Query20 extends ConvexQuery<Query20Args, Query20Return> {
  Query20() : super("generic_functions:query20");

  @override
  Map<String, Object?> parseArgs(Query20Args args) {
    return (() {
      final _v0 = args;
      return {if (_v0.i.isDefined) 'i': _v0.i.asDefined().value.value};
    })();
  }

  @override
  Query20Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: _v0.containsKey('i')
            ? Defined<$hi>($hi.validate(_v0['i']))
            : Undefined<$hi>(),
      );
    })();
  }

  @override
  Query20Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: _v0.containsKey('i')
            ? Defined<$hi>($hi.validate(_v0['i']))
            : Undefined<$hi>(),
      );
    })();
  }
}

final query21 = Query21();

class Query21 extends ConvexQuery<Query21Args, Query21Return> {
  Query21() : super("generic_functions:query21");

  @override
  Map<String, Object?> parseArgs(Query21Args args) {
    return (() {
      final _v0 = args;
      return {if (_v0.i.isDefined) 'i': _v0.i.asDefined().value.value};
    })();
  }

  @override
  Query21Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: _v0.containsKey('i')
            ? Defined<$1_0>($1_0.validate(_v0['i']))
            : Undefined<$1_0>(),
      );
    })();
  }

  @override
  Query21Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: _v0.containsKey('i')
            ? Defined<$1_0>($1_0.validate(_v0['i']))
            : Undefined<$1_0>(),
      );
    })();
  }
}

final query22 = Query22();

class Query22 extends ConvexQuery<Query22Args, Query22Return> {
  Query22() : super("generic_functions:query22");

  @override
  Map<String, Object?> parseArgs(Query22Args args) {
    return (() {
      final _v0 = args;
      return {if (_v0.i.isDefined) 'i': _v0.i.asDefined().value.value};
    })();
  }

  @override
  Query22Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: _v0.containsKey('i')
            ? Defined<$true>($true.validate(_v0['i']))
            : Undefined<$true>(),
      );
    })();
  }

  @override
  Query22Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: _v0.containsKey('i')
            ? Defined<$true>($true.validate(_v0['i']))
            : Undefined<$true>(),
      );
    })();
  }
}

final query24 = Query24();

class Query24 extends ConvexQuery<Query24Args, Query24Return> {
  Query24() : super("generic_functions:query24");

  @override
  Map<String, Object?> parseArgs(Query24Args args) {
    return (() {
      final _v0 = args;
      return {'i': _v0.i};
    })();
  }

  @override
  Query24Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (i: _v0['i'] == null ? null : (_v0['i'] as String));
    })();
  }

  @override
  Query24Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (i: _v0['i'] == null ? null : (_v0['i'] as String));
    })();
  }
}

final query25 = Query25();

class Query25 extends ConvexQuery<Query25Args, Query25Return> {
  Query25() : super("generic_functions:query25");

  @override
  Map<String, Object?> parseArgs(Query25Args args) {
    return (() {
      final _v0 = args;
      return {'i': _v0.i};
    })();
  }

  @override
  Query25Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (i: _v0['i'] == null ? null : (_v0['i'] as num).toDouble());
    })();
  }

  @override
  Query25Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (i: _v0['i'] == null ? null : (_v0['i'] as num).toDouble());
    })();
  }
}

final query26 = Query26();

class Query26 extends ConvexQuery<Query26Args, Query26Return> {
  Query26() : super("generic_functions:query26");

  @override
  Map<String, Object?> parseArgs(Query26Args args) {
    return (() {
      final _v0 = args;
      return {'i': _v0.i};
    })();
  }

  @override
  Query26Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (i: _v0['i'] == null ? null : (_v0['i'] as bool));
    })();
  }

  @override
  Query26Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (i: _v0['i'] == null ? null : (_v0['i'] as bool));
    })();
  }
}

final query27 = Query27();

class Query27 extends ConvexQuery<Query27Args, Query27Return> {
  Query27() : super("generic_functions:query27");

  @override
  Map<String, Object?> parseArgs(Query27Args args) {
    return (() {
      final _v0 = args;
      return {'i': _v0.i};
    })();
  }

  @override
  Query27Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (i: _v0['i'] == null ? null : (_v0['i'] as BigInt));
    })();
  }

  @override
  Query27Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (i: _v0['i'] == null ? null : (_v0['i'] as BigInt));
    })();
  }
}

final query28 = Query28();

class Query28 extends ConvexQuery<Query28Args, Query28Return> {
  Query28() : super("generic_functions:query28");

  @override
  Map<String, Object?> parseArgs(Query28Args args) {
    return (() {
      final _v0 = args;
      return {'i': _v0.i};
    })();
  }

  @override
  Query28Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (i: _v0['i'] == null ? null : (_v0['i'] as Uint8List));
    })();
  }

  @override
  Query28Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (i: _v0['i'] == null ? null : (_v0['i'] as Uint8List));
    })();
  }
}

final query29 = Query29();

class Query29 extends ConvexQuery<Query29Args, Query29Return> {
  Query29() : super("generic_functions:query29");

  @override
  Map<String, Object?> parseArgs(Query29Args args) {
    return (() {
      final _v0 = args;
      return {'i': _v0.i == null ? null : _v0.i!.name};
    })();
  }

  @override
  Query29Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (i: _v0['i'] == null ? null : TasksId(_v0['i'] as String));
    })();
  }

  @override
  Query29Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (i: _v0['i'] == null ? null : TasksId(_v0['i'] as String));
    })();
  }
}

final query30 = Query30();

class Query30 extends ConvexQuery<Query30Args, Query30Return> {
  Query30() : super("generic_functions:query30");

  @override
  Map<String, Object?> parseArgs(Query30Args args) {
    return (() {
      final _v0 = args;
      return {'i': _v0.i};
    })();
  }

  @override
  Query30Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (i: _v0['i']);
    })();
  }

  @override
  Query30Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (i: _v0['i']);
    })();
  }
}

final query31 = Query31();

class Query31 extends ConvexQuery<Query31Args, Query31Return> {
  Query31() : super("generic_functions:query31");

  @override
  Map<String, Object?> parseArgs(Query31Args args) {
    return (() {
      final _v0 = args;
      return {'i': _v0.i == null ? null : _v0.i!.value};
    })();
  }

  @override
  Query31Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (i: _v0['i'] == null ? null : $hi.validate(_v0['i']));
    })();
  }

  @override
  Query31Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (i: _v0['i'] == null ? null : $hi.validate(_v0['i']));
    })();
  }
}

final query32 = Query32();

class Query32 extends ConvexQuery<Query32Args, Query32Return> {
  Query32() : super("generic_functions:query32");

  @override
  Map<String, Object?> parseArgs(Query32Args args) {
    return (() {
      final _v0 = args;
      return {'i': _v0.i == null ? null : _v0.i!.value};
    })();
  }

  @override
  Query32Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (i: _v0['i'] == null ? null : $1_0.validate(_v0['i']));
    })();
  }

  @override
  Query32Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (i: _v0['i'] == null ? null : $1_0.validate(_v0['i']));
    })();
  }
}

final query33 = Query33();

class Query33 extends ConvexQuery<Query33Args, Query33Return> {
  Query33() : super("generic_functions:query33");

  @override
  Map<String, Object?> parseArgs(Query33Args args) {
    return (() {
      final _v0 = args;
      return {'i': _v0.i == null ? null : _v0.i!.value};
    })();
  }

  @override
  Query33Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (i: _v0['i'] == null ? null : $true.validate(_v0['i']));
    })();
  }

  @override
  Query33Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (i: _v0['i'] == null ? null : $true.validate(_v0['i']));
    })();
  }
}

final query34WithNull = Query34WithNull();

class Query34WithNull
    extends ConvexQuery<Query34WithNullArgs, Query34WithNullReturn> {
  Query34WithNull() : super("generic_functions:query34WithNull");

  @override
  Map<String, Object?> parseArgs(Query34WithNullArgs args) {
    return (() {
      final _v0 = args;
      return {'i': _v0.i == null ? null : _v0.i!.value.value};
    })();
  }

  @override
  Query34WithNullArgs parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: _v0['i'] == null ? null : $blue$red.fromValue(_v0['i'] as Object),
      );
    })();
  }

  @override
  Query34WithNullReturn parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: _v0['i'] == null ? null : $blue$red.fromValue(_v0['i'] as Object),
      );
    })();
  }
}

final query34NonNull = Query34NonNull();

class Query34NonNull
    extends ConvexQuery<Query34NonNullArgs, Query34NonNullReturn> {
  Query34NonNull() : super("generic_functions:query34NonNull");

  @override
  Map<String, Object?> parseArgs(Query34NonNullArgs args) {
    return (() {
      final _v0 = args;
      return {'i': _v0.i.value.value};
    })();
  }

  @override
  Query34NonNullArgs parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (i: $blue$red.fromValue(_v0['i'] as Object));
    })();
  }

  @override
  Query34NonNullReturn parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (i: $blue$red.fromValue(_v0['i'] as Object));
    })();
  }
}

final query35 = Query35();

class Query35 extends ConvexQuery<Query35Args, Query35Return> {
  Query35() : super("generic_functions:query35");

  @override
  Map<String, Object?> parseArgs(Query35Args args) {
    return (() {
      final _v0 = args;
      return {'i': _v0.i.map<Object?>((_v1) => _v1).toList(growable: false)};
    })();
  }

  @override
  Query35Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as List)
            .map<String>((_v1) => (_v1 as String))
            .toList(growable: false),
      );
    })();
  }

  @override
  Query35Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as List)
            .map<String>((_v1) => (_v1 as String))
            .toList(growable: false),
      );
    })();
  }
}

final query36 = Query36();

class Query36 extends ConvexQuery<Query36Args, Query36Return> {
  Query36() : super("generic_functions:query36");

  @override
  Map<String, Object?> parseArgs(Query36Args args) {
    return (() {
      final _v0 = args;
      return {'i': _v0.i.map<Object?>((_v1) => _v1).toList(growable: false)};
    })();
  }

  @override
  Query36Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as List)
            .map<double>((_v1) => (_v1 as num).toDouble())
            .toList(growable: false),
      );
    })();
  }

  @override
  Query36Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as List)
            .map<double>((_v1) => (_v1 as num).toDouble())
            .toList(growable: false),
      );
    })();
  }
}

final query37 = Query37();

class Query37 extends ConvexQuery<Query37Args, Query37Return> {
  Query37() : super("generic_functions:query37");

  @override
  Map<String, Object?> parseArgs(Query37Args args) {
    return (() {
      final _v0 = args;
      return {'i': _v0.i.map<Object?>((_v1) => _v1).toList(growable: false)};
    })();
  }

  @override
  Query37Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as List)
            .map<bool>((_v1) => (_v1 as bool))
            .toList(growable: false),
      );
    })();
  }

  @override
  Query37Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as List)
            .map<bool>((_v1) => (_v1 as bool))
            .toList(growable: false),
      );
    })();
  }
}

final query38 = Query38();

class Query38 extends ConvexQuery<Query38Args, Query38Return> {
  Query38() : super("generic_functions:query38");

  @override
  Map<String, Object?> parseArgs(Query38Args args) {
    return (() {
      final _v0 = args;
      return {'i': _v0.i.map<Object?>((_v1) => _v1).toList(growable: false)};
    })();
  }

  @override
  Query38Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as List)
            .map<BigInt>((_v1) => (_v1 as BigInt))
            .toList(growable: false),
      );
    })();
  }

  @override
  Query38Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as List)
            .map<BigInt>((_v1) => (_v1 as BigInt))
            .toList(growable: false),
      );
    })();
  }
}

final query39 = Query39();

class Query39 extends ConvexQuery<Query39Args, Query39Return> {
  Query39() : super("generic_functions:query39");

  @override
  Map<String, Object?> parseArgs(Query39Args args) {
    return (() {
      final _v0 = args;
      return {'i': _v0.i.map<Object?>((_v1) => _v1).toList(growable: false)};
    })();
  }

  @override
  Query39Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as List)
            .map<Uint8List>((_v1) => (_v1 as Uint8List))
            .toList(growable: false),
      );
    })();
  }

  @override
  Query39Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as List)
            .map<Uint8List>((_v1) => (_v1 as Uint8List))
            .toList(growable: false),
      );
    })();
  }
}

final query40 = Query40();

class Query40 extends ConvexQuery<Query40Args, Query40Return> {
  Query40() : super("generic_functions:query40");

  @override
  Map<String, Object?> parseArgs(Query40Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': _v0.i.map<Object?>((_v1) => _v1.name).toList(growable: false),
      };
    })();
  }

  @override
  Query40Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as List)
            .map<TasksId>((_v1) => TasksId(_v1 as String))
            .toList(growable: false),
      );
    })();
  }

  @override
  Query40Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as List)
            .map<TasksId>((_v1) => TasksId(_v1 as String))
            .toList(growable: false),
      );
    })();
  }
}

final query41 = Query41();

class Query41 extends ConvexQuery<Query41Args, Query41Return> {
  Query41() : super("generic_functions:query41");

  @override
  Map<String, Object?> parseArgs(Query41Args args) {
    return (() {
      final _v0 = args;
      return {'i': _v0.i.map<Object?>((_v1) => _v1).toList(growable: false)};
    })();
  }

  @override
  Query41Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as List)
            .map<Object?>((_v1) => _v1)
            .toList(growable: false),
      );
    })();
  }

  @override
  Query41Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as List)
            .map<Object?>((_v1) => _v1)
            .toList(growable: false),
      );
    })();
  }
}

final query42 = Query42();

class Query42 extends ConvexQuery<Query42Args, Query42Return> {
  Query42() : super("generic_functions:query42");

  @override
  Map<String, Object?> parseArgs(Query42Args args) {
    return (() {
      final _v0 = args;
      return {'i': _v0.i.map<Object?>((_v1) => null).toList(growable: false)};
    })();
  }

  @override
  Query42Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as List).map<Null>((_v1) => null).toList(growable: false),
      );
    })();
  }

  @override
  Query42Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as List).map<Null>((_v1) => null).toList(growable: false),
      );
    })();
  }
}

final query43 = Query43();

class Query43 extends ConvexQuery<Query43Args, Query43Return> {
  Query43() : super("generic_functions:query43");

  @override
  Map<String, Object?> parseArgs(Query43Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': _v0.i.map<Object?>((_v1) => _v1.value).toList(growable: false),
      };
    })();
  }

  @override
  Query43Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as List)
            .map<$hi>((_v1) => $hi.validate(_v1))
            .toList(growable: false),
      );
    })();
  }

  @override
  Query43Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as List)
            .map<$hi>((_v1) => $hi.validate(_v1))
            .toList(growable: false),
      );
    })();
  }
}

final query44 = Query44();

class Query44 extends ConvexQuery<Query44Args, Query44Return> {
  Query44() : super("generic_functions:query44");

  @override
  Map<String, Object?> parseArgs(Query44Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': _v0.i.map<Object?>((_v1) => _v1.value).toList(growable: false),
      };
    })();
  }

  @override
  Query44Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as List)
            .map<$1_0>((_v1) => $1_0.validate(_v1))
            .toList(growable: false),
      );
    })();
  }

  @override
  Query44Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as List)
            .map<$1_0>((_v1) => $1_0.validate(_v1))
            .toList(growable: false),
      );
    })();
  }
}

final query45 = Query45();

class Query45 extends ConvexQuery<Query45Args, Query45Return> {
  Query45() : super("generic_functions:query45");

  @override
  Map<String, Object?> parseArgs(Query45Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': _v0.i.map<Object?>((_v1) => _v1.value).toList(growable: false),
      };
    })();
  }

  @override
  Query45Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as List)
            .map<$true>((_v1) => $true.validate(_v1))
            .toList(growable: false),
      );
    })();
  }

  @override
  Query45Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as List)
            .map<$true>((_v1) => $true.validate(_v1))
            .toList(growable: false),
      );
    })();
  }
}

final query58 = Query58();

class Query58 extends ConvexQuery<Query58Args, Query58Return> {
  Query58() : super("generic_functions:query58");

  @override
  Map<String, Object?> parseArgs(Query58Args args) {
    return (() {
      final _v0 = args;
      return {'i': _v0.i.map<Object?>((_v1) => _v1).toList(growable: false)};
    })();
  }

  @override
  Query58Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as List)
            .map<String?>((_v1) => _v1 == null ? null : (_v1 as String))
            .toList(growable: false),
      );
    })();
  }

  @override
  Query58Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as List)
            .map<String?>((_v1) => _v1 == null ? null : (_v1 as String))
            .toList(growable: false),
      );
    })();
  }
}

final query59 = Query59();

class Query59 extends ConvexQuery<Query59Args, Query59Return> {
  Query59() : super("generic_functions:query59");

  @override
  Map<String, Object?> parseArgs(Query59Args args) {
    return (() {
      final _v0 = args;
      return {'i': _v0.i.map<Object?>((_v1) => _v1).toList(growable: false)};
    })();
  }

  @override
  Query59Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as List)
            .map<double?>((_v1) => _v1 == null ? null : (_v1 as num).toDouble())
            .toList(growable: false),
      );
    })();
  }

  @override
  Query59Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as List)
            .map<double?>((_v1) => _v1 == null ? null : (_v1 as num).toDouble())
            .toList(growable: false),
      );
    })();
  }
}

final query60 = Query60();

class Query60 extends ConvexQuery<Query60Args, Query60Return> {
  Query60() : super("generic_functions:query60");

  @override
  Map<String, Object?> parseArgs(Query60Args args) {
    return (() {
      final _v0 = args;
      return {'i': _v0.i.map<Object?>((_v1) => _v1).toList(growable: false)};
    })();
  }

  @override
  Query60Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as List)
            .map<bool?>((_v1) => _v1 == null ? null : (_v1 as bool))
            .toList(growable: false),
      );
    })();
  }

  @override
  Query60Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as List)
            .map<bool?>((_v1) => _v1 == null ? null : (_v1 as bool))
            .toList(growable: false),
      );
    })();
  }
}

final query61 = Query61();

class Query61 extends ConvexQuery<Query61Args, Query61Return> {
  Query61() : super("generic_functions:query61");

  @override
  Map<String, Object?> parseArgs(Query61Args args) {
    return (() {
      final _v0 = args;
      return {'i': _v0.i.map<Object?>((_v1) => _v1).toList(growable: false)};
    })();
  }

  @override
  Query61Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as List)
            .map<BigInt?>((_v1) => _v1 == null ? null : (_v1 as BigInt))
            .toList(growable: false),
      );
    })();
  }

  @override
  Query61Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as List)
            .map<BigInt?>((_v1) => _v1 == null ? null : (_v1 as BigInt))
            .toList(growable: false),
      );
    })();
  }
}

final query62 = Query62();

class Query62 extends ConvexQuery<Query62Args, Query62Return> {
  Query62() : super("generic_functions:query62");

  @override
  Map<String, Object?> parseArgs(Query62Args args) {
    return (() {
      final _v0 = args;
      return {'i': _v0.i.map<Object?>((_v1) => _v1).toList(growable: false)};
    })();
  }

  @override
  Query62Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as List)
            .map<Uint8List?>((_v1) => _v1 == null ? null : (_v1 as Uint8List))
            .toList(growable: false),
      );
    })();
  }

  @override
  Query62Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as List)
            .map<Uint8List?>((_v1) => _v1 == null ? null : (_v1 as Uint8List))
            .toList(growable: false),
      );
    })();
  }
}

final query63 = Query63();

class Query63 extends ConvexQuery<Query63Args, Query63Return> {
  Query63() : super("generic_functions:query63");

  @override
  Map<String, Object?> parseArgs(Query63Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': _v0.i
            .map<Object?>((_v1) => _v1 == null ? null : _v1!.name)
            .toList(growable: false),
      };
    })();
  }

  @override
  Query63Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as List)
            .map<TasksId?>((_v1) => _v1 == null ? null : TasksId(_v1 as String))
            .toList(growable: false),
      );
    })();
  }

  @override
  Query63Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as List)
            .map<TasksId?>((_v1) => _v1 == null ? null : TasksId(_v1 as String))
            .toList(growable: false),
      );
    })();
  }
}

final query64 = Query64();

class Query64 extends ConvexQuery<Query64Args, Query64Return> {
  Query64() : super("generic_functions:query64");

  @override
  Map<String, Object?> parseArgs(Query64Args args) {
    return (() {
      final _v0 = args;
      return {'i': _v0.i.map<Object?>((_v1) => _v1).toList(growable: false)};
    })();
  }

  @override
  Query64Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as List)
            .map<Object?>((_v1) => _v1)
            .toList(growable: false),
      );
    })();
  }

  @override
  Query64Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as List)
            .map<Object?>((_v1) => _v1)
            .toList(growable: false),
      );
    })();
  }
}

final query65 = Query65();

class Query65 extends ConvexQuery<Query65Args, Query65Return> {
  Query65() : super("generic_functions:query65");

  @override
  Map<String, Object?> parseArgs(Query65Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': _v0.i
            .map<Object?>((_v1) => _v1 == null ? null : _v1!.value)
            .toList(growable: false),
      };
    })();
  }

  @override
  Query65Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as List)
            .map<$hi?>((_v1) => _v1 == null ? null : $hi.validate(_v1))
            .toList(growable: false),
      );
    })();
  }

  @override
  Query65Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as List)
            .map<$hi?>((_v1) => _v1 == null ? null : $hi.validate(_v1))
            .toList(growable: false),
      );
    })();
  }
}

final query66 = Query66();

class Query66 extends ConvexQuery<Query66Args, Query66Return> {
  Query66() : super("generic_functions:query66");

  @override
  Map<String, Object?> parseArgs(Query66Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': _v0.i
            .map<Object?>((_v1) => _v1 == null ? null : _v1!.value)
            .toList(growable: false),
      };
    })();
  }

  @override
  Query66Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as List)
            .map<$1_0?>((_v1) => _v1 == null ? null : $1_0.validate(_v1))
            .toList(growable: false),
      );
    })();
  }

  @override
  Query66Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as List)
            .map<$1_0?>((_v1) => _v1 == null ? null : $1_0.validate(_v1))
            .toList(growable: false),
      );
    })();
  }
}

final query67 = Query67();

class Query67 extends ConvexQuery<Query67Args, Query67Return> {
  Query67() : super("generic_functions:query67");

  @override
  Map<String, Object?> parseArgs(Query67Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': _v0.i
            .map<Object?>((_v1) => _v1 == null ? null : _v1!.value)
            .toList(growable: false),
      };
    })();
  }

  @override
  Query67Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as List)
            .map<$true?>((_v1) => _v1 == null ? null : $true.validate(_v1))
            .toList(growable: false),
      );
    })();
  }

  @override
  Query67Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as List)
            .map<$true?>((_v1) => _v1 == null ? null : $true.validate(_v1))
            .toList(growable: false),
      );
    })();
  }
}

final query69 = Query69();

class Query69 extends ConvexQuery<Query69Args, Query69Return> {
  Query69() : super("generic_functions:query69");

  @override
  Map<String, Object?> parseArgs(Query69Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': {for (final _v1 in _v0.i.entries) _v1.key: _v1.value},
      };
    })();
  }

  @override
  Query69Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as Map).cast<String, Object?>().map(
          (_v1, _v2) => MapEntry(_v1, (_v2 as String)),
        ),
      );
    })();
  }

  @override
  Query69Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as Map).cast<String, Object?>().map(
          (_v1, _v2) => MapEntry(_v1, (_v2 as String)),
        ),
      );
    })();
  }
}

final query70 = Query70();

class Query70 extends ConvexQuery<Query70Args, Query70Return> {
  Query70() : super("generic_functions:query70");

  @override
  Map<String, Object?> parseArgs(Query70Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': {for (final _v1 in _v0.i.entries) _v1.key: _v1.value},
      };
    })();
  }

  @override
  Query70Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as Map).cast<String, Object?>().map(
          (_v1, _v2) => MapEntry(_v1, (_v2 as num).toDouble()),
        ),
      );
    })();
  }

  @override
  Query70Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as Map).cast<String, Object?>().map(
          (_v1, _v2) => MapEntry(_v1, (_v2 as num).toDouble()),
        ),
      );
    })();
  }
}

final query71 = Query71();

class Query71 extends ConvexQuery<Query71Args, Query71Return> {
  Query71() : super("generic_functions:query71");

  @override
  Map<String, Object?> parseArgs(Query71Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': {for (final _v1 in _v0.i.entries) _v1.key: _v1.value},
      };
    })();
  }

  @override
  Query71Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as Map).cast<String, Object?>().map(
          (_v1, _v2) => MapEntry(_v1, (_v2 as bool)),
        ),
      );
    })();
  }

  @override
  Query71Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as Map).cast<String, Object?>().map(
          (_v1, _v2) => MapEntry(_v1, (_v2 as bool)),
        ),
      );
    })();
  }
}

final query72 = Query72();

class Query72 extends ConvexQuery<Query72Args, Query72Return> {
  Query72() : super("generic_functions:query72");

  @override
  Map<String, Object?> parseArgs(Query72Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': {for (final _v1 in _v0.i.entries) _v1.key: _v1.value},
      };
    })();
  }

  @override
  Query72Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as Map).cast<String, Object?>().map(
          (_v1, _v2) => MapEntry(_v1, (_v2 as BigInt)),
        ),
      );
    })();
  }

  @override
  Query72Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as Map).cast<String, Object?>().map(
          (_v1, _v2) => MapEntry(_v1, (_v2 as BigInt)),
        ),
      );
    })();
  }
}

final query73 = Query73();

class Query73 extends ConvexQuery<Query73Args, Query73Return> {
  Query73() : super("generic_functions:query73");

  @override
  Map<String, Object?> parseArgs(Query73Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': {for (final _v1 in _v0.i.entries) _v1.key: _v1.value},
      };
    })();
  }

  @override
  Query73Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as Map).cast<String, Object?>().map(
          (_v1, _v2) => MapEntry(_v1, (_v2 as Uint8List)),
        ),
      );
    })();
  }

  @override
  Query73Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as Map).cast<String, Object?>().map(
          (_v1, _v2) => MapEntry(_v1, (_v2 as Uint8List)),
        ),
      );
    })();
  }
}

final query74 = Query74();

class Query74 extends ConvexQuery<Query74Args, Query74Return> {
  Query74() : super("generic_functions:query74");

  @override
  Map<String, Object?> parseArgs(Query74Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': {for (final _v1 in _v0.i.entries) _v1.key: _v1.value.name},
      };
    })();
  }

  @override
  Query74Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as Map).cast<String, Object?>().map(
          (_v1, _v2) => MapEntry(_v1, TasksId(_v2 as String)),
        ),
      );
    })();
  }

  @override
  Query74Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as Map).cast<String, Object?>().map(
          (_v1, _v2) => MapEntry(_v1, TasksId(_v2 as String)),
        ),
      );
    })();
  }
}

final query75 = Query75();

class Query75 extends ConvexQuery<Query75Args, Query75Return> {
  Query75() : super("generic_functions:query75");

  @override
  Map<String, Object?> parseArgs(Query75Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': {for (final _v1 in _v0.i.entries) _v1.key: _v1.value},
      };
    })();
  }

  @override
  Query75Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as Map).cast<String, Object?>().map(
          (_v1, _v2) => MapEntry(_v1, _v2),
        ),
      );
    })();
  }

  @override
  Query75Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as Map).cast<String, Object?>().map(
          (_v1, _v2) => MapEntry(_v1, _v2),
        ),
      );
    })();
  }
}

final query76 = Query76();

class Query76 extends ConvexQuery<Query76Args, Query76Return> {
  Query76() : super("generic_functions:query76");

  @override
  Map<String, Object?> parseArgs(Query76Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': {for (final _v1 in _v0.i.entries) _v1.key: null},
      };
    })();
  }

  @override
  Query76Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as Map).cast<String, Object?>().map(
          (_v1, _v2) => MapEntry(_v1, null),
        ),
      );
    })();
  }

  @override
  Query76Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as Map).cast<String, Object?>().map(
          (_v1, _v2) => MapEntry(_v1, null),
        ),
      );
    })();
  }
}

final query77 = Query77();

class Query77 extends ConvexQuery<Query77Args, Query77Return> {
  Query77() : super("generic_functions:query77");

  @override
  Map<String, Object?> parseArgs(Query77Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': {for (final _v1 in _v0.i.entries) _v1.key: _v1.value.value},
      };
    })();
  }

  @override
  Query77Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as Map).cast<String, Object?>().map(
          (_v1, _v2) => MapEntry(_v1, $hi.validate(_v2)),
        ),
      );
    })();
  }

  @override
  Query77Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as Map).cast<String, Object?>().map(
          (_v1, _v2) => MapEntry(_v1, $hi.validate(_v2)),
        ),
      );
    })();
  }
}

final query78 = Query78();

class Query78 extends ConvexQuery<Query78Args, Query78Return> {
  Query78() : super("generic_functions:query78");

  @override
  Map<String, Object?> parseArgs(Query78Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': {for (final _v1 in _v0.i.entries) _v1.key: _v1.value.value},
      };
    })();
  }

  @override
  Query78Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as Map).cast<String, Object?>().map(
          (_v1, _v2) => MapEntry(_v1, $1_0.validate(_v2)),
        ),
      );
    })();
  }

  @override
  Query78Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as Map).cast<String, Object?>().map(
          (_v1, _v2) => MapEntry(_v1, $1_0.validate(_v2)),
        ),
      );
    })();
  }
}

final query79 = Query79();

class Query79 extends ConvexQuery<Query79Args, Query79Return> {
  Query79() : super("generic_functions:query79");

  @override
  Map<String, Object?> parseArgs(Query79Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': {for (final _v1 in _v0.i.entries) _v1.key: _v1.value.value},
      };
    })();
  }

  @override
  Query79Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as Map).cast<String, Object?>().map(
          (_v1, _v2) => MapEntry(_v1, $true.validate(_v2)),
        ),
      );
    })();
  }

  @override
  Query79Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as Map).cast<String, Object?>().map(
          (_v1, _v2) => MapEntry(_v1, $true.validate(_v2)),
        ),
      );
    })();
  }
}

final query81 = Query81();

class Query81 extends ConvexQuery<Query81Args, Query81Return> {
  Query81() : super("generic_functions:query81");

  @override
  Map<String, Object?> parseArgs(Query81Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': {for (final _v1 in _v0.i.entries) _v1.key: _v1.value},
      };
    })();
  }

  @override
  Query81Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as Map).cast<String, Object?>().map(
          (_v1, _v2) => MapEntry(_v1, _v2 == null ? null : (_v2 as String)),
        ),
      );
    })();
  }

  @override
  Query81Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as Map).cast<String, Object?>().map(
          (_v1, _v2) => MapEntry(_v1, _v2 == null ? null : (_v2 as String)),
        ),
      );
    })();
  }
}

final query82 = Query82();

class Query82 extends ConvexQuery<Query82Args, Query82Return> {
  Query82() : super("generic_functions:query82");

  @override
  Map<String, Object?> parseArgs(Query82Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': {for (final _v1 in _v0.i.entries) _v1.key: _v1.value},
      };
    })();
  }

  @override
  Query82Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as Map).cast<String, Object?>().map(
          (_v1, _v2) =>
              MapEntry(_v1, _v2 == null ? null : (_v2 as num).toDouble()),
        ),
      );
    })();
  }

  @override
  Query82Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as Map).cast<String, Object?>().map(
          (_v1, _v2) =>
              MapEntry(_v1, _v2 == null ? null : (_v2 as num).toDouble()),
        ),
      );
    })();
  }
}

final query83 = Query83();

class Query83 extends ConvexQuery<Query83Args, Query83Return> {
  Query83() : super("generic_functions:query83");

  @override
  Map<String, Object?> parseArgs(Query83Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': {for (final _v1 in _v0.i.entries) _v1.key: _v1.value},
      };
    })();
  }

  @override
  Query83Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as Map).cast<String, Object?>().map(
          (_v1, _v2) => MapEntry(_v1, _v2 == null ? null : (_v2 as bool)),
        ),
      );
    })();
  }

  @override
  Query83Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as Map).cast<String, Object?>().map(
          (_v1, _v2) => MapEntry(_v1, _v2 == null ? null : (_v2 as bool)),
        ),
      );
    })();
  }
}

final query84 = Query84();

class Query84 extends ConvexQuery<Query84Args, Query84Return> {
  Query84() : super("generic_functions:query84");

  @override
  Map<String, Object?> parseArgs(Query84Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': {for (final _v1 in _v0.i.entries) _v1.key: _v1.value},
      };
    })();
  }

  @override
  Query84Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as Map).cast<String, Object?>().map(
          (_v1, _v2) => MapEntry(_v1, _v2 == null ? null : (_v2 as BigInt)),
        ),
      );
    })();
  }

  @override
  Query84Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as Map).cast<String, Object?>().map(
          (_v1, _v2) => MapEntry(_v1, _v2 == null ? null : (_v2 as BigInt)),
        ),
      );
    })();
  }
}

final query85 = Query85();

class Query85 extends ConvexQuery<Query85Args, Query85Return> {
  Query85() : super("generic_functions:query85");

  @override
  Map<String, Object?> parseArgs(Query85Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': {for (final _v1 in _v0.i.entries) _v1.key: _v1.value},
      };
    })();
  }

  @override
  Query85Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as Map).cast<String, Object?>().map(
          (_v1, _v2) => MapEntry(_v1, _v2 == null ? null : (_v2 as Uint8List)),
        ),
      );
    })();
  }

  @override
  Query85Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as Map).cast<String, Object?>().map(
          (_v1, _v2) => MapEntry(_v1, _v2 == null ? null : (_v2 as Uint8List)),
        ),
      );
    })();
  }
}

final query86 = Query86();

class Query86 extends ConvexQuery<Query86Args, Query86Return> {
  Query86() : super("generic_functions:query86");

  @override
  Map<String, Object?> parseArgs(Query86Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': {
          for (final _v1 in _v0.i.entries)
            _v1.key: _v1.value == null ? null : _v1.value!.name,
        },
      };
    })();
  }

  @override
  Query86Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as Map).cast<String, Object?>().map(
          (_v1, _v2) =>
              MapEntry(_v1, _v2 == null ? null : TasksId(_v2 as String)),
        ),
      );
    })();
  }

  @override
  Query86Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as Map).cast<String, Object?>().map(
          (_v1, _v2) =>
              MapEntry(_v1, _v2 == null ? null : TasksId(_v2 as String)),
        ),
      );
    })();
  }
}

final query87 = Query87();

class Query87 extends ConvexQuery<Query87Args, Query87Return> {
  Query87() : super("generic_functions:query87");

  @override
  Map<String, Object?> parseArgs(Query87Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': {for (final _v1 in _v0.i.entries) _v1.key: _v1.value},
      };
    })();
  }

  @override
  Query87Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as Map).cast<String, Object?>().map(
          (_v1, _v2) => MapEntry(_v1, _v2),
        ),
      );
    })();
  }

  @override
  Query87Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as Map).cast<String, Object?>().map(
          (_v1, _v2) => MapEntry(_v1, _v2),
        ),
      );
    })();
  }
}

final query88 = Query88();

class Query88 extends ConvexQuery<Query88Args, Query88Return> {
  Query88() : super("generic_functions:query88");

  @override
  Map<String, Object?> parseArgs(Query88Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': {
          for (final _v1 in _v0.i.entries)
            _v1.key: _v1.value == null ? null : _v1.value!.value,
        },
      };
    })();
  }

  @override
  Query88Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as Map).cast<String, Object?>().map(
          (_v1, _v2) => MapEntry(_v1, _v2 == null ? null : $hi.validate(_v2)),
        ),
      );
    })();
  }

  @override
  Query88Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as Map).cast<String, Object?>().map(
          (_v1, _v2) => MapEntry(_v1, _v2 == null ? null : $hi.validate(_v2)),
        ),
      );
    })();
  }
}

final query89 = Query89();

class Query89 extends ConvexQuery<Query89Args, Query89Return> {
  Query89() : super("generic_functions:query89");

  @override
  Map<String, Object?> parseArgs(Query89Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': {
          for (final _v1 in _v0.i.entries)
            _v1.key: _v1.value == null ? null : _v1.value!.value,
        },
      };
    })();
  }

  @override
  Query89Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as Map).cast<String, Object?>().map(
          (_v1, _v2) => MapEntry(_v1, _v2 == null ? null : $1_0.validate(_v2)),
        ),
      );
    })();
  }

  @override
  Query89Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as Map).cast<String, Object?>().map(
          (_v1, _v2) => MapEntry(_v1, _v2 == null ? null : $1_0.validate(_v2)),
        ),
      );
    })();
  }
}

final query90 = Query90();

class Query90 extends ConvexQuery<Query90Args, Query90Return> {
  Query90() : super("generic_functions:query90");

  @override
  Map<String, Object?> parseArgs(Query90Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': {
          for (final _v1 in _v0.i.entries)
            _v1.key: _v1.value == null ? null : _v1.value!.value,
        },
      };
    })();
  }

  @override
  Query90Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as Map).cast<String, Object?>().map(
          (_v1, _v2) => MapEntry(_v1, _v2 == null ? null : $true.validate(_v2)),
        ),
      );
    })();
  }

  @override
  Query90Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as Map).cast<String, Object?>().map(
          (_v1, _v2) => MapEntry(_v1, _v2 == null ? null : $true.validate(_v2)),
        ),
      );
    })();
  }
}

final query92 = Query92();

class Query92 extends ConvexQuery<Query92Args, Query92Return> {
  Query92() : super("generic_functions:query92");

  @override
  Map<String, Object?> parseArgs(Query92Args args) {
    return (() {
      final _v0 = args;
      return {'i': _v0.i.split((_v1) => _v1, (_v2) => _v2)};
    })();
  }

  @override
  Query92Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: Union2<String, double>(() {
          try {
            return (_v0['i'] as String);
          } catch (e) {}

          try {
            return (_v0['i'] as num).toDouble();
          } catch (e) {}

          throw Exception(
            (_v0['i'].toString()) +
                r" cannot be deserialized into a Union2<String, double>",
          );
        }()),
      );
    })();
  }

  @override
  Query92Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: Union2<String, double>(() {
          try {
            return (_v0['i'] as String);
          } catch (e) {}

          try {
            return (_v0['i'] as num).toDouble();
          } catch (e) {}

          throw Exception(
            (_v0['i'].toString()) +
                r" cannot be deserialized into a Union2<String, double>",
          );
        }()),
      );
    })();
  }
}

final query93 = Query93();

class Query93 extends ConvexQuery<Query93Args, Query93Return> {
  Query93() : super("generic_functions:query93");

  @override
  Map<String, Object?> parseArgs(Query93Args args) {
    return (() {
      final _v0 = args;
      return {'i': _v0.i.split((_v1) => _v1, (_v2) => _v2)};
    })();
  }

  @override
  Query93Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: Union2<bool, double>(() {
          try {
            return (_v0['i'] as bool);
          } catch (e) {}

          try {
            return (_v0['i'] as num).toDouble();
          } catch (e) {}

          throw Exception(
            (_v0['i'].toString()) +
                r" cannot be deserialized into a Union2<bool, double>",
          );
        }()),
      );
    })();
  }

  @override
  Query93Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: Union2<bool, double>(() {
          try {
            return (_v0['i'] as bool);
          } catch (e) {}

          try {
            return (_v0['i'] as num).toDouble();
          } catch (e) {}

          throw Exception(
            (_v0['i'].toString()) +
                r" cannot be deserialized into a Union2<bool, double>",
          );
        }()),
      );
    })();
  }
}

final query94 = Query94();

class Query94 extends ConvexQuery<Query94Args, Query94Return> {
  Query94() : super("generic_functions:query94");

  @override
  Map<String, Object?> parseArgs(Query94Args args) {
    return (() {
      final _v0 = args;
      return {'i': _v0.i.split((_v1) => _v1, (_v2) => _v2)};
    })();
  }

  @override
  Query94Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: Union2<String, bool>(() {
          try {
            return (_v0['i'] as String);
          } catch (e) {}

          try {
            return (_v0['i'] as bool);
          } catch (e) {}

          throw Exception(
            (_v0['i'].toString()) +
                r" cannot be deserialized into a Union2<String, bool>",
          );
        }()),
      );
    })();
  }

  @override
  Query94Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: Union2<String, bool>(() {
          try {
            return (_v0['i'] as String);
          } catch (e) {}

          try {
            return (_v0['i'] as bool);
          } catch (e) {}

          throw Exception(
            (_v0['i'].toString()) +
                r" cannot be deserialized into a Union2<String, bool>",
          );
        }()),
      );
    })();
  }
}

final query95 = Query95();

class Query95 extends ConvexQuery<Query95Args, Query95Return> {
  Query95() : super("generic_functions:query95");

  @override
  Map<String, Object?> parseArgs(Query95Args args) {
    return (() {
      final _v0 = args;
      return {'i': _v0.i.split((_v1) => _v1, (_v2) => _v2, (_v3) => _v3)};
    })();
  }

  @override
  Query95Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: Union3<String, double, bool>(() {
          try {
            return (_v0['i'] as String);
          } catch (e) {}

          try {
            return (_v0['i'] as num).toDouble();
          } catch (e) {}

          try {
            return (_v0['i'] as bool);
          } catch (e) {}

          throw Exception(
            (_v0['i'].toString()) +
                r" cannot be deserialized into a Union3<String, double, bool>",
          );
        }()),
      );
    })();
  }

  @override
  Query95Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: Union3<String, double, bool>(() {
          try {
            return (_v0['i'] as String);
          } catch (e) {}

          try {
            return (_v0['i'] as num).toDouble();
          } catch (e) {}

          try {
            return (_v0['i'] as bool);
          } catch (e) {}

          throw Exception(
            (_v0['i'].toString()) +
                r" cannot be deserialized into a Union3<String, double, bool>",
          );
        }()),
      );
    })();
  }
}

final query96 = Query96();

class Query96 extends ConvexQuery<Query96Args, Query96Return> {
  Query96() : super("generic_functions:query96");

  @override
  Map<String, Object?> parseArgs(Query96Args args) {
    return (() {
      final _v0 = args;
      return {'i': _v0.i};
    })();
  }

  @override
  Query96Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (i: _v0['i'] == null ? null : (_v0['i'] as String));
    })();
  }

  @override
  Query96Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (i: _v0['i'] == null ? null : (_v0['i'] as String));
    })();
  }
}

final query97 = Query97();

class Query97 extends ConvexQuery<Query97Args, Query97Return> {
  Query97() : super("generic_functions:query97");

  @override
  Map<String, Object?> parseArgs(Query97Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': _v0.i == null ? null : _v0.i!.split((_v1) => _v1, (_v2) => _v2),
      };
    })();
  }

  @override
  Query97Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: _v0['i'] == null
            ? null
            : Union2<double, bool>(() {
                try {
                  return (_v0['i'] as num).toDouble();
                } catch (e) {}

                try {
                  return (_v0['i'] as bool);
                } catch (e) {}

                throw Exception(
                  (_v0['i'].toString()) +
                      r" cannot be deserialized into a Union2<double, bool>",
                );
              }()),
      );
    })();
  }

  @override
  Query97Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: _v0['i'] == null
            ? null
            : Union2<double, bool>(() {
                try {
                  return (_v0['i'] as num).toDouble();
                } catch (e) {}

                try {
                  return (_v0['i'] as bool);
                } catch (e) {}

                throw Exception(
                  (_v0['i'].toString()) +
                      r" cannot be deserialized into a Union2<double, bool>",
                );
              }()),
      );
    })();
  }
}

final query98 = Query98();

class Query98 extends ConvexQuery<Query98Args, Query98Return> {
  Query98() : super("generic_functions:query98");

  @override
  Map<String, Object?> parseArgs(Query98Args args) {
    return (() {
      final _v0 = args;
      return {'i': _v0.i.split((_v1) => _v1, (_v2) => _v2)};
    })();
  }

  @override
  Query98Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: Union2<Uint8List, String>(() {
          try {
            return (_v0['i'] as Uint8List);
          } catch (e) {}

          try {
            return (_v0['i'] as String);
          } catch (e) {}

          throw Exception(
            (_v0['i'].toString()) +
                r" cannot be deserialized into a Union2<Uint8List, String>",
          );
        }()),
      );
    })();
  }

  @override
  Query98Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: Union2<Uint8List, String>(() {
          try {
            return (_v0['i'] as Uint8List);
          } catch (e) {}

          try {
            return (_v0['i'] as String);
          } catch (e) {}

          throw Exception(
            (_v0['i'].toString()) +
                r" cannot be deserialized into a Union2<Uint8List, String>",
          );
        }()),
      );
    })();
  }
}

final query100 = Query100();

class Query100 extends ConvexQuery<Query100Args, Query100Return> {
  Query100() : super("generic_functions:query100");

  @override
  Map<String, Object?> parseArgs(Query100Args args) {
    return (() {
      final _v0 = args;
      return {'i': _v0.i.value.value};
    })();
  }

  @override
  Query100Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (i: $yes$no.fromValue(_v0['i'] as Object));
    })();
  }

  @override
  Query100Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (i: $yes$no.fromValue(_v0['i'] as Object));
    })();
  }
}

final query101 = Query101();

class Query101 extends ConvexQuery<Query101Args, Query101Return> {
  Query101() : super("generic_functions:query101");

  @override
  Map<String, Object?> parseArgs(Query101Args args) {
    return (() {
      final _v0 = args;
      return {'i': _v0.i.value.value};
    })();
  }

  @override
  Query101Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (i: $10$20$30.fromValue(_v0['i'] as Object));
    })();
  }

  @override
  Query101Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (i: $10$20$30.fromValue(_v0['i'] as Object));
    })();
  }
}

final query102 = Query102();

class Query102 extends ConvexQuery<Query102Args, Query102Return> {
  Query102() : super("generic_functions:query102");

  @override
  Map<String, Object?> parseArgs(Query102Args args) {
    return (() {
      final _v0 = args;
      return {'i': _v0.i.value.value};
    })();
  }

  @override
  Query102Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (i: $admin$user$guest.fromValue(_v0['i'] as Object));
    })();
  }

  @override
  Query102Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (i: $admin$user$guest.fromValue(_v0['i'] as Object));
    })();
  }
}

final query103 = Query103();

class Query103 extends ConvexQuery<Query103Args, Query103Return> {
  Query103() : super("generic_functions:query103");

  @override
  Map<String, Object?> parseArgs(Query103Args args) {
    return (() {
      final _v0 = args;
      return {'i': _v0.i.split((_v1) => _v1, (_v2) => _v2)};
    })();
  }

  @override
  Query103Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: Union2<BigInt, double>(() {
          try {
            return (_v0['i'] as BigInt);
          } catch (e) {}

          try {
            return (_v0['i'] as num).toDouble();
          } catch (e) {}

          throw Exception(
            (_v0['i'].toString()) +
                r" cannot be deserialized into a Union2<BigInt, double>",
          );
        }()),
      );
    })();
  }

  @override
  Query103Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: Union2<BigInt, double>(() {
          try {
            return (_v0['i'] as BigInt);
          } catch (e) {}

          try {
            return (_v0['i'] as num).toDouble();
          } catch (e) {}

          throw Exception(
            (_v0['i'].toString()) +
                r" cannot be deserialized into a Union2<BigInt, double>",
          );
        }()),
      );
    })();
  }
}

final query104 = Query104();

class Query104 extends ConvexQuery<Query104Args, Query104Return> {
  Query104() : super("generic_functions:query104");

  @override
  Map<String, Object?> parseArgs(Query104Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': _v0.i == null
            ? null
            : _v0.i!.split((_v1) => _v1, (_v2) => _v2, (_v3) => _v3),
      };
    })();
  }

  @override
  Query104Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: _v0['i'] == null
            ? null
            : Union3<String, double, bool>(() {
                try {
                  return (_v0['i'] as String);
                } catch (e) {}

                try {
                  return (_v0['i'] as num).toDouble();
                } catch (e) {}

                try {
                  return (_v0['i'] as bool);
                } catch (e) {}

                throw Exception(
                  (_v0['i'].toString()) +
                      r" cannot be deserialized into a Union3<String, double, bool>",
                );
              }()),
      );
    })();
  }

  @override
  Query104Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: _v0['i'] == null
            ? null
            : Union3<String, double, bool>(() {
                try {
                  return (_v0['i'] as String);
                } catch (e) {}

                try {
                  return (_v0['i'] as num).toDouble();
                } catch (e) {}

                try {
                  return (_v0['i'] as bool);
                } catch (e) {}

                throw Exception(
                  (_v0['i'].toString()) +
                      r" cannot be deserialized into a Union3<String, double, bool>",
                );
              }()),
      );
    })();
  }
}

final query105 = Query105();

class Query105 extends ConvexQuery<Query105Args, Query105Return> {
  Query105() : super("generic_functions:query105");

  @override
  Map<String, Object?> parseArgs(Query105Args args) {
    return (() {
      final _v0 = args;
      return {'i': _v0.i};
    })();
  }

  @override
  Query105Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (i: _v0['i']);
    })();
  }

  @override
  Query105Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (i: _v0['i']);
    })();
  }
}

final query106 = Query106();

class Query106 extends ConvexQuery<Query106Args, Query106Return> {
  Query106() : super("generic_functions:query106");

  @override
  Map<String, Object?> parseArgs(Query106Args args) {
    return (() {
      final _v0 = args;
      return {'i': _v0.i.value.value};
    })();
  }

  @override
  Query106Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (i: $true$false.fromValue(_v0['i'] as Object));
    })();
  }

  @override
  Query106Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (i: $true$false.fromValue(_v0['i'] as Object));
    })();
  }
}

final query107 = Query107();

class Query107 extends ConvexQuery<Query107Args, Query107Return> {
  Query107() : super("generic_functions:query107");

  @override
  Map<String, Object?> parseArgs(Query107Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': _v0.i == null ? null : _v0.i!.split((_v1) => _v1, (_v2) => _v2),
      };
    })();
  }

  @override
  Query107Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: _v0['i'] == null
            ? null
            : Union2<Uint8List, BigInt>(() {
                try {
                  return (_v0['i'] as Uint8List);
                } catch (e) {}

                try {
                  return (_v0['i'] as BigInt);
                } catch (e) {}

                throw Exception(
                  (_v0['i'].toString()) +
                      r" cannot be deserialized into a Union2<Uint8List, BigInt>",
                );
              }()),
      );
    })();
  }

  @override
  Query107Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: _v0['i'] == null
            ? null
            : Union2<Uint8List, BigInt>(() {
                try {
                  return (_v0['i'] as Uint8List);
                } catch (e) {}

                try {
                  return (_v0['i'] as BigInt);
                } catch (e) {}

                throw Exception(
                  (_v0['i'].toString()) +
                      r" cannot be deserialized into a Union2<Uint8List, BigInt>",
                );
              }()),
      );
    })();
  }
}

final query110 = Query110();

class Query110 extends ConvexQuery<Query110Args, Query110Return> {
  Query110() : super("generic_functions:query110");

  @override
  Map<String, Object?> parseArgs(Query110Args args) {
    return (() {
      final _v0 = args;
      return {'i': _v0.i == null ? null : _v0.i!.value};
    })();
  }

  @override
  Query110Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (i: _v0['i'] == null ? null : $mixed.validate(_v0['i']));
    })();
  }

  @override
  Query110Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (i: _v0['i'] == null ? null : $mixed.validate(_v0['i']));
    })();
  }
}

final query111 = Query111();

class Query111 extends ConvexQuery<Query111Args, Query111Return> {
  Query111() : super("generic_functions:query111");

  @override
  Map<String, Object?> parseArgs(Query111Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': (() {
          final _v1 = _v0.i;
          return {'age': _v1.age, 'name': _v1.name};
        })(),
      };
    })();
  }

  @override
  Query111Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (() {
          final _v1 = (_v0['i'] as Map).cast<String, Object?>();
          return (
            age: (_v1['age'] as num).toDouble(),
            name: (_v1['name'] as String),
          );
        })(),
      );
    })();
  }

  @override
  Query111Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (() {
          final _v1 = (_v0['i'] as Map).cast<String, Object?>();
          return (
            age: (_v1['age'] as num).toDouble(),
            name: (_v1['name'] as String),
          );
        })(),
      );
    })();
  }
}

final query112 = Query112();

class Query112 extends ConvexQuery<Query112Args, Query112Return> {
  Query112() : super("generic_functions:query112");

  @override
  Map<String, Object?> parseArgs(Query112Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': (() {
          final _v1 = _v0.i;
          return {
            'completed': _v1.completed,
            'id': _v1.id.name,
            'title': _v1.title,
          };
        })(),
      };
    })();
  }

  @override
  Query112Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (() {
          final _v1 = (_v0['i'] as Map).cast<String, Object?>();
          return (
            completed: (_v1['completed'] as bool),
            id: TasksId(_v1['id'] as String),
            title: (_v1['title'] as String),
          );
        })(),
      );
    })();
  }

  @override
  Query112Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (() {
          final _v1 = (_v0['i'] as Map).cast<String, Object?>();
          return (
            completed: (_v1['completed'] as bool),
            id: TasksId(_v1['id'] as String),
            title: (_v1['title'] as String),
          );
        })(),
      );
    })();
  }
}

final query113 = Query113();

class Query113 extends ConvexQuery<Query113Args, Query113Return> {
  Query113() : super("generic_functions:query113");

  @override
  Map<String, Object?> parseArgs(Query113Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': (() {
          final _v1 = _v0.i;
          return {
            'settings': (() {
              final _v2 = _v1.settings;
              return {'notifications': _v2.notifications, 'theme': _v2.theme};
            })(),
            'user': (() {
              final _v3 = _v1.user;
              return {'email': _v3.email, 'name': _v3.name};
            })(),
          };
        })(),
      };
    })();
  }

  @override
  Query113Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (() {
          final _v1 = (_v0['i'] as Map).cast<String, Object?>();
          return (
            settings: (() {
              final _v2 = (_v1['settings'] as Map).cast<String, Object?>();
              return (
                notifications: (_v2['notifications'] as bool),
                theme: (_v2['theme'] as String),
              );
            })(),
            user: (() {
              final _v3 = (_v1['user'] as Map).cast<String, Object?>();
              return (
                email: (_v3['email'] as String),
                name: (_v3['name'] as String),
              );
            })(),
          );
        })(),
      );
    })();
  }

  @override
  Query113Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (() {
          final _v1 = (_v0['i'] as Map).cast<String, Object?>();
          return (
            settings: (() {
              final _v2 = (_v1['settings'] as Map).cast<String, Object?>();
              return (
                notifications: (_v2['notifications'] as bool),
                theme: (_v2['theme'] as String),
              );
            })(),
            user: (() {
              final _v3 = (_v1['user'] as Map).cast<String, Object?>();
              return (
                email: (_v3['email'] as String),
                name: (_v3['name'] as String),
              );
            })(),
          );
        })(),
      );
    })();
  }
}

final query114 = Query114();

class Query114 extends ConvexQuery<Query114Args, Query114Return> {
  Query114() : super("generic_functions:query114");

  @override
  Map<String, Object?> parseArgs(Query114Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': (() {
          final _v1 = _v0.i;
          return {
            if (_v1.email.isDefined) 'email': _v1.email.asDefined().value,
            if (_v1.name.isDefined) 'name': _v1.name.asDefined().value,
            'phone': _v1.phone,
          };
        })(),
      };
    })();
  }

  @override
  Query114Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (() {
          final _v1 = (_v0['i'] as Map).cast<String, Object?>();
          return (
            email: _v1.containsKey('email')
                ? Defined<String>((_v1['email'] as String))
                : Undefined<String>(),
            name: _v1.containsKey('name')
                ? Defined<String>((_v1['name'] as String))
                : Undefined<String>(),
            phone: _v1['phone'] == null ? null : (_v1['phone'] as String),
          );
        })(),
      );
    })();
  }

  @override
  Query114Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (() {
          final _v1 = (_v0['i'] as Map).cast<String, Object?>();
          return (
            email: _v1.containsKey('email')
                ? Defined<String>((_v1['email'] as String))
                : Undefined<String>(),
            name: _v1.containsKey('name')
                ? Defined<String>((_v1['name'] as String))
                : Undefined<String>(),
            phone: _v1['phone'] == null ? null : (_v1['phone'] as String),
          );
        })(),
      );
    })();
  }
}

final query115 = Query115();

class Query115 extends ConvexQuery<Query115Args, Query115Return> {
  Query115() : super("generic_functions:query115");

  @override
  Map<String, Object?> parseArgs(Query115Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': (() {
          final _v1 = _v0.i;
          return {
            'categories': _v1.categories
                .map<Object?>((_v2) => _v2.value.value)
                .toList(growable: false),
            'tags': _v1.tags.map<Object?>((_v3) => _v3).toList(growable: false),
          };
        })(),
      };
    })();
  }

  @override
  Query115Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (() {
          final _v1 = (_v0['i'] as Map).cast<String, Object?>();
          return (
            categories: (_v1['categories'] as List)
                .map<$work$personal$urgent>(
                  (_v2) => $work$personal$urgent.fromValue(_v2 as Object),
                )
                .toList(growable: false),
            tags: (_v1['tags'] as List)
                .map<String>((_v3) => (_v3 as String))
                .toList(growable: false),
          );
        })(),
      );
    })();
  }

  @override
  Query115Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (() {
          final _v1 = (_v0['i'] as Map).cast<String, Object?>();
          return (
            categories: (_v1['categories'] as List)
                .map<$work$personal$urgent>(
                  (_v2) => $work$personal$urgent.fromValue(_v2 as Object),
                )
                .toList(growable: false),
            tags: (_v1['tags'] as List)
                .map<String>((_v3) => (_v3 as String))
                .toList(growable: false),
          );
        })(),
      );
    })();
  }
}

final query116 = Query116();

class Query116 extends ConvexQuery<Query116Args, Query116Return> {
  Query116() : super("generic_functions:query116");

  @override
  Map<String, Object?> parseArgs(Query116Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': (() {
          final _v1 = _v0.i;
          return {
            'data': (() {
              final _v2 = _v1.data;
              return {'type': _v2.type.value.value, 'value': _v2.value};
            })(),
            'metadata': {
              for (final _v3 in _v1.metadata.entries) _v3.key: _v3.value,
            },
          };
        })(),
      };
    })();
  }

  @override
  Query116Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (() {
          final _v1 = (_v0['i'] as Map).cast<String, Object?>();
          return (
            data: (() {
              final _v2 = (_v1['data'] as Map).cast<String, Object?>();
              return (
                type: $text$number$boolean.fromValue(_v2['type'] as Object),
                value: _v2['value'],
              );
            })(),
            metadata: (_v1['metadata'] as Map).cast<String, Object?>().map(
              (_v3, _v4) => MapEntry(_v3, _v4),
            ),
          );
        })(),
      );
    })();
  }

  @override
  Query116Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (() {
          final _v1 = (_v0['i'] as Map).cast<String, Object?>();
          return (
            data: (() {
              final _v2 = (_v1['data'] as Map).cast<String, Object?>();
              return (
                type: $text$number$boolean.fromValue(_v2['type'] as Object),
                value: _v2['value'],
              );
            })(),
            metadata: (_v1['metadata'] as Map).cast<String, Object?>().map(
              (_v3, _v4) => MapEntry(_v3, _v4),
            ),
          );
        })(),
      );
    })();
  }
}

final query117 = Query117();

class Query117 extends ConvexQuery<Query117Args, Query117Return> {
  Query117() : super("generic_functions:query117");

  @override
  Map<String, Object?> parseArgs(Query117Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': (() {
          final _v1 = _v0.i;
          return {
            'comments': _v1.comments
                .map<Object?>(
                  (_v2) => (() {
                    final _v3 = _v2;
                    return {
                      'author': _v3.author,
                      'text': _v3.text,
                      'timestamp': _v3.timestamp,
                    };
                  })(),
                )
                .toList(growable: false),
            if (_v1.reviewer.isDefined)
              'reviewer': (() {
                final _v4 = _v1.reviewer.asDefined().value;
                return {'id': _v4.id.name, 'name': _v4.name};
              })(),
            'status': _v1.status.value.value,
          };
        })(),
      };
    })();
  }

  @override
  Query117Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (() {
          final _v1 = (_v0['i'] as Map).cast<String, Object?>();
          return (
            comments: (_v1['comments'] as List)
                .map<({String author, String text, double timestamp})>(
                  (_v2) => (() {
                    final _v3 = (_v2 as Map).cast<String, Object?>();
                    return (
                      author: (_v3['author'] as String),
                      text: (_v3['text'] as String),
                      timestamp: (_v3['timestamp'] as num).toDouble(),
                    );
                  })(),
                )
                .toList(growable: false),
            reviewer: _v1.containsKey('reviewer')
                ? Defined<({TasksId id, String name})>(
                    (() {
                      final _v4 = (_v1['reviewer'] as Map)
                          .cast<String, Object?>();
                      return (
                        id: TasksId(_v4['id'] as String),
                        name: (_v4['name'] as String),
                      );
                    })(),
                  )
                : Undefined<({TasksId id, String name})>(),
            status: $pending$approved$rejected.fromValue(
              _v1['status'] as Object,
            ),
          );
        })(),
      );
    })();
  }

  @override
  Query117Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (() {
          final _v1 = (_v0['i'] as Map).cast<String, Object?>();
          return (
            comments: (_v1['comments'] as List)
                .map<({String author, String text, double timestamp})>(
                  (_v2) => (() {
                    final _v3 = (_v2 as Map).cast<String, Object?>();
                    return (
                      author: (_v3['author'] as String),
                      text: (_v3['text'] as String),
                      timestamp: (_v3['timestamp'] as num).toDouble(),
                    );
                  })(),
                )
                .toList(growable: false),
            reviewer: _v1.containsKey('reviewer')
                ? Defined<({TasksId id, String name})>(
                    (() {
                      final _v4 = (_v1['reviewer'] as Map)
                          .cast<String, Object?>();
                      return (
                        id: TasksId(_v4['id'] as String),
                        name: (_v4['name'] as String),
                      );
                    })(),
                  )
                : Undefined<({TasksId id, String name})>(),
            status: $pending$approved$rejected.fromValue(
              _v1['status'] as Object,
            ),
          );
        })(),
      );
    })();
  }
}

final query118 = Query118();

class Query118 extends ConvexQuery<Query118Args, Query118Return> {
  Query118() : super("generic_functions:query118");

  @override
  Map<String, Object?> parseArgs(Query118Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': (() {
          final _v1 = _v0.i;
          return {
            'config': {
              for (final _v2 in _v1.config.entries)
                _v2.key: _v2.value.split(
                  (_v3) => _v3,
                  (_v4) => _v4,
                  (_v5) => _v5,
                ),
            },
            'fallback': (() {
              final _v6 = _v1.fallback;
              return {'enabled': _v6.enabled, 'value': _v6.value};
            })(),
          };
        })(),
      };
    })();
  }

  @override
  Query118Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (() {
          final _v1 = (_v0['i'] as Map).cast<String, Object?>();
          return (
            config: (_v1['config'] as Map).cast<String, Object?>().map(
              (_v2, _v3) => MapEntry(
                _v2,
                Union3<String, double, bool>(() {
                  try {
                    return (_v3 as String);
                  } catch (e) {}

                  try {
                    return (_v3 as num).toDouble();
                  } catch (e) {}

                  try {
                    return (_v3 as bool);
                  } catch (e) {}

                  throw Exception(
                    (_v3.toString()) +
                        r" cannot be deserialized into a Union3<String, double, bool>",
                  );
                }()),
              ),
            ),
            fallback: (() {
              final _v4 = (_v1['fallback'] as Map).cast<String, Object?>();
              return (enabled: (_v4['enabled'] as bool), value: _v4['value']);
            })(),
          );
        })(),
      );
    })();
  }

  @override
  Query118Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (() {
          final _v1 = (_v0['i'] as Map).cast<String, Object?>();
          return (
            config: (_v1['config'] as Map).cast<String, Object?>().map(
              (_v2, _v3) => MapEntry(
                _v2,
                Union3<String, double, bool>(() {
                  try {
                    return (_v3 as String);
                  } catch (e) {}

                  try {
                    return (_v3 as num).toDouble();
                  } catch (e) {}

                  try {
                    return (_v3 as bool);
                  } catch (e) {}

                  throw Exception(
                    (_v3.toString()) +
                        r" cannot be deserialized into a Union3<String, double, bool>",
                  );
                }()),
              ),
            ),
            fallback: (() {
              final _v4 = (_v1['fallback'] as Map).cast<String, Object?>();
              return (enabled: (_v4['enabled'] as bool), value: _v4['value']);
            })(),
          );
        })(),
      );
    })();
  }
}

final query119 = Query119();

class Query119 extends ConvexQuery<Query119Args, Query119Return> {
  Query119() : super("generic_functions:query119");

  @override
  Map<String, Object?> parseArgs(Query119Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': (() {
          final _v1 = _v0.i;
          return {
            'data': _v1.data.split(
              (_v2) => (() {
                final _v3 = _v2;
                return {'content': _v3.content, 'type': _v3.type.value};
              })(),
              (_v4) => (() {
                final _v5 = _v4;
                return {'content': _v5.content, 'type': _v5.type.value};
              })(),
              (_v6) => (() {
                final _v7 = _v6;
                return {'content': _v7.content, 'type': _v7.type.value};
              })(),
            ),
          };
        })(),
      };
    })();
  }

  @override
  Query119Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (() {
          final _v1 = (_v0['i'] as Map).cast<String, Object?>();
          return (
            data:
                Union3<
                  ({String content, $text type}),
                  ({double content, $number type}),
                  ({bool content, $boolean type})
                >(() {
                  try {
                    return (() {
                      final _v2 = (_v1['data'] as Map).cast<String, Object?>();
                      return (
                        content: (_v2['content'] as String),
                        type: $text.validate(_v2['type']),
                      );
                    })();
                  } catch (e) {}

                  try {
                    return (() {
                      final _v3 = (_v1['data'] as Map).cast<String, Object?>();
                      return (
                        content: (_v3['content'] as num).toDouble(),
                        type: $number.validate(_v3['type']),
                      );
                    })();
                  } catch (e) {}

                  try {
                    return (() {
                      final _v4 = (_v1['data'] as Map).cast<String, Object?>();
                      return (
                        content: (_v4['content'] as bool),
                        type: $boolean.validate(_v4['type']),
                      );
                    })();
                  } catch (e) {}

                  throw Exception(
                    (_v1['data'].toString()) +
                        r" cannot be deserialized into a Union3<({String content,$text type}), ({double content,$number type}), ({bool content,$boolean type})>",
                  );
                }()),
          );
        })(),
      );
    })();
  }

  @override
  Query119Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (() {
          final _v1 = (_v0['i'] as Map).cast<String, Object?>();
          return (
            data:
                Union3<
                  ({String content, $text type}),
                  ({double content, $number type}),
                  ({bool content, $boolean type})
                >(() {
                  try {
                    return (() {
                      final _v2 = (_v1['data'] as Map).cast<String, Object?>();
                      return (
                        content: (_v2['content'] as String),
                        type: $text.validate(_v2['type']),
                      );
                    })();
                  } catch (e) {}

                  try {
                    return (() {
                      final _v3 = (_v1['data'] as Map).cast<String, Object?>();
                      return (
                        content: (_v3['content'] as num).toDouble(),
                        type: $number.validate(_v3['type']),
                      );
                    })();
                  } catch (e) {}

                  try {
                    return (() {
                      final _v4 = (_v1['data'] as Map).cast<String, Object?>();
                      return (
                        content: (_v4['content'] as bool),
                        type: $boolean.validate(_v4['type']),
                      );
                    })();
                  } catch (e) {}

                  throw Exception(
                    (_v1['data'].toString()) +
                        r" cannot be deserialized into a Union3<({String content,$text type}), ({double content,$number type}), ({bool content,$boolean type})>",
                  );
                }()),
          );
        })(),
      );
    })();
  }
}

final query120 = Query120();

class Query120 extends ConvexQuery<Query120Args, Query120Return> {
  Query120() : super("generic_functions:query120");

  @override
  Map<String, Object?> parseArgs(Query120Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': (() {
          final _v1 = _v0.i;
          return {
            'items': _v1.items
                .map<Object?>(
                  (_v2) => (() {
                    final _v3 = _v2;
                    return {
                      'id': _v3.id,
                      'metadata': {
                        for (final _v4 in _v3.metadata.entries)
                          _v4.key: _v4.value,
                      },
                      'name': _v3.name,
                      'price': _v3.price,
                      if (_v3.quantity.isDefined)
                        'quantity': _v3.quantity.asDefined().value,
                    };
                  })(),
                )
                .toList(growable: false),
            'total': _v1.total,
          };
        })(),
      };
    })();
  }

  @override
  Query120Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (() {
          final _v1 = (_v0['i'] as Map).cast<String, Object?>();
          return (
            items: (_v1['items'] as List)
                .map<
                  ({
                    String id,
                    Map<String, Object?> metadata,
                    String name,
                    double? price,
                    Optional<double> quantity,
                  })
                >(
                  (_v2) => (() {
                    final _v3 = (_v2 as Map).cast<String, Object?>();
                    return (
                      id: (_v3['id'] as String),
                      metadata: (_v3['metadata'] as Map)
                          .cast<String, Object?>()
                          .map((_v4, _v5) => MapEntry(_v4, _v5)),
                      name: (_v3['name'] as String),
                      price: _v3['price'] == null
                          ? null
                          : (_v3['price'] as num).toDouble(),
                      quantity: _v3.containsKey('quantity')
                          ? Defined<double>((_v3['quantity'] as num).toDouble())
                          : Undefined<double>(),
                    );
                  })(),
                )
                .toList(growable: false),
            total: (_v1['total'] as num).toDouble(),
          );
        })(),
      );
    })();
  }

  @override
  Query120Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (() {
          final _v1 = (_v0['i'] as Map).cast<String, Object?>();
          return (
            items: (_v1['items'] as List)
                .map<
                  ({
                    String id,
                    Map<String, Object?> metadata,
                    String name,
                    double? price,
                    Optional<double> quantity,
                  })
                >(
                  (_v2) => (() {
                    final _v3 = (_v2 as Map).cast<String, Object?>();
                    return (
                      id: (_v3['id'] as String),
                      metadata: (_v3['metadata'] as Map)
                          .cast<String, Object?>()
                          .map((_v4, _v5) => MapEntry(_v4, _v5)),
                      name: (_v3['name'] as String),
                      price: _v3['price'] == null
                          ? null
                          : (_v3['price'] as num).toDouble(),
                      quantity: _v3.containsKey('quantity')
                          ? Defined<double>((_v3['quantity'] as num).toDouble())
                          : Undefined<double>(),
                    );
                  })(),
                )
                .toList(growable: false),
            total: (_v1['total'] as num).toDouble(),
          );
        })(),
      );
    })();
  }
}

final query121 = Query121();

class Query121 extends ConvexQuery<Query121Args, Query121Return> {
  Query121() : super("generic_functions:query121");

  @override
  Map<String, Object?> parseArgs(Query121Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': _v0.i
            .map<Object?>(
              (_v1) => (() {
                final _v2 = _v1;
                return {
                  'posts': _v2.posts
                      .map<Object?>(
                        (_v3) => (() {
                          final _v4 = _v3;
                          return {
                            'content': _v4.content.split(
                              (_v5) => _v5,
                              (_v6) => (() {
                                final _v7 = _v6;
                                return {
                                  'media': _v7.media
                                      .map<Object?>((_v8) => _v8)
                                      .toList(growable: false),
                                  'text': _v7.text,
                                };
                              })(),
                            ),
                            'id': _v4.id,
                            'likes': _v4.likes,
                            'tags': _v4.tags
                                .map<Object?>((_v9) => _v9)
                                .toList(growable: false),
                          };
                        })(),
                      )
                      .toList(growable: false),
                  'user': (() {
                    final _v10 = _v2.user;
                    return {
                      'preferences': {
                        for (final _v11 in _v10.preferences.entries)
                          _v11.key: _v11.value.split(
                            (_v12) => _v12,
                            (_v13) => _v13,
                            (_v14) => _v14,
                          ),
                      },
                      'profile': (() {
                        final _v15 = _v10.profile;
                        return {
                          if (_v15.avatar.isDefined)
                            'avatar': _v15.avatar.asDefined().value,
                          'name': _v15.name,
                        };
                      })(),
                    };
                  })(),
                };
              })(),
            )
            .toList(growable: false),
      };
    })();
  }

  @override
  Query121Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as List)
            .map<
              ({
                List<
                  ({
                    Union2<String, ({List<String> media, String text})> content,
                    String id,
                    double likes,
                    List<String> tags,
                  })
                >
                posts,
                ({
                  Map<String, Union3<String, double, bool>> preferences,
                  ({Optional<String> avatar, String name}) profile,
                })
                user,
              })
            >(
              (_v1) => (() {
                final _v2 = (_v1 as Map).cast<String, Object?>();
                return (
                  posts: (_v2['posts'] as List)
                      .map<
                        ({
                          Union2<String, ({List<String> media, String text})>
                          content,
                          String id,
                          double likes,
                          List<String> tags,
                        })
                      >(
                        (_v3) => (() {
                          final _v4 = (_v3 as Map).cast<String, Object?>();
                          return (
                            content:
                                Union2<
                                  String,
                                  ({List<String> media, String text})
                                >(() {
                                  try {
                                    return (_v4['content'] as String);
                                  } catch (e) {}

                                  try {
                                    return (() {
                                      final _v5 = (_v4['content'] as Map)
                                          .cast<String, Object?>();
                                      return (
                                        media: (_v5['media'] as List)
                                            .map<String>(
                                              (_v6) => (_v6 as String),
                                            )
                                            .toList(growable: false),
                                        text: (_v5['text'] as String),
                                      );
                                    })();
                                  } catch (e) {}

                                  throw Exception(
                                    (_v4['content'].toString()) +
                                        r" cannot be deserialized into a Union2<String, ({List<String> media,String text})>",
                                  );
                                }()),
                            id: (_v4['id'] as String),
                            likes: (_v4['likes'] as num).toDouble(),
                            tags: (_v4['tags'] as List)
                                .map<String>((_v7) => (_v7 as String))
                                .toList(growable: false),
                          );
                        })(),
                      )
                      .toList(growable: false),
                  user: (() {
                    final _v8 = (_v2['user'] as Map).cast<String, Object?>();
                    return (
                      preferences: (_v8['preferences'] as Map)
                          .cast<String, Object?>()
                          .map(
                            (_v9, _v10) => MapEntry(
                              _v9,
                              Union3<String, double, bool>(() {
                                try {
                                  return (_v10 as String);
                                } catch (e) {}

                                try {
                                  return (_v10 as num).toDouble();
                                } catch (e) {}

                                try {
                                  return (_v10 as bool);
                                } catch (e) {}

                                throw Exception(
                                  (_v10.toString()) +
                                      r" cannot be deserialized into a Union3<String, double, bool>",
                                );
                              }()),
                            ),
                          ),
                      profile: (() {
                        final _v11 = (_v8['profile'] as Map)
                            .cast<String, Object?>();
                        return (
                          avatar: _v11.containsKey('avatar')
                              ? Defined<String>((_v11['avatar'] as String))
                              : Undefined<String>(),
                          name: (_v11['name'] as String),
                        );
                      })(),
                    );
                  })(),
                );
              })(),
            )
            .toList(growable: false),
      );
    })();
  }

  @override
  Query121Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as List)
            .map<
              ({
                List<
                  ({
                    Union2<String, ({List<String> media, String text})> content,
                    String id,
                    double likes,
                    List<String> tags,
                  })
                >
                posts,
                ({
                  Map<String, Union3<String, double, bool>> preferences,
                  ({Optional<String> avatar, String name}) profile,
                })
                user,
              })
            >(
              (_v1) => (() {
                final _v2 = (_v1 as Map).cast<String, Object?>();
                return (
                  posts: (_v2['posts'] as List)
                      .map<
                        ({
                          Union2<String, ({List<String> media, String text})>
                          content,
                          String id,
                          double likes,
                          List<String> tags,
                        })
                      >(
                        (_v3) => (() {
                          final _v4 = (_v3 as Map).cast<String, Object?>();
                          return (
                            content:
                                Union2<
                                  String,
                                  ({List<String> media, String text})
                                >(() {
                                  try {
                                    return (_v4['content'] as String);
                                  } catch (e) {}

                                  try {
                                    return (() {
                                      final _v5 = (_v4['content'] as Map)
                                          .cast<String, Object?>();
                                      return (
                                        media: (_v5['media'] as List)
                                            .map<String>(
                                              (_v6) => (_v6 as String),
                                            )
                                            .toList(growable: false),
                                        text: (_v5['text'] as String),
                                      );
                                    })();
                                  } catch (e) {}

                                  throw Exception(
                                    (_v4['content'].toString()) +
                                        r" cannot be deserialized into a Union2<String, ({List<String> media,String text})>",
                                  );
                                }()),
                            id: (_v4['id'] as String),
                            likes: (_v4['likes'] as num).toDouble(),
                            tags: (_v4['tags'] as List)
                                .map<String>((_v7) => (_v7 as String))
                                .toList(growable: false),
                          );
                        })(),
                      )
                      .toList(growable: false),
                  user: (() {
                    final _v8 = (_v2['user'] as Map).cast<String, Object?>();
                    return (
                      preferences: (_v8['preferences'] as Map)
                          .cast<String, Object?>()
                          .map(
                            (_v9, _v10) => MapEntry(
                              _v9,
                              Union3<String, double, bool>(() {
                                try {
                                  return (_v10 as String);
                                } catch (e) {}

                                try {
                                  return (_v10 as num).toDouble();
                                } catch (e) {}

                                try {
                                  return (_v10 as bool);
                                } catch (e) {}

                                throw Exception(
                                  (_v10.toString()) +
                                      r" cannot be deserialized into a Union3<String, double, bool>",
                                );
                              }()),
                            ),
                          ),
                      profile: (() {
                        final _v11 = (_v8['profile'] as Map)
                            .cast<String, Object?>();
                        return (
                          avatar: _v11.containsKey('avatar')
                              ? Defined<String>((_v11['avatar'] as String))
                              : Undefined<String>(),
                          name: (_v11['name'] as String),
                        );
                      })(),
                    );
                  })(),
                );
              })(),
            )
            .toList(growable: false),
      );
    })();
  }
}

final query122 = Query122();

class Query122 extends ConvexQuery<Query122Args, Query122Return> {
  Query122() : super("generic_functions:query122");

  @override
  Map<String, Object?> parseArgs(Query122Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': {
          for (final _v1 in _v0.i.entries)
            _v1.key: (() {
              final _v2 = _v1.value;
              return {
                'required': _v2.required,
                'schema': _v2.schema.split(
                  (_v3) => (() {
                    final _v4 = _v3;
                    return {'primitive': _v4.primitive.value.value};
                  })(),
                  (_v5) => (() {
                    final _v6 = _v5;
                    return {
                      'fields': {
                        for (final _v7 in _v6.fields.entries)
                          _v7.key: _v7.value,
                      },
                    };
                  })(),
                  (_v8) => (() {
                    final _v9 = _v8;
                    return {'elementType': _v9.elementType};
                  })(),
                ),
                'type': _v2.type.value.value,
              };
            })(),
        },
      };
    })();
  }

  @override
  Query122Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as Map).cast<String, Object?>().map(
          (_v1, _v2) => MapEntry(
            _v1,
            (() {
              final _v3 = (_v2 as Map).cast<String, Object?>();
              return (
                required: (_v3['required'] as bool),
                schema:
                    Union3<
                      ({$string$number$boolean primitive}),
                      ({Map<String, String> fields}),
                      ({String elementType})
                    >(() {
                      try {
                        return (() {
                          final _v4 = (_v3['schema'] as Map)
                              .cast<String, Object?>();
                          return (
                            primitive: $string$number$boolean.fromValue(
                              _v4['primitive'] as Object,
                            ),
                          );
                        })();
                      } catch (e) {}

                      try {
                        return (() {
                          final _v5 = (_v3['schema'] as Map)
                              .cast<String, Object?>();
                          return (
                            fields: (_v5['fields'] as Map)
                                .cast<String, Object?>()
                                .map(
                                  (_v6, _v7) => MapEntry(_v6, (_v7 as String)),
                                ),
                          );
                        })();
                      } catch (e) {}

                      try {
                        return (() {
                          final _v8 = (_v3['schema'] as Map)
                              .cast<String, Object?>();
                          return (elementType: (_v8['elementType'] as String));
                        })();
                      } catch (e) {}

                      throw Exception(
                        (_v3['schema'].toString()) +
                            r" cannot be deserialized into a Union3<({$string$number$boolean primitive}), ({Map<String, String> fields}), ({String elementType})>",
                      );
                    }()),
                type: $primitive$object$array.fromValue(_v3['type'] as Object),
              );
            })(),
          ),
        ),
      );
    })();
  }

  @override
  Query122Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as Map).cast<String, Object?>().map(
          (_v1, _v2) => MapEntry(
            _v1,
            (() {
              final _v3 = (_v2 as Map).cast<String, Object?>();
              return (
                required: (_v3['required'] as bool),
                schema:
                    Union3<
                      ({$string$number$boolean primitive}),
                      ({Map<String, String> fields}),
                      ({String elementType})
                    >(() {
                      try {
                        return (() {
                          final _v4 = (_v3['schema'] as Map)
                              .cast<String, Object?>();
                          return (
                            primitive: $string$number$boolean.fromValue(
                              _v4['primitive'] as Object,
                            ),
                          );
                        })();
                      } catch (e) {}

                      try {
                        return (() {
                          final _v5 = (_v3['schema'] as Map)
                              .cast<String, Object?>();
                          return (
                            fields: (_v5['fields'] as Map)
                                .cast<String, Object?>()
                                .map(
                                  (_v6, _v7) => MapEntry(_v6, (_v7 as String)),
                                ),
                          );
                        })();
                      } catch (e) {}

                      try {
                        return (() {
                          final _v8 = (_v3['schema'] as Map)
                              .cast<String, Object?>();
                          return (elementType: (_v8['elementType'] as String));
                        })();
                      } catch (e) {}

                      throw Exception(
                        (_v3['schema'].toString()) +
                            r" cannot be deserialized into a Union3<({$string$number$boolean primitive}), ({Map<String, String> fields}), ({String elementType})>",
                      );
                    }()),
                type: $primitive$object$array.fromValue(_v3['type'] as Object),
              );
            })(),
          ),
        ),
      );
    })();
  }
}

final query123 = Query123();

class Query123 extends ConvexQuery<Query123Args, Query123Return> {
  Query123() : super("generic_functions:query123");

  @override
  Map<String, Object?> parseArgs(Query123Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': _v0.i.split(
          (_v1) => (() {
            final _v2 = _v1;
            return {
              'content': _v2.content,
              if (_v2.formatting.isDefined)
                'formatting': (() {
                  final _v3 = _v2.formatting.asDefined().value;
                  return {
                    'bold': _v3.bold,
                    'color': _v3.color.value.value,
                    'italic': _v3.italic,
                  };
                })(),
              'type': _v2.type.value,
            };
          })(),
          (_v4) => (() {
            final _v5 = _v4;
            return {
              if (_v5.alt.isDefined) 'alt': _v5.alt.asDefined().value,
              'dimensions': (() {
                final _v6 = _v5.dimensions;
                return {'height': _v6.height, 'width': _v6.width};
              })(),
              'type': _v5.type.value,
              'url': _v5.url,
            };
          })(),
          (_v7) => (() {
            final _v8 = _v7;
            return {
              'items': _v8.items
                  .map<Object?>((_v9) => _v9)
                  .toList(growable: false),
              'ordered': _v8.ordered,
              'type': _v8.type.value,
            };
          })(),
        ),
      };
    })();
  }

  @override
  Query123Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i:
            Union3<
              ({
                String content,
                Optional<({bool bold, $red$blue$green color, bool italic})>
                formatting,
                $text type,
              }),
              ({
                Optional<String> alt,
                ({double height, double width}) dimensions,
                $image type,
                String url,
              }),
              ({List<String> items, bool ordered, $list type})
            >(() {
              try {
                return (() {
                  final _v1 = (_v0['i'] as Map).cast<String, Object?>();
                  return (
                    content: (_v1['content'] as String),
                    formatting: _v1.containsKey('formatting')
                        ? Defined<
                            ({bool bold, $red$blue$green color, bool italic})
                          >(
                            (() {
                              final _v2 = (_v1['formatting'] as Map)
                                  .cast<String, Object?>();
                              return (
                                bold: (_v2['bold'] as bool),
                                color: $red$blue$green.fromValue(
                                  _v2['color'] as Object,
                                ),
                                italic: (_v2['italic'] as bool),
                              );
                            })(),
                          )
                        : Undefined<
                            ({bool bold, $red$blue$green color, bool italic})
                          >(),
                    type: $text.validate(_v1['type']),
                  );
                })();
              } catch (e) {}

              try {
                return (() {
                  final _v3 = (_v0['i'] as Map).cast<String, Object?>();
                  return (
                    alt: _v3.containsKey('alt')
                        ? Defined<String>((_v3['alt'] as String))
                        : Undefined<String>(),
                    dimensions: (() {
                      final _v4 = (_v3['dimensions'] as Map)
                          .cast<String, Object?>();
                      return (
                        height: (_v4['height'] as num).toDouble(),
                        width: (_v4['width'] as num).toDouble(),
                      );
                    })(),
                    type: $image.validate(_v3['type']),
                    url: (_v3['url'] as String),
                  );
                })();
              } catch (e) {}

              try {
                return (() {
                  final _v5 = (_v0['i'] as Map).cast<String, Object?>();
                  return (
                    items: (_v5['items'] as List)
                        .map<String>((_v6) => (_v6 as String))
                        .toList(growable: false),
                    ordered: (_v5['ordered'] as bool),
                    type: $list.validate(_v5['type']),
                  );
                })();
              } catch (e) {}

              throw Exception(
                (_v0['i'].toString()) +
                    r" cannot be deserialized into a Union3<({String content,Optional<({bool bold,$red$blue$green color,bool italic})> formatting,$text type}), ({Optional<String> alt,({double height,double width}) dimensions,$image type,String url}), ({List<String> items,bool ordered,$list type})>",
              );
            }()),
      );
    })();
  }

  @override
  Query123Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i:
            Union3<
              ({
                String content,
                Optional<({bool bold, $red$blue$green color, bool italic})>
                formatting,
                $text type,
              }),
              ({
                Optional<String> alt,
                ({double height, double width}) dimensions,
                $image type,
                String url,
              }),
              ({List<String> items, bool ordered, $list type})
            >(() {
              try {
                return (() {
                  final _v1 = (_v0['i'] as Map).cast<String, Object?>();
                  return (
                    content: (_v1['content'] as String),
                    formatting: _v1.containsKey('formatting')
                        ? Defined<
                            ({bool bold, $red$blue$green color, bool italic})
                          >(
                            (() {
                              final _v2 = (_v1['formatting'] as Map)
                                  .cast<String, Object?>();
                              return (
                                bold: (_v2['bold'] as bool),
                                color: $red$blue$green.fromValue(
                                  _v2['color'] as Object,
                                ),
                                italic: (_v2['italic'] as bool),
                              );
                            })(),
                          )
                        : Undefined<
                            ({bool bold, $red$blue$green color, bool italic})
                          >(),
                    type: $text.validate(_v1['type']),
                  );
                })();
              } catch (e) {}

              try {
                return (() {
                  final _v3 = (_v0['i'] as Map).cast<String, Object?>();
                  return (
                    alt: _v3.containsKey('alt')
                        ? Defined<String>((_v3['alt'] as String))
                        : Undefined<String>(),
                    dimensions: (() {
                      final _v4 = (_v3['dimensions'] as Map)
                          .cast<String, Object?>();
                      return (
                        height: (_v4['height'] as num).toDouble(),
                        width: (_v4['width'] as num).toDouble(),
                      );
                    })(),
                    type: $image.validate(_v3['type']),
                    url: (_v3['url'] as String),
                  );
                })();
              } catch (e) {}

              try {
                return (() {
                  final _v5 = (_v0['i'] as Map).cast<String, Object?>();
                  return (
                    items: (_v5['items'] as List)
                        .map<String>((_v6) => (_v6 as String))
                        .toList(growable: false),
                    ordered: (_v5['ordered'] as bool),
                    type: $list.validate(_v5['type']),
                  );
                })();
              } catch (e) {}

              throw Exception(
                (_v0['i'].toString()) +
                    r" cannot be deserialized into a Union3<({String content,Optional<({bool bold,$red$blue$green color,bool italic})> formatting,$text type}), ({Optional<String> alt,({double height,double width}) dimensions,$image type,String url}), ({List<String> items,bool ordered,$list type})>",
              );
            }()),
      );
    })();
  }
}

final query124 = Query124();

class Query124 extends ConvexQuery<Query124Args, Query124Return> {
  Query124() : super("generic_functions:query124");

  @override
  Map<String, Object?> parseArgs(Query124Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': (() {
          final _v1 = _v0.i;
          return {
            'api': (() {
              final _v2 = _v1.api;
              return {
                'endpoints': {
                  for (final _v3 in _v2.endpoints.entries)
                    _v3.key: (() {
                      final _v4 = _v3.value;
                      return {
                        if (_v4.auth.isDefined)
                          'auth': _v4.auth.asDefined().value,
                        'method': _v4.method.value.value,
                        'params': {
                          for (final _v5 in _v4.params.entries)
                            _v5.key: _v5.value.split(
                              (_v6) => _v6,
                              (_v7) => _v7,
                              (_v8) => _v8,
                            ),
                        },
                        'path': _v4.path,
                        'response': _v4.response,
                      };
                    })(),
                },
                'rateLimit': (() {
                  final _v9 = _v2.rateLimit;
                  return {
                    'requests': _v9.requests,
                    'window': _v9.window.value.value,
                  };
                })(),
              };
            })(),
            'database': (() {
              final _v10 = _v1.database;
              return {
                'tables': {
                  for (final _v11 in _v10.tables.entries)
                    _v11.key: (() {
                      final _v12 = _v11.value;
                      return {
                        'indexes': _v12.indexes
                            .map<Object?>(
                              (_v13) => (() {
                                final _v14 = _v13;
                                return {
                                  'fields': _v14.fields
                                      .map<Object?>((_v15) => _v15)
                                      .toList(growable: false),
                                  'name': _v14.name,
                                  'unique': _v14.unique,
                                };
                              })(),
                            )
                            .toList(growable: false),
                        'schema': {
                          for (final _v16 in _v12.schema.entries)
                            _v16.key: _v16.value.value.value,
                        },
                      };
                    })(),
                },
              };
            })(),
          };
        })(),
      };
    })();
  }

  @override
  Query124Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (() {
          final _v1 = (_v0['i'] as Map).cast<String, Object?>();
          return (
            api: (() {
              final _v2 = (_v1['api'] as Map).cast<String, Object?>();
              return (
                endpoints: (_v2['endpoints'] as Map).cast<String, Object?>().map(
                  (_v3, _v4) => MapEntry(
                    _v3,
                    (() {
                      final _v5 = (_v4 as Map).cast<String, Object?>();
                      return (
                        auth: _v5.containsKey('auth')
                            ? Defined<bool>((_v5['auth'] as bool))
                            : Undefined<bool>(),
                        method: $get$post$put$delete.fromValue(
                          _v5['method'] as Object,
                        ),
                        params: (_v5['params'] as Map).cast<String, Object?>().map(
                          (_v6, _v7) => MapEntry(
                            _v6,
                            Union3<String, double, bool>(() {
                              try {
                                return (_v7 as String);
                              } catch (e) {}

                              try {
                                return (_v7 as num).toDouble();
                              } catch (e) {}

                              try {
                                return (_v7 as bool);
                              } catch (e) {}

                              throw Exception(
                                (_v7.toString()) +
                                    r" cannot be deserialized into a Union3<String, double, bool>",
                              );
                            }()),
                          ),
                        ),
                        path: (_v5['path'] as String),
                        response: _v5['response'],
                      );
                    })(),
                  ),
                ),
                rateLimit: (() {
                  final _v8 = (_v2['rateLimit'] as Map).cast<String, Object?>();
                  return (
                    requests: (_v8['requests'] as num).toDouble(),
                    window: $minute$hour$day.fromValue(_v8['window'] as Object),
                  );
                })(),
              );
            })(),
            database: (() {
              final _v9 = (_v1['database'] as Map).cast<String, Object?>();
              return (
                tables: (_v9['tables'] as Map).cast<String, Object?>().map(
                  (_v10, _v11) => MapEntry(
                    _v10,
                    (() {
                      final _v12 = (_v11 as Map).cast<String, Object?>();
                      return (
                        indexes: (_v12['indexes'] as List)
                            .map<
                              ({List<String> fields, String name, bool unique})
                            >(
                              (_v13) => (() {
                                final _v14 = (_v13 as Map)
                                    .cast<String, Object?>();
                                return (
                                  fields: (_v14['fields'] as List)
                                      .map<String>((_v15) => (_v15 as String))
                                      .toList(growable: false),
                                  name: (_v14['name'] as String),
                                  unique: (_v14['unique'] as bool),
                                );
                              })(),
                            )
                            .toList(growable: false),
                        schema: (_v12['schema'] as Map)
                            .cast<String, Object?>()
                            .map(
                              (_v16, _v17) => MapEntry(
                                _v16,
                                $string$number$boolean$date.fromValue(
                                  _v17 as Object,
                                ),
                              ),
                            ),
                      );
                    })(),
                  ),
                ),
              );
            })(),
          );
        })(),
      );
    })();
  }

  @override
  Query124Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (() {
          final _v1 = (_v0['i'] as Map).cast<String, Object?>();
          return (
            api: (() {
              final _v2 = (_v1['api'] as Map).cast<String, Object?>();
              return (
                endpoints: (_v2['endpoints'] as Map).cast<String, Object?>().map(
                  (_v3, _v4) => MapEntry(
                    _v3,
                    (() {
                      final _v5 = (_v4 as Map).cast<String, Object?>();
                      return (
                        auth: _v5.containsKey('auth')
                            ? Defined<bool>((_v5['auth'] as bool))
                            : Undefined<bool>(),
                        method: $get$post$put$delete.fromValue(
                          _v5['method'] as Object,
                        ),
                        params: (_v5['params'] as Map).cast<String, Object?>().map(
                          (_v6, _v7) => MapEntry(
                            _v6,
                            Union3<String, double, bool>(() {
                              try {
                                return (_v7 as String);
                              } catch (e) {}

                              try {
                                return (_v7 as num).toDouble();
                              } catch (e) {}

                              try {
                                return (_v7 as bool);
                              } catch (e) {}

                              throw Exception(
                                (_v7.toString()) +
                                    r" cannot be deserialized into a Union3<String, double, bool>",
                              );
                            }()),
                          ),
                        ),
                        path: (_v5['path'] as String),
                        response: _v5['response'],
                      );
                    })(),
                  ),
                ),
                rateLimit: (() {
                  final _v8 = (_v2['rateLimit'] as Map).cast<String, Object?>();
                  return (
                    requests: (_v8['requests'] as num).toDouble(),
                    window: $minute$hour$day.fromValue(_v8['window'] as Object),
                  );
                })(),
              );
            })(),
            database: (() {
              final _v9 = (_v1['database'] as Map).cast<String, Object?>();
              return (
                tables: (_v9['tables'] as Map).cast<String, Object?>().map(
                  (_v10, _v11) => MapEntry(
                    _v10,
                    (() {
                      final _v12 = (_v11 as Map).cast<String, Object?>();
                      return (
                        indexes: (_v12['indexes'] as List)
                            .map<
                              ({List<String> fields, String name, bool unique})
                            >(
                              (_v13) => (() {
                                final _v14 = (_v13 as Map)
                                    .cast<String, Object?>();
                                return (
                                  fields: (_v14['fields'] as List)
                                      .map<String>((_v15) => (_v15 as String))
                                      .toList(growable: false),
                                  name: (_v14['name'] as String),
                                  unique: (_v14['unique'] as bool),
                                );
                              })(),
                            )
                            .toList(growable: false),
                        schema: (_v12['schema'] as Map)
                            .cast<String, Object?>()
                            .map(
                              (_v16, _v17) => MapEntry(
                                _v16,
                                $string$number$boolean$date.fromValue(
                                  _v17 as Object,
                                ),
                              ),
                            ),
                      );
                    })(),
                  ),
                ),
              );
            })(),
          );
        })(),
      );
    })();
  }
}

final query125 = Query125();

class Query125 extends ConvexQuery<Query125Args, Query125Return> {
  Query125() : super("generic_functions:query125");

  @override
  Map<String, Object?> parseArgs(Query125Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': (() {
          final _v1 = _v0.i;
          return {
            'workflow': (() {
              final _v2 = _v1.workflow;
              return {
                'steps': _v2.steps
                    .map<Object?>(
                      (_v3) => (() {
                        final _v4 = _v3;
                        return {
                          'config': {
                            for (final _v5 in _v4.config.entries)
                              _v5.key: _v5.value,
                          },
                          if (_v4.error.isDefined)
                            'error': (() {
                              final _v6 = _v4.error.asDefined().value;
                              return {
                                'handler': _v6.handler,
                                'retry': (() {
                                  final _v7 = _v6.retry;
                                  return {
                                    'count': _v7.count,
                                    'delay': _v7.delay,
                                  };
                                })(),
                              };
                            })(),
                          'id': _v4.id,
                          'name': _v4.name,
                          if (_v4.next.isDefined)
                            'next': _v4.next.asDefined().value,
                          'type': _v4.type.value.value,
                        };
                      })(),
                    )
                    .toList(growable: false),
                'triggers': _v2.triggers
                    .map<Object?>(
                      (_v8) => _v8.split(
                        (_v9) => (() {
                          final _v10 = _v9;
                          return {'cron': _v10.cron, 'type': _v10.type.value};
                        })(),
                        (_v11) => (() {
                          final _v12 = _v11;
                          return {'type': _v12.type.value, 'url': _v12.url};
                        })(),
                        (_v13) => (() {
                          final _v14 = _v13;
                          return {
                            'eventType': _v14.eventType,
                            'type': _v14.type.value,
                          };
                        })(),
                      ),
                    )
                    .toList(growable: false),
                'variables': {
                  for (final _v15 in _v2.variables.entries)
                    _v15.key: _v15.value.split(
                      (_v16) => _v16,
                      (_v17) => _v17,
                      (_v18) => _v18,
                      (_v19) => _v19
                          .map<Object?>((_v20) => _v20)
                          .toList(growable: false),
                    ),
                },
              };
            })(),
          };
        })(),
      };
    })();
  }

  @override
  Query125Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (() {
          final _v1 = (_v0['i'] as Map).cast<String, Object?>();
          return (
            workflow: (() {
              final _v2 = (_v1['workflow'] as Map).cast<String, Object?>();
              return (
                steps: (_v2['steps'] as List)
                    .map<
                      ({
                        Map<String, Object?> config,
                        Optional<
                          ({
                            String handler,
                            ({double count, double delay}) retry,
                          })
                        >
                        error,
                        String id,
                        String name,
                        Optional<String> next,
                        $action$condition$loop type,
                      })
                    >(
                      (_v3) => (() {
                        final _v4 = (_v3 as Map).cast<String, Object?>();
                        return (
                          config: (_v4['config'] as Map)
                              .cast<String, Object?>()
                              .map((_v5, _v6) => MapEntry(_v5, _v6)),
                          error: _v4.containsKey('error')
                              ? Defined<
                                  ({
                                    String handler,
                                    ({double count, double delay}) retry,
                                  })
                                >(
                                  (() {
                                    final _v7 = (_v4['error'] as Map)
                                        .cast<String, Object?>();
                                    return (
                                      handler: (_v7['handler'] as String),
                                      retry: (() {
                                        final _v8 = (_v7['retry'] as Map)
                                            .cast<String, Object?>();
                                        return (
                                          count: (_v8['count'] as num)
                                              .toDouble(),
                                          delay: (_v8['delay'] as num)
                                              .toDouble(),
                                        );
                                      })(),
                                    );
                                  })(),
                                )
                              : Undefined<
                                  ({
                                    String handler,
                                    ({double count, double delay}) retry,
                                  })
                                >(),
                          id: (_v4['id'] as String),
                          name: (_v4['name'] as String),
                          next: _v4.containsKey('next')
                              ? Defined<String>((_v4['next'] as String))
                              : Undefined<String>(),
                          type: $action$condition$loop.fromValue(
                            _v4['type'] as Object,
                          ),
                        );
                      })(),
                    )
                    .toList(growable: false),
                triggers: (_v2['triggers'] as List)
                    .map<
                      Union3<
                        ({String cron, $schedule type}),
                        ({$webhook type, String url}),
                        ({String eventType, $event type})
                      >
                    >(
                      (_v9) =>
                          Union3<
                            ({String cron, $schedule type}),
                            ({$webhook type, String url}),
                            ({String eventType, $event type})
                          >(() {
                            try {
                              return (() {
                                final _v10 = (_v9 as Map)
                                    .cast<String, Object?>();
                                return (
                                  cron: (_v10['cron'] as String),
                                  type: $schedule.validate(_v10['type']),
                                );
                              })();
                            } catch (e) {}

                            try {
                              return (() {
                                final _v11 = (_v9 as Map)
                                    .cast<String, Object?>();
                                return (
                                  type: $webhook.validate(_v11['type']),
                                  url: (_v11['url'] as String),
                                );
                              })();
                            } catch (e) {}

                            try {
                              return (() {
                                final _v12 = (_v9 as Map)
                                    .cast<String, Object?>();
                                return (
                                  eventType: (_v12['eventType'] as String),
                                  type: $event.validate(_v12['type']),
                                );
                              })();
                            } catch (e) {}

                            throw Exception(
                              (_v9.toString()) +
                                  r" cannot be deserialized into a Union3<({String cron,$schedule type}), ({$webhook type,String url}), ({String eventType,$event type})>",
                            );
                          }()),
                    )
                    .toList(growable: false),
                variables: (_v2['variables'] as Map).cast<String, Object?>().map(
                  (_v13, _v14) => MapEntry(
                    _v13,
                    Union4<String, double, bool, List<Object?>>(() {
                      try {
                        return (_v14 as String);
                      } catch (e) {}

                      try {
                        return (_v14 as num).toDouble();
                      } catch (e) {}

                      try {
                        return (_v14 as bool);
                      } catch (e) {}

                      try {
                        return (_v14 as List)
                            .map<Object?>((_v15) => _v15)
                            .toList(growable: false);
                      } catch (e) {}

                      throw Exception(
                        (_v14.toString()) +
                            r" cannot be deserialized into a Union4<String, double, bool, List<Object?>>",
                      );
                    }()),
                  ),
                ),
              );
            })(),
          );
        })(),
      );
    })();
  }

  @override
  Query125Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (() {
          final _v1 = (_v0['i'] as Map).cast<String, Object?>();
          return (
            workflow: (() {
              final _v2 = (_v1['workflow'] as Map).cast<String, Object?>();
              return (
                steps: (_v2['steps'] as List)
                    .map<
                      ({
                        Map<String, Object?> config,
                        Optional<
                          ({
                            String handler,
                            ({double count, double delay}) retry,
                          })
                        >
                        error,
                        String id,
                        String name,
                        Optional<String> next,
                        $action$condition$loop type,
                      })
                    >(
                      (_v3) => (() {
                        final _v4 = (_v3 as Map).cast<String, Object?>();
                        return (
                          config: (_v4['config'] as Map)
                              .cast<String, Object?>()
                              .map((_v5, _v6) => MapEntry(_v5, _v6)),
                          error: _v4.containsKey('error')
                              ? Defined<
                                  ({
                                    String handler,
                                    ({double count, double delay}) retry,
                                  })
                                >(
                                  (() {
                                    final _v7 = (_v4['error'] as Map)
                                        .cast<String, Object?>();
                                    return (
                                      handler: (_v7['handler'] as String),
                                      retry: (() {
                                        final _v8 = (_v7['retry'] as Map)
                                            .cast<String, Object?>();
                                        return (
                                          count: (_v8['count'] as num)
                                              .toDouble(),
                                          delay: (_v8['delay'] as num)
                                              .toDouble(),
                                        );
                                      })(),
                                    );
                                  })(),
                                )
                              : Undefined<
                                  ({
                                    String handler,
                                    ({double count, double delay}) retry,
                                  })
                                >(),
                          id: (_v4['id'] as String),
                          name: (_v4['name'] as String),
                          next: _v4.containsKey('next')
                              ? Defined<String>((_v4['next'] as String))
                              : Undefined<String>(),
                          type: $action$condition$loop.fromValue(
                            _v4['type'] as Object,
                          ),
                        );
                      })(),
                    )
                    .toList(growable: false),
                triggers: (_v2['triggers'] as List)
                    .map<
                      Union3<
                        ({String cron, $schedule type}),
                        ({$webhook type, String url}),
                        ({String eventType, $event type})
                      >
                    >(
                      (_v9) =>
                          Union3<
                            ({String cron, $schedule type}),
                            ({$webhook type, String url}),
                            ({String eventType, $event type})
                          >(() {
                            try {
                              return (() {
                                final _v10 = (_v9 as Map)
                                    .cast<String, Object?>();
                                return (
                                  cron: (_v10['cron'] as String),
                                  type: $schedule.validate(_v10['type']),
                                );
                              })();
                            } catch (e) {}

                            try {
                              return (() {
                                final _v11 = (_v9 as Map)
                                    .cast<String, Object?>();
                                return (
                                  type: $webhook.validate(_v11['type']),
                                  url: (_v11['url'] as String),
                                );
                              })();
                            } catch (e) {}

                            try {
                              return (() {
                                final _v12 = (_v9 as Map)
                                    .cast<String, Object?>();
                                return (
                                  eventType: (_v12['eventType'] as String),
                                  type: $event.validate(_v12['type']),
                                );
                              })();
                            } catch (e) {}

                            throw Exception(
                              (_v9.toString()) +
                                  r" cannot be deserialized into a Union3<({String cron,$schedule type}), ({$webhook type,String url}), ({String eventType,$event type})>",
                            );
                          }()),
                    )
                    .toList(growable: false),
                variables: (_v2['variables'] as Map).cast<String, Object?>().map(
                  (_v13, _v14) => MapEntry(
                    _v13,
                    Union4<String, double, bool, List<Object?>>(() {
                      try {
                        return (_v14 as String);
                      } catch (e) {}

                      try {
                        return (_v14 as num).toDouble();
                      } catch (e) {}

                      try {
                        return (_v14 as bool);
                      } catch (e) {}

                      try {
                        return (_v14 as List)
                            .map<Object?>((_v15) => _v15)
                            .toList(growable: false);
                      } catch (e) {}

                      throw Exception(
                        (_v14.toString()) +
                            r" cannot be deserialized into a Union4<String, double, bool, List<Object?>>",
                      );
                    }()),
                  ),
                ),
              );
            })(),
          );
        })(),
      );
    })();
  }
}

final query126 = Query126();

class Query126 extends ConvexQuery<Query126Args, Query126Return> {
  Query126() : super("generic_functions:query126");

  @override
  Map<String, Object?> parseArgs(Query126Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': (() {
          final _v1 = _v0.i;
          return {'stepType': _v1.stepType.value.value};
        })(),
      };
    })();
  }

  @override
  Query126Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (() {
          final _v1 = (_v0['i'] as Map).cast<String, Object?>();
          return (
            stepType: $action$condition$loop.fromValue(
              _v1['stepType'] as Object,
            ),
          );
        })(),
      );
    })();
  }

  @override
  Query126Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (() {
          final _v1 = (_v0['i'] as Map).cast<String, Object?>();
          return (
            stepType: $action$condition$loop.fromValue(
              _v1['stepType'] as Object,
            ),
          );
        })(),
      );
    })();
  }
}

final query127 = Query127();

class Query127 extends ConvexQuery<Query127Args, Query127Return> {
  Query127() : super("generic_functions:query127");

  @override
  Map<String, Object?> parseArgs(Query127Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': (() {
          final _v1 = _v0.i;
          return {
            'variables': {
              for (final _v2 in _v1.variables.entries)
                _v2.key: _v2.value.split(
                  (_v3) => _v3,
                  (_v4) => _v4,
                  (_v5) => _v5,
                  (_v6) =>
                      _v6.map<Object?>((_v7) => _v7).toList(growable: false),
                ),
            },
          };
        })(),
      };
    })();
  }

  @override
  Query127Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (() {
          final _v1 = (_v0['i'] as Map).cast<String, Object?>();
          return (
            variables: (_v1['variables'] as Map).cast<String, Object?>().map(
              (_v2, _v3) => MapEntry(
                _v2,
                Union4<String, double, bool, List<Object?>>(() {
                  try {
                    return (_v3 as String);
                  } catch (e) {}

                  try {
                    return (_v3 as num).toDouble();
                  } catch (e) {}

                  try {
                    return (_v3 as bool);
                  } catch (e) {}

                  try {
                    return (_v3 as List)
                        .map<Object?>((_v4) => _v4)
                        .toList(growable: false);
                  } catch (e) {}

                  throw Exception(
                    (_v3.toString()) +
                        r" cannot be deserialized into a Union4<String, double, bool, List<Object?>>",
                  );
                }()),
              ),
            ),
          );
        })(),
      );
    })();
  }

  @override
  Query127Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (() {
          final _v1 = (_v0['i'] as Map).cast<String, Object?>();
          return (
            variables: (_v1['variables'] as Map).cast<String, Object?>().map(
              (_v2, _v3) => MapEntry(
                _v2,
                Union4<String, double, bool, List<Object?>>(() {
                  try {
                    return (_v3 as String);
                  } catch (e) {}

                  try {
                    return (_v3 as num).toDouble();
                  } catch (e) {}

                  try {
                    return (_v3 as bool);
                  } catch (e) {}

                  try {
                    return (_v3 as List)
                        .map<Object?>((_v4) => _v4)
                        .toList(growable: false);
                  } catch (e) {}

                  throw Exception(
                    (_v3.toString()) +
                        r" cannot be deserialized into a Union4<String, double, bool, List<Object?>>",
                  );
                }()),
              ),
            ),
          );
        })(),
      );
    })();
  }
}

final query128 = Query128();

class Query128 extends ConvexQuery<Query128Args, Query128Return> {
  Query128() : super("generic_functions:query128");

  @override
  Map<String, Object?> parseArgs(Query128Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': (() {
          final _v1 = _v0.i;
          return {
            'triggers': _v1.triggers
                .map<Object?>(
                  (_v2) => _v2.split(
                    (_v3) => (() {
                      final _v4 = _v3;
                      return {'cron': _v4.cron, 'type': _v4.type.value};
                    })(),
                    (_v5) => (() {
                      final _v6 = _v5;
                      return {'type': _v6.type.value, 'url': _v6.url};
                    })(),
                    (_v7) => (() {
                      final _v8 = _v7;
                      return {
                        'eventType': _v8.eventType,
                        'type': _v8.type.value,
                      };
                    })(),
                  ),
                )
                .toList(growable: false),
          };
        })(),
      };
    })();
  }

  @override
  Query128Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (() {
          final _v1 = (_v0['i'] as Map).cast<String, Object?>();
          return (
            triggers: (_v1['triggers'] as List)
                .map<
                  Union3<
                    ({String cron, $schedule type}),
                    ({$webhook type, String url}),
                    ({String eventType, $event type})
                  >
                >(
                  (_v2) =>
                      Union3<
                        ({String cron, $schedule type}),
                        ({$webhook type, String url}),
                        ({String eventType, $event type})
                      >(() {
                        try {
                          return (() {
                            final _v3 = (_v2 as Map).cast<String, Object?>();
                            return (
                              cron: (_v3['cron'] as String),
                              type: $schedule.validate(_v3['type']),
                            );
                          })();
                        } catch (e) {}

                        try {
                          return (() {
                            final _v4 = (_v2 as Map).cast<String, Object?>();
                            return (
                              type: $webhook.validate(_v4['type']),
                              url: (_v4['url'] as String),
                            );
                          })();
                        } catch (e) {}

                        try {
                          return (() {
                            final _v5 = (_v2 as Map).cast<String, Object?>();
                            return (
                              eventType: (_v5['eventType'] as String),
                              type: $event.validate(_v5['type']),
                            );
                          })();
                        } catch (e) {}

                        throw Exception(
                          (_v2.toString()) +
                              r" cannot be deserialized into a Union3<({String cron,$schedule type}), ({$webhook type,String url}), ({String eventType,$event type})>",
                        );
                      }()),
                )
                .toList(growable: false),
          );
        })(),
      );
    })();
  }

  @override
  Query128Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (() {
          final _v1 = (_v0['i'] as Map).cast<String, Object?>();
          return (
            triggers: (_v1['triggers'] as List)
                .map<
                  Union3<
                    ({String cron, $schedule type}),
                    ({$webhook type, String url}),
                    ({String eventType, $event type})
                  >
                >(
                  (_v2) =>
                      Union3<
                        ({String cron, $schedule type}),
                        ({$webhook type, String url}),
                        ({String eventType, $event type})
                      >(() {
                        try {
                          return (() {
                            final _v3 = (_v2 as Map).cast<String, Object?>();
                            return (
                              cron: (_v3['cron'] as String),
                              type: $schedule.validate(_v3['type']),
                            );
                          })();
                        } catch (e) {}

                        try {
                          return (() {
                            final _v4 = (_v2 as Map).cast<String, Object?>();
                            return (
                              type: $webhook.validate(_v4['type']),
                              url: (_v4['url'] as String),
                            );
                          })();
                        } catch (e) {}

                        try {
                          return (() {
                            final _v5 = (_v2 as Map).cast<String, Object?>();
                            return (
                              eventType: (_v5['eventType'] as String),
                              type: $event.validate(_v5['type']),
                            );
                          })();
                        } catch (e) {}

                        throw Exception(
                          (_v2.toString()) +
                              r" cannot be deserialized into a Union3<({String cron,$schedule type}), ({$webhook type,String url}), ({String eventType,$event type})>",
                        );
                      }()),
                )
                .toList(growable: false),
          );
        })(),
      );
    })();
  }
}

final query129 = Query129();

class Query129 extends ConvexQuery<Query129Args, Query129Return> {
  Query129() : super("generic_functions:query129");

  @override
  Map<String, Object?> parseArgs(Query129Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': (() {
          final _v1 = _v0.i;
          return {
            if (_v1.error.isDefined)
              'error': (() {
                final _v2 = _v1.error.asDefined().value;
                return {
                  'handler': _v2.handler,
                  'retry': (() {
                    final _v3 = _v2.retry;
                    return {'count': _v3.count, 'delay': _v3.delay};
                  })(),
                };
              })(),
          };
        })(),
      };
    })();
  }

  @override
  Query129Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (() {
          final _v1 = (_v0['i'] as Map).cast<String, Object?>();
          return (
            error: _v1.containsKey('error')
                ? Defined<
                    ({String handler, ({double count, double delay}) retry})
                  >(
                    (() {
                      final _v2 = (_v1['error'] as Map).cast<String, Object?>();
                      return (
                        handler: (_v2['handler'] as String),
                        retry: (() {
                          final _v3 = (_v2['retry'] as Map)
                              .cast<String, Object?>();
                          return (
                            count: (_v3['count'] as num).toDouble(),
                            delay: (_v3['delay'] as num).toDouble(),
                          );
                        })(),
                      );
                    })(),
                  )
                : Undefined<
                    ({String handler, ({double count, double delay}) retry})
                  >(),
          );
        })(),
      );
    })();
  }

  @override
  Query129Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (() {
          final _v1 = (_v0['i'] as Map).cast<String, Object?>();
          return (
            error: _v1.containsKey('error')
                ? Defined<
                    ({String handler, ({double count, double delay}) retry})
                  >(
                    (() {
                      final _v2 = (_v1['error'] as Map).cast<String, Object?>();
                      return (
                        handler: (_v2['handler'] as String),
                        retry: (() {
                          final _v3 = (_v2['retry'] as Map)
                              .cast<String, Object?>();
                          return (
                            count: (_v3['count'] as num).toDouble(),
                            delay: (_v3['delay'] as num).toDouble(),
                          );
                        })(),
                      );
                    })(),
                  )
                : Undefined<
                    ({String handler, ({double count, double delay}) retry})
                  >(),
          );
        })(),
      );
    })();
  }
}

final query130 = Query130();

class Query130 extends ConvexQuery<Query130Args, Query130Return> {
  Query130() : super("generic_functions:query130");

  @override
  Map<String, Object?> parseArgs(Query130Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': (() {
          final _v1 = _v0.i;
          return {
            'steps': _v1.steps
                .map<Object?>(
                  (_v2) => (() {
                    final _v3 = _v2;
                    return {
                      'config': {
                        for (final _v4 in _v3.config.entries)
                          _v4.key: _v4.value,
                      },
                      'id': _v3.id,
                      'name': _v3.name,
                      if (_v3.next.isDefined)
                        'next': _v3.next.asDefined().value,
                    };
                  })(),
                )
                .toList(growable: false),
          };
        })(),
      };
    })();
  }

  @override
  Query130Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (() {
          final _v1 = (_v0['i'] as Map).cast<String, Object?>();
          return (
            steps: (_v1['steps'] as List)
                .map<
                  ({
                    Map<String, Object?> config,
                    String id,
                    String name,
                    Optional<String> next,
                  })
                >(
                  (_v2) => (() {
                    final _v3 = (_v2 as Map).cast<String, Object?>();
                    return (
                      config: (_v3['config'] as Map)
                          .cast<String, Object?>()
                          .map((_v4, _v5) => MapEntry(_v4, _v5)),
                      id: (_v3['id'] as String),
                      name: (_v3['name'] as String),
                      next: _v3.containsKey('next')
                          ? Defined<String>((_v3['next'] as String))
                          : Undefined<String>(),
                    );
                  })(),
                )
                .toList(growable: false),
          );
        })(),
      );
    })();
  }

  @override
  Query130Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (() {
          final _v1 = (_v0['i'] as Map).cast<String, Object?>();
          return (
            steps: (_v1['steps'] as List)
                .map<
                  ({
                    Map<String, Object?> config,
                    String id,
                    String name,
                    Optional<String> next,
                  })
                >(
                  (_v2) => (() {
                    final _v3 = (_v2 as Map).cast<String, Object?>();
                    return (
                      config: (_v3['config'] as Map)
                          .cast<String, Object?>()
                          .map((_v4, _v5) => MapEntry(_v4, _v5)),
                      id: (_v3['id'] as String),
                      name: (_v3['name'] as String),
                      next: _v3.containsKey('next')
                          ? Defined<String>((_v3['next'] as String))
                          : Undefined<String>(),
                    );
                  })(),
                )
                .toList(growable: false),
          );
        })(),
      );
    })();
  }
}

final query131 = Query131();

class Query131 extends ConvexQuery<Query131Args, Query131Return> {
  Query131() : super("generic_functions:query131");

  @override
  Map<String, Object?> parseArgs(Query131Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': (() {
          final _v1 = _v0.i;
          return {
            'steps': _v1.steps
                .map<Object?>(
                  (_v2) => (() {
                    final _v3 = _v2;
                    return {
                      if (_v3.error.isDefined)
                        'error': (() {
                          final _v4 = _v3.error.asDefined().value;
                          return {
                            'handler': _v4.handler,
                            'retry': (() {
                              final _v5 = _v4.retry;
                              return {'count': _v5.count, 'delay': _v5.delay};
                            })(),
                          };
                        })(),
                      'type': _v3.type.value.value,
                    };
                  })(),
                )
                .toList(growable: false),
            'triggers': _v1.triggers
                .map<Object?>(
                  (_v6) => _v6.split(
                    (_v7) => (() {
                      final _v8 = _v7;
                      return {'cron': _v8.cron, 'type': _v8.type.value};
                    })(),
                    (_v9) => (() {
                      final _v10 = _v9;
                      return {'type': _v10.type.value, 'url': _v10.url};
                    })(),
                    (_v11) => (() {
                      final _v12 = _v11;
                      return {
                        'eventType': _v12.eventType,
                        'type': _v12.type.value,
                      };
                    })(),
                  ),
                )
                .toList(growable: false),
            'variables': {
              for (final _v13 in _v1.variables.entries)
                _v13.key: _v13.value.split(
                  (_v14) => _v14,
                  (_v15) => _v15,
                  (_v16) => _v16,
                  (_v17) =>
                      _v17.map<Object?>((_v18) => _v18).toList(growable: false),
                ),
            },
          };
        })(),
      };
    })();
  }

  @override
  Query131Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (() {
          final _v1 = (_v0['i'] as Map).cast<String, Object?>();
          return (
            steps: (_v1['steps'] as List)
                .map<
                  ({
                    Optional<
                      ({String handler, ({double count, double delay}) retry})
                    >
                    error,
                    $action$condition$loop type,
                  })
                >(
                  (_v2) => (() {
                    final _v3 = (_v2 as Map).cast<String, Object?>();
                    return (
                      error: _v3.containsKey('error')
                          ? Defined<
                              ({
                                String handler,
                                ({double count, double delay}) retry,
                              })
                            >(
                              (() {
                                final _v4 = (_v3['error'] as Map)
                                    .cast<String, Object?>();
                                return (
                                  handler: (_v4['handler'] as String),
                                  retry: (() {
                                    final _v5 = (_v4['retry'] as Map)
                                        .cast<String, Object?>();
                                    return (
                                      count: (_v5['count'] as num).toDouble(),
                                      delay: (_v5['delay'] as num).toDouble(),
                                    );
                                  })(),
                                );
                              })(),
                            )
                          : Undefined<
                              ({
                                String handler,
                                ({double count, double delay}) retry,
                              })
                            >(),
                      type: $action$condition$loop.fromValue(
                        _v3['type'] as Object,
                      ),
                    );
                  })(),
                )
                .toList(growable: false),
            triggers: (_v1['triggers'] as List)
                .map<
                  Union3<
                    ({String cron, $schedule type}),
                    ({$webhook type, String url}),
                    ({String eventType, $event type})
                  >
                >(
                  (_v6) =>
                      Union3<
                        ({String cron, $schedule type}),
                        ({$webhook type, String url}),
                        ({String eventType, $event type})
                      >(() {
                        try {
                          return (() {
                            final _v7 = (_v6 as Map).cast<String, Object?>();
                            return (
                              cron: (_v7['cron'] as String),
                              type: $schedule.validate(_v7['type']),
                            );
                          })();
                        } catch (e) {}

                        try {
                          return (() {
                            final _v8 = (_v6 as Map).cast<String, Object?>();
                            return (
                              type: $webhook.validate(_v8['type']),
                              url: (_v8['url'] as String),
                            );
                          })();
                        } catch (e) {}

                        try {
                          return (() {
                            final _v9 = (_v6 as Map).cast<String, Object?>();
                            return (
                              eventType: (_v9['eventType'] as String),
                              type: $event.validate(_v9['type']),
                            );
                          })();
                        } catch (e) {}

                        throw Exception(
                          (_v6.toString()) +
                              r" cannot be deserialized into a Union3<({String cron,$schedule type}), ({$webhook type,String url}), ({String eventType,$event type})>",
                        );
                      }()),
                )
                .toList(growable: false),
            variables: (_v1['variables'] as Map).cast<String, Object?>().map(
              (_v10, _v11) => MapEntry(
                _v10,
                Union4<String, double, bool, List<Object?>>(() {
                  try {
                    return (_v11 as String);
                  } catch (e) {}

                  try {
                    return (_v11 as num).toDouble();
                  } catch (e) {}

                  try {
                    return (_v11 as bool);
                  } catch (e) {}

                  try {
                    return (_v11 as List)
                        .map<Object?>((_v12) => _v12)
                        .toList(growable: false);
                  } catch (e) {}

                  throw Exception(
                    (_v11.toString()) +
                        r" cannot be deserialized into a Union4<String, double, bool, List<Object?>>",
                  );
                }()),
              ),
            ),
          );
        })(),
      );
    })();
  }

  @override
  Query131Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (() {
          final _v1 = (_v0['i'] as Map).cast<String, Object?>();
          return (
            steps: (_v1['steps'] as List)
                .map<
                  ({
                    Optional<
                      ({String handler, ({double count, double delay}) retry})
                    >
                    error,
                    $action$condition$loop type,
                  })
                >(
                  (_v2) => (() {
                    final _v3 = (_v2 as Map).cast<String, Object?>();
                    return (
                      error: _v3.containsKey('error')
                          ? Defined<
                              ({
                                String handler,
                                ({double count, double delay}) retry,
                              })
                            >(
                              (() {
                                final _v4 = (_v3['error'] as Map)
                                    .cast<String, Object?>();
                                return (
                                  handler: (_v4['handler'] as String),
                                  retry: (() {
                                    final _v5 = (_v4['retry'] as Map)
                                        .cast<String, Object?>();
                                    return (
                                      count: (_v5['count'] as num).toDouble(),
                                      delay: (_v5['delay'] as num).toDouble(),
                                    );
                                  })(),
                                );
                              })(),
                            )
                          : Undefined<
                              ({
                                String handler,
                                ({double count, double delay}) retry,
                              })
                            >(),
                      type: $action$condition$loop.fromValue(
                        _v3['type'] as Object,
                      ),
                    );
                  })(),
                )
                .toList(growable: false),
            triggers: (_v1['triggers'] as List)
                .map<
                  Union3<
                    ({String cron, $schedule type}),
                    ({$webhook type, String url}),
                    ({String eventType, $event type})
                  >
                >(
                  (_v6) =>
                      Union3<
                        ({String cron, $schedule type}),
                        ({$webhook type, String url}),
                        ({String eventType, $event type})
                      >(() {
                        try {
                          return (() {
                            final _v7 = (_v6 as Map).cast<String, Object?>();
                            return (
                              cron: (_v7['cron'] as String),
                              type: $schedule.validate(_v7['type']),
                            );
                          })();
                        } catch (e) {}

                        try {
                          return (() {
                            final _v8 = (_v6 as Map).cast<String, Object?>();
                            return (
                              type: $webhook.validate(_v8['type']),
                              url: (_v8['url'] as String),
                            );
                          })();
                        } catch (e) {}

                        try {
                          return (() {
                            final _v9 = (_v6 as Map).cast<String, Object?>();
                            return (
                              eventType: (_v9['eventType'] as String),
                              type: $event.validate(_v9['type']),
                            );
                          })();
                        } catch (e) {}

                        throw Exception(
                          (_v6.toString()) +
                              r" cannot be deserialized into a Union3<({String cron,$schedule type}), ({$webhook type,String url}), ({String eventType,$event type})>",
                        );
                      }()),
                )
                .toList(growable: false),
            variables: (_v1['variables'] as Map).cast<String, Object?>().map(
              (_v10, _v11) => MapEntry(
                _v10,
                Union4<String, double, bool, List<Object?>>(() {
                  try {
                    return (_v11 as String);
                  } catch (e) {}

                  try {
                    return (_v11 as num).toDouble();
                  } catch (e) {}

                  try {
                    return (_v11 as bool);
                  } catch (e) {}

                  try {
                    return (_v11 as List)
                        .map<Object?>((_v12) => _v12)
                        .toList(growable: false);
                  } catch (e) {}

                  throw Exception(
                    (_v11.toString()) +
                        r" cannot be deserialized into a Union4<String, double, bool, List<Object?>>",
                  );
                }()),
              ),
            ),
          );
        })(),
      );
    })();
  }
}

final query132 = Query132();

class Query132 extends ConvexQuery<Query132Args, Query132Return> {
  Query132() : super("generic_functions:query132");

  @override
  Map<String, Object?> parseArgs(Query132Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': (() {
          final _v1 = _v0.i;
          return {
            'a': _v1.a
                .map<Object?>(
                  (_v2) => (() {
                    final _v3 = _v2;
                    return {'b': _v3.b};
                  })(),
                )
                .toList(growable: false),
          };
        })(),
      };
    })();
  }

  @override
  Query132Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (() {
          final _v1 = (_v0['i'] as Map).cast<String, Object?>();
          return (
            a: (_v1['a'] as List)
                .map<({String b})>(
                  (_v2) => (() {
                    final _v3 = (_v2 as Map).cast<String, Object?>();
                    return (b: (_v3['b'] as String));
                  })(),
                )
                .toList(growable: false),
          );
        })(),
      );
    })();
  }

  @override
  Query132Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (() {
          final _v1 = (_v0['i'] as Map).cast<String, Object?>();
          return (
            a: (_v1['a'] as List)
                .map<({String b})>(
                  (_v2) => (() {
                    final _v3 = (_v2 as Map).cast<String, Object?>();
                    return (b: (_v3['b'] as String));
                  })(),
                )
                .toList(growable: false),
          );
        })(),
      );
    })();
  }
}

final query133 = Query133();

class Query133 extends ConvexQuery<Query133Args, Query133Return> {
  Query133() : super("generic_functions:query133");

  @override
  Map<String, Object?> parseArgs(Query133Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': (() {
          final _v1 = _v0.i;
          return {
            if (_v1.a.isDefined)
              'a': {
                for (final _v2 in _v1.a.asDefined().value.entries)
                  _v2.key: _v2.value,
              },
          };
        })(),
      };
    })();
  }

  @override
  Query133Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (() {
          final _v1 = (_v0['i'] as Map).cast<String, Object?>();
          return (
            a: _v1.containsKey('a')
                ? Defined<Map<String, double>>(
                    (_v1['a'] as Map).cast<String, Object?>().map(
                      (_v2, _v3) => MapEntry(_v2, (_v3 as num).toDouble()),
                    ),
                  )
                : Undefined<Map<String, double>>(),
          );
        })(),
      );
    })();
  }

  @override
  Query133Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (() {
          final _v1 = (_v0['i'] as Map).cast<String, Object?>();
          return (
            a: _v1.containsKey('a')
                ? Defined<Map<String, double>>(
                    (_v1['a'] as Map).cast<String, Object?>().map(
                      (_v2, _v3) => MapEntry(_v2, (_v3 as num).toDouble()),
                    ),
                  )
                : Undefined<Map<String, double>>(),
          );
        })(),
      );
    })();
  }
}

final query134 = Query134();

class Query134 extends ConvexQuery<Query134Args, Query134Return> {
  Query134() : super("generic_functions:query134");

  @override
  Map<String, Object?> parseArgs(Query134Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': (() {
          final _v1 = _v0.i;
          return {
            'a': _v1.a.split(
              (_v2) => _v2,
              (_v3) => _v3.map<Object?>((_v4) => _v4).toList(growable: false),
            ),
          };
        })(),
      };
    })();
  }

  @override
  Query134Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (() {
          final _v1 = (_v0['i'] as Map).cast<String, Object?>();
          return (
            a: Union2<String, List<bool>>(() {
              try {
                return (_v1['a'] as String);
              } catch (e) {}

              try {
                return (_v1['a'] as List)
                    .map<bool>((_v2) => (_v2 as bool))
                    .toList(growable: false);
              } catch (e) {}

              throw Exception(
                (_v1['a'].toString()) +
                    r" cannot be deserialized into a Union2<String, List<bool>>",
              );
            }()),
          );
        })(),
      );
    })();
  }

  @override
  Query134Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (() {
          final _v1 = (_v0['i'] as Map).cast<String, Object?>();
          return (
            a: Union2<String, List<bool>>(() {
              try {
                return (_v1['a'] as String);
              } catch (e) {}

              try {
                return (_v1['a'] as List)
                    .map<bool>((_v2) => (_v2 as bool))
                    .toList(growable: false);
              } catch (e) {}

              throw Exception(
                (_v1['a'].toString()) +
                    r" cannot be deserialized into a Union2<String, List<bool>>",
              );
            }()),
          );
        })(),
      );
    })();
  }
}

final query135 = Query135();

class Query135 extends ConvexQuery<Query135Args, Query135Return> {
  Query135() : super("generic_functions:query135");

  @override
  Map<String, Object?> parseArgs(Query135Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': _v0.i
            .map<Object?>(
              (_v1) => (() {
                final _v2 = _v1;
                return {
                  'a': _v2.a,
                  if (_v2.b.isDefined) 'b': _v2.b.asDefined().value,
                };
              })(),
            )
            .toList(growable: false),
      };
    })();
  }

  @override
  Query135Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as List)
            .map<({String a, Optional<double> b})>(
              (_v1) => (() {
                final _v2 = (_v1 as Map).cast<String, Object?>();
                return (
                  a: (_v2['a'] as String),
                  b: _v2.containsKey('b')
                      ? Defined<double>((_v2['b'] as num).toDouble())
                      : Undefined<double>(),
                );
              })(),
            )
            .toList(growable: false),
      );
    })();
  }

  @override
  Query135Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as List)
            .map<({String a, Optional<double> b})>(
              (_v1) => (() {
                final _v2 = (_v1 as Map).cast<String, Object?>();
                return (
                  a: (_v2['a'] as String),
                  b: _v2.containsKey('b')
                      ? Defined<double>((_v2['b'] as num).toDouble())
                      : Undefined<double>(),
                );
              })(),
            )
            .toList(growable: false),
      );
    })();
  }
}

final query137 = Query137();

class Query137 extends ConvexQuery<Query137Args, Query137Return> {
  Query137() : super("generic_functions:query137");

  @override
  Map<String, Object?> parseArgs(Query137Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': _v0.i.split(
          (_v1) => (() {
            final _v2 = _v1;
            return {'a': _v2.a, 'type': _v2.type.value};
          })(),
          (_v3) => (() {
            final _v4 = _v3;
            return {'b': _v4.b, 'type': _v4.type.value};
          })(),
        ),
      };
    })();
  }

  @override
  Query137Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: Union2<({String a, $A type}), ({double b, $B type})>(() {
          try {
            return (() {
              final _v1 = (_v0['i'] as Map).cast<String, Object?>();
              return (a: (_v1['a'] as String), type: $A.validate(_v1['type']));
            })();
          } catch (e) {}

          try {
            return (() {
              final _v2 = (_v0['i'] as Map).cast<String, Object?>();
              return (
                b: (_v2['b'] as num).toDouble(),
                type: $B.validate(_v2['type']),
              );
            })();
          } catch (e) {}

          throw Exception(
            (_v0['i'].toString()) +
                r" cannot be deserialized into a Union2<({String a,$A type}), ({double b,$B type})>",
          );
        }()),
      );
    })();
  }

  @override
  Query137Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: Union2<({String a, $A type}), ({double b, $B type})>(() {
          try {
            return (() {
              final _v1 = (_v0['i'] as Map).cast<String, Object?>();
              return (a: (_v1['a'] as String), type: $A.validate(_v1['type']));
            })();
          } catch (e) {}

          try {
            return (() {
              final _v2 = (_v0['i'] as Map).cast<String, Object?>();
              return (
                b: (_v2['b'] as num).toDouble(),
                type: $B.validate(_v2['type']),
              );
            })();
          } catch (e) {}

          throw Exception(
            (_v0['i'].toString()) +
                r" cannot be deserialized into a Union2<({String a,$A type}), ({double b,$B type})>",
          );
        }()),
      );
    })();
  }
}

final query138 = Query138();

class Query138 extends ConvexQuery<Query138Args, Query138Return> {
  Query138() : super("generic_functions:query138");

  @override
  Map<String, Object?> parseArgs(Query138Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': _v0.i.split(
          (_v1) => _v1.map<Object?>((_v2) => _v2).toList(growable: false),
          (_v3) => {for (final _v4 in _v3.entries) _v4.key: _v4.value},
        ),
      };
    })();
  }

  @override
  Query138Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: Union2<List<String>, Map<String, double>>(() {
          try {
            return (_v0['i'] as List)
                .map<String>((_v1) => (_v1 as String))
                .toList(growable: false);
          } catch (e) {}

          try {
            return (_v0['i'] as Map).cast<String, Object?>().map(
              (_v2, _v3) => MapEntry(_v2, (_v3 as num).toDouble()),
            );
          } catch (e) {}

          throw Exception(
            (_v0['i'].toString()) +
                r" cannot be deserialized into a Union2<List<String>, Map<String, double>>",
          );
        }()),
      );
    })();
  }

  @override
  Query138Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: Union2<List<String>, Map<String, double>>(() {
          try {
            return (_v0['i'] as List)
                .map<String>((_v1) => (_v1 as String))
                .toList(growable: false);
          } catch (e) {}

          try {
            return (_v0['i'] as Map).cast<String, Object?>().map(
              (_v2, _v3) => MapEntry(_v2, (_v3 as num).toDouble()),
            );
          } catch (e) {}

          throw Exception(
            (_v0['i'].toString()) +
                r" cannot be deserialized into a Union2<List<String>, Map<String, double>>",
          );
        }()),
      );
    })();
  }
}

final query139 = Query139();

class Query139 extends ConvexQuery<Query139Args, Query139Return> {
  Query139() : super("generic_functions:query139");

  @override
  Map<String, Object?> parseArgs(Query139Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': {
          for (final _v1 in _v0.i.entries)
            _v1.key: (() {
              final _v2 = _v1.value;
              return {
                'a': _v2.a.map<Object?>((_v3) => _v3).toList(growable: false),
              };
            })(),
        },
      };
    })();
  }

  @override
  Query139Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as Map).cast<String, Object?>().map(
          (_v1, _v2) => MapEntry(
            _v1,
            (() {
              final _v3 = (_v2 as Map).cast<String, Object?>();
              return (
                a: (_v3['a'] as List)
                    .map<Object?>((_v4) => _v4)
                    .toList(growable: false),
              );
            })(),
          ),
        ),
      );
    })();
  }

  @override
  Query139Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as Map).cast<String, Object?>().map(
          (_v1, _v2) => MapEntry(
            _v1,
            (() {
              final _v3 = (_v2 as Map).cast<String, Object?>();
              return (
                a: (_v3['a'] as List)
                    .map<Object?>((_v4) => _v4)
                    .toList(growable: false),
              );
            })(),
          ),
        ),
      );
    })();
  }
}

final query141 = Query141();

class Query141 extends ConvexQuery<Query141Args, Query141Return> {
  Query141() : super("generic_functions:query141");

  @override
  Map<String, Object?> parseArgs(Query141Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': (() {
          final _v1 = _v0.i;
          return {
            'a': (() {
              final _v2 = _v1.a;
              return {
                'b': (() {
                  final _v3 = _v2.b;
                  return {
                    'c': _v3.c
                        .map<Object?>(
                          (_v4) => (() {
                            final _v5 = _v4;
                            return {'d': _v5.d};
                          })(),
                        )
                        .toList(growable: false),
                  };
                })(),
              };
            })(),
          };
        })(),
      };
    })();
  }

  @override
  Query141Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (() {
          final _v1 = (_v0['i'] as Map).cast<String, Object?>();
          return (
            a: (() {
              final _v2 = (_v1['a'] as Map).cast<String, Object?>();
              return (
                b: (() {
                  final _v3 = (_v2['b'] as Map).cast<String, Object?>();
                  return (
                    c: (_v3['c'] as List)
                        .map<({String d})>(
                          (_v4) => (() {
                            final _v5 = (_v4 as Map).cast<String, Object?>();
                            return (d: (_v5['d'] as String));
                          })(),
                        )
                        .toList(growable: false),
                  );
                })(),
              );
            })(),
          );
        })(),
      );
    })();
  }

  @override
  Query141Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (() {
          final _v1 = (_v0['i'] as Map).cast<String, Object?>();
          return (
            a: (() {
              final _v2 = (_v1['a'] as Map).cast<String, Object?>();
              return (
                b: (() {
                  final _v3 = (_v2['b'] as Map).cast<String, Object?>();
                  return (
                    c: (_v3['c'] as List)
                        .map<({String d})>(
                          (_v4) => (() {
                            final _v5 = (_v4 as Map).cast<String, Object?>();
                            return (d: (_v5['d'] as String));
                          })(),
                        )
                        .toList(growable: false),
                  );
                })(),
              );
            })(),
          );
        })(),
      );
    })();
  }
}

final query144 = Query144();

class Query144 extends ConvexQuery<Query144Args, Query144Return> {
  Query144() : super("generic_functions:query144");

  @override
  Map<String, Object?> parseArgs(Query144Args args) {
    return (() {
      final _v0 = args;
      return {'arg1': _v0.arg1, 'arg2': _v0.arg2, 'arg3': _v0.arg3};
    })();
  }

  @override
  Query144Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        arg1: (_v0['arg1'] as String),
        arg2: (_v0['arg2'] as num).toDouble(),
        arg3: (_v0['arg3'] as bool),
      );
    })();
  }

  @override
  Query144Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        arg1: (_v0['arg1'] as String),
        arg2: (_v0['arg2'] as num).toDouble(),
        arg3: (_v0['arg3'] as bool),
      );
    })();
  }
}

final query146 = Query146();

class Query146 extends ConvexQuery<Query146Args, Query146Return> {
  Query146() : super("generic_functions:query146");

  @override
  Map<String, Object?> parseArgs(Query146Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': (() {
          final _v1 = _v0.i;
          return {
            'data': _v1.data,
            if (_v1.metadata.isDefined)
              'metadata': _v1.metadata.asDefined().value,
          };
        })(),
      };
    })();
  }

  @override
  Query146Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (() {
          final _v1 = (_v0['i'] as Map).cast<String, Object?>();
          return (
            data: (_v1['data'] as Uint8List),
            metadata: _v1.containsKey('metadata')
                ? Defined<Object?>(_v1['metadata'])
                : Undefined<Object?>(),
          );
        })(),
      );
    })();
  }

  @override
  Query146Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (() {
          final _v1 = (_v0['i'] as Map).cast<String, Object?>();
          return (
            data: (_v1['data'] as Uint8List),
            metadata: _v1.containsKey('metadata')
                ? Defined<Object?>(_v1['metadata'])
                : Undefined<Object?>(),
          );
        })(),
      );
    })();
  }
}

final query148 = Query148();

class Query148 extends ConvexQuery<Query148Args, Query148Return> {
  Query148() : super("generic_functions:query148");

  @override
  Map<String, Object?> parseArgs(Query148Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': {
          for (final _v1 in _v0.i.entries)
            _v1.key: _v1.value
                .map<Object?>((_v2) => _v2.name)
                .toList(growable: false),
        },
      };
    })();
  }

  @override
  Query148Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as Map).cast<String, Object?>().map(
          (_v1, _v2) => MapEntry(
            _v1,
            (_v2 as List)
                .map<ItemsId>((_v3) => ItemsId(_v3 as String))
                .toList(growable: false),
          ),
        ),
      );
    })();
  }

  @override
  Query148Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as Map).cast<String, Object?>().map(
          (_v1, _v2) => MapEntry(
            _v1,
            (_v2 as List)
                .map<ItemsId>((_v3) => ItemsId(_v3 as String))
                .toList(growable: false),
          ),
        ),
      );
    })();
  }
}

final query149 = Query149();

class Query149 extends ConvexQuery<Query149Args, Query149Return> {
  Query149() : super("generic_functions:query149");

  @override
  Map<String, Object?> parseArgs(Query149Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': (() {
          final _v1 = _v0.i;
          return {'a': _v1.a.value, 'b': _v1.b.value, 'c': _v1.c.value};
        })(),
      };
    })();
  }

  @override
  Query149Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (() {
          final _v1 = (_v0['i'] as Map).cast<String, Object?>();
          return (
            a: $foo.validate(_v1['a']),
            b: $123_0.validate(_v1['b']),
            c: $false.validate(_v1['c']),
          );
        })(),
      );
    })();
  }

  @override
  Query149Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (() {
          final _v1 = (_v0['i'] as Map).cast<String, Object?>();
          return (
            a: $foo.validate(_v1['a']),
            b: $123_0.validate(_v1['b']),
            c: $false.validate(_v1['c']),
          );
        })(),
      );
    })();
  }
}

final query150 = Query150();

class Query150 extends ConvexQuery<Query150Args, Query150Return> {
  Query150() : super("generic_functions:query150");

  @override
  Map<String, Object?> parseArgs(Query150Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': _v0.i
            .map<Object?>(
              (_v1) => _v1.split((_v2) => _v2, (_v3) => _v3, (_v4) => _v4),
            )
            .toList(growable: false),
      };
    })();
  }

  @override
  Query150Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as List)
            .map<Union3<String, double, bool>>(
              (_v1) => Union3<String, double, bool>(() {
                try {
                  return (_v1 as String);
                } catch (e) {}

                try {
                  return (_v1 as num).toDouble();
                } catch (e) {}

                try {
                  return (_v1 as bool);
                } catch (e) {}

                throw Exception(
                  (_v1.toString()) +
                      r" cannot be deserialized into a Union3<String, double, bool>",
                );
              }()),
            )
            .toList(growable: false),
      );
    })();
  }

  @override
  Query150Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as List)
            .map<Union3<String, double, bool>>(
              (_v1) => Union3<String, double, bool>(() {
                try {
                  return (_v1 as String);
                } catch (e) {}

                try {
                  return (_v1 as num).toDouble();
                } catch (e) {}

                try {
                  return (_v1 as bool);
                } catch (e) {}

                throw Exception(
                  (_v1.toString()) +
                      r" cannot be deserialized into a Union3<String, double, bool>",
                );
              }()),
            )
            .toList(growable: false),
      );
    })();
  }
}

final query151 = Query151();

class Query151 extends ConvexQuery<Query151Args, Query151Return> {
  Query151() : super("generic_functions:query151");

  @override
  Map<String, Object?> parseArgs(Query151Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': (() {
          final _v1 = _v0.i;
          return {
            'a': _v1.a.map<Object?>((_v2) => _v2).toList(growable: false),
          };
        })(),
      };
    })();
  }

  @override
  Query151Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (() {
          final _v1 = (_v0['i'] as Map).cast<String, Object?>();
          return (
            a: (_v1['a'] as List)
                .map<BigInt>((_v2) => (_v2 as BigInt))
                .toList(growable: false),
          );
        })(),
      );
    })();
  }

  @override
  Query151Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (() {
          final _v1 = (_v0['i'] as Map).cast<String, Object?>();
          return (
            a: (_v1['a'] as List)
                .map<BigInt>((_v2) => (_v2 as BigInt))
                .toList(growable: false),
          );
        })(),
      );
    })();
  }
}

final query152 = Query152();

class Query152 extends ConvexQuery<Query152Args, Query152Return> {
  Query152() : super("generic_functions:query152");

  @override
  Map<String, Object?> parseArgs(Query152Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': {for (final _v1 in _v0.i.entries) _v1.key: _v1.value},
      };
    })();
  }

  @override
  Query152Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as Map).cast<String, Object?>().map(
          (_v1, _v2) => MapEntry(_v1, (_v2 as bool)),
        ),
      );
    })();
  }

  @override
  Query152Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as Map).cast<String, Object?>().map(
          (_v1, _v2) => MapEntry(_v1, (_v2 as bool)),
        ),
      );
    })();
  }
}

final query153 = Query153();

class Query153 extends ConvexQuery<Query153Args, Query153Return> {
  Query153() : super("generic_functions:query153");

  @override
  Map<String, Object?> parseArgs(Query153Args args) {
    return (() {
      final _v0 = args;
      return {'i': _v0.i.split((_v1) => _v1, (_v2) => _v2)};
    })();
  }

  @override
  Query153Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: Union2<Uint8List, String>(() {
          try {
            return (_v0['i'] as Uint8List);
          } catch (e) {}

          try {
            return (_v0['i'] as String);
          } catch (e) {}

          throw Exception(
            (_v0['i'].toString()) +
                r" cannot be deserialized into a Union2<Uint8List, String>",
          );
        }()),
      );
    })();
  }

  @override
  Query153Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: Union2<Uint8List, String>(() {
          try {
            return (_v0['i'] as Uint8List);
          } catch (e) {}

          try {
            return (_v0['i'] as String);
          } catch (e) {}

          throw Exception(
            (_v0['i'].toString()) +
                r" cannot be deserialized into a Union2<Uint8List, String>",
          );
        }()),
      );
    })();
  }
}

final query154 = Query154();

class Query154 extends ConvexQuery<Query154Args, Query154Return> {
  Query154() : super("generic_functions:query154");

  @override
  Map<String, Object?> parseArgs(Query154Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': _v0.i.map<Object?>((_v1) => _v1.value).toList(growable: false),
      };
    })();
  }

  @override
  Query154Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as List)
            .map<$a>((_v1) => $a.validate(_v1))
            .toList(growable: false),
      );
    })();
  }

  @override
  Query154Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as List)
            .map<$a>((_v1) => $a.validate(_v1))
            .toList(growable: false),
      );
    })();
  }
}

final query155 = Query155();

class Query155 extends ConvexQuery<Query155Args, Query155Return> {
  Query155() : super("generic_functions:query155");

  @override
  Map<String, Object?> parseArgs(Query155Args args) {
    return (() {
      final _v0 = args;
      return {if (_v0.i.isDefined) 'i': _v0.i.asDefined().value.name};
    })();
  }

  @override
  Query155Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: _v0.containsKey('i')
            ? Defined<UsersId>(UsersId(_v0['i'] as String))
            : Undefined<UsersId>(),
      );
    })();
  }

  @override
  Query155Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: _v0.containsKey('i')
            ? Defined<UsersId>(UsersId(_v0['i'] as String))
            : Undefined<UsersId>(),
      );
    })();
  }
}

final query156 = Query156();

class Query156 extends ConvexQuery<Query156Args, Query156Return> {
  Query156() : super("generic_functions:query156");

  @override
  Map<String, Object?> parseArgs(Query156Args args) {
    return (() {
      final _v0 = args;
      return {'i': _v0.i};
    })();
  }

  @override
  Query156Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (i: _v0['i']);
    })();
  }

  @override
  Query156Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (i: _v0['i']);
    })();
  }
}

final query157 = Query157();

class Query157 extends ConvexQuery<Query157Args, Query157Return> {
  Query157() : super("generic_functions:query157");

  @override
  Map<String, Object?> parseArgs(Query157Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': {for (final _v1 in _v0.i.entries) _v1.key: _v1.value},
      };
    })();
  }

  @override
  Query157Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as Map).cast<String, Object?>().map(
          (_v1, _v2) => MapEntry(_v1, _v2),
        ),
      );
    })();
  }

  @override
  Query157Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as Map).cast<String, Object?>().map(
          (_v1, _v2) => MapEntry(_v1, _v2),
        ),
      );
    })();
  }
}

final query158 = Query158();

class Query158 extends ConvexQuery<Query158Args, Query158Return> {
  Query158() : super("generic_functions:query158");

  @override
  Map<String, Object?> parseArgs(Query158Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': (() {
          final _v1 = _v0.i;
          return {'a': _v1.a, 'b': _v1.b};
        })(),
      };
    })();
  }

  @override
  Query158Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (() {
          final _v1 = (_v0['i'] as Map).cast<String, Object?>();
          return (a: (_v1['a'] as String), b: (_v1['b'] as num).toDouble());
        })(),
      );
    })();
  }

  @override
  Query158Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (() {
          final _v1 = (_v0['i'] as Map).cast<String, Object?>();
          return (a: (_v1['a'] as String), b: (_v1['b'] as num).toDouble());
        })(),
      );
    })();
  }
}

final query159 = Query159();

class Query159 extends ConvexQuery<Query159Args, Query159Return> {
  Query159() : super("generic_functions:query159");

  @override
  Map<String, Object?> parseArgs(Query159Args args) {
    return (() {
      final _v0 = args;
      return {'i': _v0.i.value.value};
    })();
  }

  @override
  Query159Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (i: $10$20.fromValue(_v0['i'] as Object));
    })();
  }

  @override
  Query159Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (i: $10$20.fromValue(_v0['i'] as Object));
    })();
  }
}

final query161 = Query161();

class Query161 extends ConvexQuery<Query161Args, Query161Return> {
  Query161() : super("generic_functions:query161");

  @override
  Map<String, Object?> parseArgs(Query161Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': (() {
          final _v1 = _v0.i;
          return {if (_v1.a.isDefined) 'a': _v1.a.asDefined().value};
        })(),
      };
    })();
  }

  @override
  Query161Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (() {
          final _v1 = (_v0['i'] as Map).cast<String, Object?>();
          return (
            a: _v1.containsKey('a')
                ? Defined<String>((_v1['a'] as String))
                : Undefined<String>(),
          );
        })(),
      );
    })();
  }

  @override
  Query161Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (() {
          final _v1 = (_v0['i'] as Map).cast<String, Object?>();
          return (
            a: _v1.containsKey('a')
                ? Defined<String>((_v1['a'] as String))
                : Undefined<String>(),
          );
        })(),
      );
    })();
  }
}

final query163 = Query163();

class Query163 extends ConvexQuery<Query163Args, Query163Return> {
  Query163() : super("generic_functions:query163");

  @override
  Map<String, Object?> parseArgs(Query163Args args) {
    return (() {
      final _v0 = args;
      return {'i': _v0.i.split((_v1) => _v1.name, (_v2) => _v2.name)};
    })();
  }

  @override
  Query163Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: Union2<AId, BId>(() {
          try {
            return AId(_v0['i'] as String);
          } catch (e) {}

          try {
            return BId(_v0['i'] as String);
          } catch (e) {}

          throw Exception(
            (_v0['i'].toString()) +
                r" cannot be deserialized into a Union2<AId, BId>",
          );
        }()),
      );
    })();
  }

  @override
  Query163Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: Union2<AId, BId>(() {
          try {
            return AId(_v0['i'] as String);
          } catch (e) {}

          try {
            return BId(_v0['i'] as String);
          } catch (e) {}

          throw Exception(
            (_v0['i'].toString()) +
                r" cannot be deserialized into a Union2<AId, BId>",
          );
        }()),
      );
    })();
  }
}

final query164 = Query164();

class Query164 extends ConvexQuery<Query164Args, Query164Return> {
  Query164() : super("generic_functions:query164");

  @override
  Map<String, Object?> parseArgs(Query164Args args) {
    return (() {
      final _v0 = args;
      return {'i': _v0.i.map<Object?>((_v1) => _v1).toList(growable: false)};
    })();
  }

  @override
  Query164Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as List)
            .map<Uint8List>((_v1) => (_v1 as Uint8List))
            .toList(growable: false),
      );
    })();
  }

  @override
  Query164Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as List)
            .map<Uint8List>((_v1) => (_v1 as Uint8List))
            .toList(growable: false),
      );
    })();
  }
}

final query165 = Query165();

class Query165 extends ConvexQuery<Query165Args, Query165Return> {
  Query165() : super("generic_functions:query165");

  @override
  Map<String, Object?> parseArgs(Query165Args args) {
    return (() {
      final _v0 = args;
      return {if (_v0.i.isDefined) 'i': _v0.i.asDefined().value};
    })();
  }

  @override
  Query165Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: _v0.containsKey('i')
            ? Defined<Object?>(_v0['i'])
            : Undefined<Object?>(),
      );
    })();
  }

  @override
  Query165Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: _v0.containsKey('i')
            ? Defined<Object?>(_v0['i'])
            : Undefined<Object?>(),
      );
    })();
  }
}

final query166 = Query166();

class Query166 extends ConvexQuery<Query166Args, Query166Return> {
  Query166() : super("generic_functions:query166");

  @override
  Map<String, Object?> parseArgs(Query166Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': (() {
          final _v1 = _v0.i;
          return {
            'a': (() {
              final _v2 = _v1.a;
              return {'b': _v2.b};
            })(),
          };
        })(),
      };
    })();
  }

  @override
  Query166Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (() {
          final _v1 = (_v0['i'] as Map).cast<String, Object?>();
          return (
            a: (() {
              final _v2 = (_v1['a'] as Map).cast<String, Object?>();
              return (b: (_v2['b'] as bool));
            })(),
          );
        })(),
      );
    })();
  }

  @override
  Query166Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (() {
          final _v1 = (_v0['i'] as Map).cast<String, Object?>();
          return (
            a: (() {
              final _v2 = (_v1['a'] as Map).cast<String, Object?>();
              return (b: (_v2['b'] as bool));
            })(),
          );
        })(),
      );
    })();
  }
}

final query167 = Query167();

class Query167 extends ConvexQuery<Query167Args, Query167Return> {
  Query167() : super("generic_functions:query167");

  @override
  Map<String, Object?> parseArgs(Query167Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': {for (final _v1 in _v0.i.entries) _v1.key: _v1.value.name},
      };
    })();
  }

  @override
  Query167Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as Map).cast<String, Object?>().map(
          (_v1, _v2) => MapEntry(_v1, PostsId(_v2 as String)),
        ),
      );
    })();
  }

  @override
  Query167Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as Map).cast<String, Object?>().map(
          (_v1, _v2) => MapEntry(_v1, PostsId(_v2 as String)),
        ),
      );
    })();
  }
}

final query168 = Query168();

class Query168 extends ConvexQuery<Query168Args, Query168Return> {
  Query168() : super("generic_functions:query168");

  @override
  Map<String, Object?> parseArgs(Query168Args args) {
    return (() {
      final _v0 = args;
      return {'i': _v0.i};
    })();
  }

  @override
  Query168Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (i: _v0['i'] == null ? null : (_v0['i'] as String));
    })();
  }

  @override
  Query168Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (i: _v0['i'] == null ? null : (_v0['i'] as String));
    })();
  }
}

final query169 = Query169();

class Query169 extends ConvexQuery<Query169Args, Query169Return> {
  Query169() : super("generic_functions:query169");

  @override
  Map<String, Object?> parseArgs(Query169Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': _v0.i
            .map<Object?>(
              (_v1) => _v1.map<Object?>((_v2) => _v2).toList(growable: false),
            )
            .toList(growable: false),
      };
    })();
  }

  @override
  Query169Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as List)
            .map<List<String>>(
              (_v1) => (_v1 as List)
                  .map<String>((_v2) => (_v2 as String))
                  .toList(growable: false),
            )
            .toList(growable: false),
      );
    })();
  }

  @override
  Query169Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as List)
            .map<List<String>>(
              (_v1) => (_v1 as List)
                  .map<String>((_v2) => (_v2 as String))
                  .toList(growable: false),
            )
            .toList(growable: false),
      );
    })();
  }
}

final query170 = Query170();

class Query170 extends ConvexQuery<Query170Args, Query170Return> {
  Query170() : super("generic_functions:query170");

  @override
  Map<String, Object?> parseArgs(Query170Args args) {
    return (() {
      final _v0 = args;
      return {'i': _v0.i.value};
    })();
  }

  @override
  Query170Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (i: $helloworld.validate(_v0['i']));
    })();
  }

  @override
  Query170Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (i: $helloworld.validate(_v0['i']));
    })();
  }
}

final query171 = Query171();

class Query171 extends ConvexQuery<Query171Args, Query171Return> {
  Query171() : super("generic_functions:query171");

  @override
  Map<String, Object?> parseArgs(Query171Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': (() {
          final _v1 = _v0.i;
          return {
            'a': _v1.a,
            if (_v1.b.isDefined) 'b': _v1.b.asDefined().value,
            'c': _v1.c.map<Object?>((_v2) => _v2).toList(growable: false),
          };
        })(),
      };
    })();
  }

  @override
  Query171Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (() {
          final _v1 = (_v0['i'] as Map).cast<String, Object?>();
          return (
            a: (_v1['a'] as String),
            b: _v1.containsKey('b')
                ? Defined<double>((_v1['b'] as num).toDouble())
                : Undefined<double>(),
            c: (_v1['c'] as List)
                .map<bool>((_v2) => (_v2 as bool))
                .toList(growable: false),
          );
        })(),
      );
    })();
  }

  @override
  Query171Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (() {
          final _v1 = (_v0['i'] as Map).cast<String, Object?>();
          return (
            a: (_v1['a'] as String),
            b: _v1.containsKey('b')
                ? Defined<double>((_v1['b'] as num).toDouble())
                : Undefined<double>(),
            c: (_v1['c'] as List)
                .map<bool>((_v2) => (_v2 as bool))
                .toList(growable: false),
          );
        })(),
      );
    })();
  }
}

final query172 = Query172();

class Query172 extends ConvexQuery<Query172Args, Query172Return> {
  Query172() : super("generic_functions:query172");

  @override
  Map<String, Object?> parseArgs(Query172Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': {
          for (final _v1 in _v0.i.entries)
            _v1.key: _v1.value.split((_v2) => _v2, (_v3) => _v3),
        },
      };
    })();
  }

  @override
  Query172Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as Map).cast<String, Object?>().map(
          (_v1, _v2) => MapEntry(
            _v1,
            Union2<String, double>(() {
              try {
                return (_v2 as String);
              } catch (e) {}

              try {
                return (_v2 as num).toDouble();
              } catch (e) {}

              throw Exception(
                (_v2.toString()) +
                    r" cannot be deserialized into a Union2<String, double>",
              );
            }()),
          ),
        ),
      );
    })();
  }

  @override
  Query172Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as Map).cast<String, Object?>().map(
          (_v1, _v2) => MapEntry(
            _v1,
            Union2<String, double>(() {
              try {
                return (_v2 as String);
              } catch (e) {}

              try {
                return (_v2 as num).toDouble();
              } catch (e) {}

              throw Exception(
                (_v2.toString()) +
                    r" cannot be deserialized into a Union2<String, double>",
              );
            }()),
          ),
        ),
      );
    })();
  }
}

final query173 = Query173();

class Query173 extends ConvexQuery<Query173Args, Query173Return> {
  Query173() : super("generic_functions:query173");

  @override
  Map<String, Object?> parseArgs(Query173Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': _v0.i.split(
          (_v1) => (() {
            final _v2 = _v1;
            return {'type': _v2.type.value};
          })(),
          (_v3) => (() {
            final _v4 = _v3;
            return {'type': _v4.type.value};
          })(),
        ),
      };
    })();
  }

  @override
  Query173Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: Union2<({$A type}), ({$B type})>(() {
          try {
            return (() {
              final _v1 = (_v0['i'] as Map).cast<String, Object?>();
              return (type: $A.validate(_v1['type']));
            })();
          } catch (e) {}

          try {
            return (() {
              final _v2 = (_v0['i'] as Map).cast<String, Object?>();
              return (type: $B.validate(_v2['type']));
            })();
          } catch (e) {}

          throw Exception(
            (_v0['i'].toString()) +
                r" cannot be deserialized into a Union2<({$A type}), ({$B type})>",
          );
        }()),
      );
    })();
  }

  @override
  Query173Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: Union2<({$A type}), ({$B type})>(() {
          try {
            return (() {
              final _v1 = (_v0['i'] as Map).cast<String, Object?>();
              return (type: $A.validate(_v1['type']));
            })();
          } catch (e) {}

          try {
            return (() {
              final _v2 = (_v0['i'] as Map).cast<String, Object?>();
              return (type: $B.validate(_v2['type']));
            })();
          } catch (e) {}

          throw Exception(
            (_v0['i'].toString()) +
                r" cannot be deserialized into a Union2<({$A type}), ({$B type})>",
          );
        }()),
      );
    })();
  }
}

final query174 = Query174();

class Query174 extends ConvexQuery<Query174Args, Query174Return> {
  Query174() : super("generic_functions:query174");

  @override
  Map<String, Object?> parseArgs(Query174Args args) {
    return (() {
      final _v0 = args;
      return {'i': _v0.i.map<Object?>((_v1) => _v1).toList(growable: false)};
    })();
  }

  @override
  Query174Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as List)
            .map<Object?>((_v1) => _v1)
            .toList(growable: false),
      );
    })();
  }

  @override
  Query174Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as List)
            .map<Object?>((_v1) => _v1)
            .toList(growable: false),
      );
    })();
  }
}

final query175 = Query175();

class Query175 extends ConvexQuery<Query175Args, Query175Return> {
  Query175() : super("generic_functions:query175");

  @override
  Map<String, Object?> parseArgs(Query175Args args) {
    return (() {
      final _v0 = args;
      return {if (_v0.i.isDefined) 'i': _v0.i.asDefined().value};
    })();
  }

  @override
  Query175Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: _v0.containsKey('i')
            ? Defined<Uint8List>((_v0['i'] as Uint8List))
            : Undefined<Uint8List>(),
      );
    })();
  }

  @override
  Query175Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: _v0.containsKey('i')
            ? Defined<Uint8List>((_v0['i'] as Uint8List))
            : Undefined<Uint8List>(),
      );
    })();
  }
}

final query176 = Query176();

class Query176 extends ConvexQuery<Query176Args, Query176Return> {
  Query176() : super("generic_functions:query176");

  @override
  Map<String, Object?> parseArgs(Query176Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': (() {
          final _v1 = _v0.i;
          return {
            'metadata': {
              for (final _v2 in _v1.metadata.entries)
                _v2.key: (() {
                  final _v3 = _v2.value;
                  return {'lastUpdated': _v3.lastUpdated};
                })(),
            },
          };
        })(),
      };
    })();
  }

  @override
  Query176Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (() {
          final _v1 = (_v0['i'] as Map).cast<String, Object?>();
          return (
            metadata: (_v1['metadata'] as Map).cast<String, Object?>().map(
              (_v2, _v3) => MapEntry(
                _v2,
                (() {
                  final _v4 = (_v3 as Map).cast<String, Object?>();
                  return (lastUpdated: (_v4['lastUpdated'] as num).toDouble());
                })(),
              ),
            ),
          );
        })(),
      );
    })();
  }

  @override
  Query176Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (() {
          final _v1 = (_v0['i'] as Map).cast<String, Object?>();
          return (
            metadata: (_v1['metadata'] as Map).cast<String, Object?>().map(
              (_v2, _v3) => MapEntry(
                _v2,
                (() {
                  final _v4 = (_v3 as Map).cast<String, Object?>();
                  return (lastUpdated: (_v4['lastUpdated'] as num).toDouble());
                })(),
              ),
            ),
          );
        })(),
      );
    })();
  }
}

final query177 = Query177();

class Query177 extends ConvexQuery<Query177Args, Query177Return> {
  Query177() : super("generic_functions:query177");

  @override
  Map<String, Object?> parseArgs(Query177Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': {for (final _v1 in _v0.i.entries) _v1.key: _v1.value},
      };
    })();
  }

  @override
  Query177Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as Map).cast<String, Object?>().map(
          (_v1, _v2) => MapEntry(_v1, (_v2 as BigInt)),
        ),
      );
    })();
  }

  @override
  Query177Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as Map).cast<String, Object?>().map(
          (_v1, _v2) => MapEntry(_v1, (_v2 as BigInt)),
        ),
      );
    })();
  }
}

final query178 = Query178();

class Query178 extends ConvexQuery<Query178Args, Query178Return> {
  Query178() : super("generic_functions:query178");

  @override
  Map<String, Object?> parseArgs(Query178Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': _v0.i.split(
          (_v1) => _v1.map<Object?>((_v2) => _v2).toList(growable: false),
          (_v3) => _v3.map<Object?>((_v4) => _v4).toList(growable: false),
        ),
      };
    })();
  }

  @override
  Query178Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: Union2<List<String>, List<double>>(() {
          try {
            return (_v0['i'] as List)
                .map<String>((_v1) => (_v1 as String))
                .toList(growable: false);
          } catch (e) {}

          try {
            return (_v0['i'] as List)
                .map<double>((_v2) => (_v2 as num).toDouble())
                .toList(growable: false);
          } catch (e) {}

          throw Exception(
            (_v0['i'].toString()) +
                r" cannot be deserialized into a Union2<List<String>, List<double>>",
          );
        }()),
      );
    })();
  }

  @override
  Query178Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: Union2<List<String>, List<double>>(() {
          try {
            return (_v0['i'] as List)
                .map<String>((_v1) => (_v1 as String))
                .toList(growable: false);
          } catch (e) {}

          try {
            return (_v0['i'] as List)
                .map<double>((_v2) => (_v2 as num).toDouble())
                .toList(growable: false);
          } catch (e) {}

          throw Exception(
            (_v0['i'].toString()) +
                r" cannot be deserialized into a Union2<List<String>, List<double>>",
          );
        }()),
      );
    })();
  }
}

final query179 = Query179();

class Query179 extends ConvexQuery<Query179Args, Query179Return> {
  Query179() : super("generic_functions:query179");

  @override
  Map<String, Object?> parseArgs(Query179Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': _v0.i.map<Object?>((_v1) => _v1.name).toList(growable: false),
      };
    })();
  }

  @override
  Query179Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as List)
            .map<MessagesId>((_v1) => MessagesId(_v1 as String))
            .toList(growable: false),
      );
    })();
  }

  @override
  Query179Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as List)
            .map<MessagesId>((_v1) => MessagesId(_v1 as String))
            .toList(growable: false),
      );
    })();
  }
}

final query180 = Query180();

class Query180 extends ConvexQuery<Query180Args, Query180Return> {
  Query180() : super("generic_functions:query180");

  @override
  Map<String, Object?> parseArgs(Query180Args args) {
    return (() {
      final _v0 = args;
      return {'i': _v0.i.value};
    })();
  }

  @override
  Query180Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (i: $3_14.validate(_v0['i']));
    })();
  }

  @override
  Query180Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (i: $3_14.validate(_v0['i']));
    })();
  }
}

final query181 = Query181();

class Query181 extends ConvexQuery<Query181Args, Query181Return> {
  Query181() : super("generic_functions:query181");

  @override
  Map<String, Object?> parseArgs(Query181Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': (() {
          final _v1 = _v0.i;
          return {
            'deeply': (() {
              final _v2 = _v1.deeply;
              return {
                'nested': (() {
                  final _v3 = _v2.nested;
                  return {'value': _v3.value};
                })(),
              };
            })(),
          };
        })(),
      };
    })();
  }

  @override
  Query181Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (() {
          final _v1 = (_v0['i'] as Map).cast<String, Object?>();
          return (
            deeply: (() {
              final _v2 = (_v1['deeply'] as Map).cast<String, Object?>();
              return (
                nested: (() {
                  final _v3 = (_v2['nested'] as Map).cast<String, Object?>();
                  return (value: (_v3['value'] as String));
                })(),
              );
            })(),
          );
        })(),
      );
    })();
  }

  @override
  Query181Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (() {
          final _v1 = (_v0['i'] as Map).cast<String, Object?>();
          return (
            deeply: (() {
              final _v2 = (_v1['deeply'] as Map).cast<String, Object?>();
              return (
                nested: (() {
                  final _v3 = (_v2['nested'] as Map).cast<String, Object?>();
                  return (value: (_v3['value'] as String));
                })(),
              );
            })(),
          );
        })(),
      );
    })();
  }
}

final query183 = Query183();

class Query183 extends ConvexQuery<Query183Args, Query183Return> {
  Query183() : super("generic_functions:query183");

  @override
  Map<String, Object?> parseArgs(Query183Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': _v0.i.split(
          (_v1) => (() {
            final _v2 = _v1;
            return {'a': _v2.a};
          })(),
          (_v3) => (() {
            final _v4 = _v3;
            return {'a': _v4.a};
          })(),
        ),
      };
    })();
  }

  @override
  Query183Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: Union2<({String a}), ({double a})>(() {
          try {
            return (() {
              final _v1 = (_v0['i'] as Map).cast<String, Object?>();
              return (a: (_v1['a'] as String));
            })();
          } catch (e) {}

          try {
            return (() {
              final _v2 = (_v0['i'] as Map).cast<String, Object?>();
              return (a: (_v2['a'] as num).toDouble());
            })();
          } catch (e) {}

          throw Exception(
            (_v0['i'].toString()) +
                r" cannot be deserialized into a Union2<({String a}), ({double a})>",
          );
        }()),
      );
    })();
  }

  @override
  Query183Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: Union2<({String a}), ({double a})>(() {
          try {
            return (() {
              final _v1 = (_v0['i'] as Map).cast<String, Object?>();
              return (a: (_v1['a'] as String));
            })();
          } catch (e) {}

          try {
            return (() {
              final _v2 = (_v0['i'] as Map).cast<String, Object?>();
              return (a: (_v2['a'] as num).toDouble());
            })();
          } catch (e) {}

          throw Exception(
            (_v0['i'].toString()) +
                r" cannot be deserialized into a Union2<({String a}), ({double a})>",
          );
        }()),
      );
    })();
  }
}

final query184 = Query184();

class Query184 extends ConvexQuery<Query184Args, Query184Return> {
  Query184() : super("generic_functions:query184");

  @override
  Map<String, Object?> parseArgs(Query184Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': _v0.i
            .map<Object?>(
              (_v1) => {for (final _v2 in _v1.entries) _v2.key: _v2.value},
            )
            .toList(growable: false),
      };
    })();
  }

  @override
  Query184Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as List)
            .map<Map<String, bool>>(
              (_v1) => (_v1 as Map).cast<String, Object?>().map(
                (_v2, _v3) => MapEntry(_v2, (_v3 as bool)),
              ),
            )
            .toList(growable: false),
      );
    })();
  }

  @override
  Query184Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as List)
            .map<Map<String, bool>>(
              (_v1) => (_v1 as Map).cast<String, Object?>().map(
                (_v2, _v3) => MapEntry(_v2, (_v3 as bool)),
              ),
            )
            .toList(growable: false),
      );
    })();
  }
}

final query185 = Query185();

class Query185 extends ConvexQuery<Query185Args, Query185Return> {
  Query185() : super("generic_functions:query185");

  @override
  Map<String, Object?> parseArgs(Query185Args args) {
    return (() {
      final _v0 = args;
      return {if (_v0.i.isDefined) 'i': _v0.i.asDefined().value.value};
    })();
  }

  @override
  Query185Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: _v0.containsKey('i')
            ? Defined<$on>($on.validate(_v0['i']))
            : Undefined<$on>(),
      );
    })();
  }

  @override
  Query185Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: _v0.containsKey('i')
            ? Defined<$on>($on.validate(_v0['i']))
            : Undefined<$on>(),
      );
    })();
  }
}

final query186 = Query186();

class Query186 extends ConvexQuery<Query186Args, Query186Return> {
  Query186() : super("generic_functions:query186");

  @override
  Map<String, Object?> parseArgs(Query186Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': (() {
          final _v1 = _v0.i;
          return {
            'permissions': _v1.permissions
                .map<Object?>((_v2) => _v2.value.value)
                .toList(growable: false),
          };
        })(),
      };
    })();
  }

  @override
  Query186Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (() {
          final _v1 = (_v0['i'] as Map).cast<String, Object?>();
          return (
            permissions: (_v1['permissions'] as List)
                .map<$read$write$admin>(
                  (_v2) => $read$write$admin.fromValue(_v2 as Object),
                )
                .toList(growable: false),
          );
        })(),
      );
    })();
  }

  @override
  Query186Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (() {
          final _v1 = (_v0['i'] as Map).cast<String, Object?>();
          return (
            permissions: (_v1['permissions'] as List)
                .map<$read$write$admin>(
                  (_v2) => $read$write$admin.fromValue(_v2 as Object),
                )
                .toList(growable: false),
          );
        })(),
      );
    })();
  }
}

final query187 = Query187();

class Query187 extends ConvexQuery<Query187Args, Query187Return> {
  Query187() : super("generic_functions:query187");

  @override
  Map<String, Object?> parseArgs(Query187Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': {
          for (final _v1 in _v0.i.entries)
            _v1.key: {for (final _v2 in _v1.value.entries) _v2.key: _v2.value},
        },
      };
    })();
  }

  @override
  Query187Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as Map).cast<String, Object?>().map(
          (_v1, _v2) => MapEntry(
            _v1,
            (_v2 as Map).cast<String, Object?>().map(
              (_v3, _v4) => MapEntry(_v3, (_v4 as String)),
            ),
          ),
        ),
      );
    })();
  }

  @override
  Query187Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as Map).cast<String, Object?>().map(
          (_v1, _v2) => MapEntry(
            _v1,
            (_v2 as Map).cast<String, Object?>().map(
              (_v3, _v4) => MapEntry(_v3, (_v4 as String)),
            ),
          ),
        ),
      );
    })();
  }
}

final query188 = Query188();

class Query188 extends ConvexQuery<Query188Args, Query188Return> {
  Query188() : super("generic_functions:query188");

  @override
  Map<String, Object?> parseArgs(Query188Args args) {
    return (() {
      final _v0 = args;
      return {'i': _v0.i.split((_v1) => _v1, (_v2) => _v2.name)};
    })();
  }

  @override
  Query188Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: Union2<Object?, FallbackId>(() {
          try {
            return _v0['i'];
          } catch (e) {}

          try {
            return FallbackId(_v0['i'] as String);
          } catch (e) {}

          throw Exception(
            (_v0['i'].toString()) +
                r" cannot be deserialized into a Union2<Object?, FallbackId>",
          );
        }()),
      );
    })();
  }

  @override
  Query188Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: Union2<Object?, FallbackId>(() {
          try {
            return _v0['i'];
          } catch (e) {}

          try {
            return FallbackId(_v0['i'] as String);
          } catch (e) {}

          throw Exception(
            (_v0['i'].toString()) +
                r" cannot be deserialized into a Union2<Object?, FallbackId>",
          );
        }()),
      );
    })();
  }
}

final query189 = Query189();

class Query189 extends ConvexQuery<Query189Args, Query189Return> {
  Query189() : super("generic_functions:query189");

  @override
  Map<String, Object?> parseArgs(Query189Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': _v0.i
            .map<Object?>(
              (_v1) => (() {
                final _v2 = _v1;
                return {
                  'children': _v2.children
                      .map<Object?>((_v3) => _v3.name)
                      .toList(growable: false),
                  'id': _v2.id.name,
                };
              })(),
            )
            .toList(growable: false),
      };
    })();
  }

  @override
  Query189Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as List)
            .map<({List<NodesId> children, NodesId id})>(
              (_v1) => (() {
                final _v2 = (_v1 as Map).cast<String, Object?>();
                return (
                  children: (_v2['children'] as List)
                      .map<NodesId>((_v3) => NodesId(_v3 as String))
                      .toList(growable: false),
                  id: NodesId(_v2['id'] as String),
                );
              })(),
            )
            .toList(growable: false),
      );
    })();
  }

  @override
  Query189Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as List)
            .map<({List<NodesId> children, NodesId id})>(
              (_v1) => (() {
                final _v2 = (_v1 as Map).cast<String, Object?>();
                return (
                  children: (_v2['children'] as List)
                      .map<NodesId>((_v3) => NodesId(_v3 as String))
                      .toList(growable: false),
                  id: NodesId(_v2['id'] as String),
                );
              })(),
            )
            .toList(growable: false),
      );
    })();
  }
}

final query190 = Query190();

class Query190 extends ConvexQuery<Query190Args, Query190Return> {
  Query190() : super("generic_functions:query190");

  @override
  Map<String, Object?> parseArgs(Query190Args args) {
    return (() {
      final _v0 = args;
      return {'i': _v0.i.value};
    })();
  }

  @override
  Query190Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (i: $true.validate(_v0['i']));
    })();
  }

  @override
  Query190Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (i: $true.validate(_v0['i']));
    })();
  }
}

final query191 = Query191();

class Query191 extends ConvexQuery<Query191Args, Query191Return> {
  Query191() : super("generic_functions:query191");

  @override
  Map<String, Object?> parseArgs(Query191Args args) {
    return (() {
      final _v0 = args;
      return {'i': _v0.i.name};
    })();
  }

  @override
  Query191Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (i: AnotherTableId(_v0['i'] as String));
    })();
  }

  @override
  Query191Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (i: AnotherTableId(_v0['i'] as String));
    })();
  }
}

final query192 = Query192();

class Query192 extends ConvexQuery<Query192Args, Query192Return> {
  Query192() : super("generic_functions:query192");

  @override
  Map<String, Object?> parseArgs(Query192Args args) {
    return (() {
      final _v0 = args;
      return {'i': _v0.i};
    })();
  }

  @override
  Query192Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (i: (_v0['i'] as BigInt));
    })();
  }

  @override
  Query192Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (i: (_v0['i'] as BigInt));
    })();
  }
}

final query193 = Query193();

class Query193 extends ConvexQuery<Query193Args, Query193Return> {
  Query193() : super("generic_functions:query193");

  @override
  Map<String, Object?> parseArgs(Query193Args args) {
    return (() {
      final _v0 = args;
      return {'i': _v0.i};
    })();
  }

  @override
  Query193Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (i: (_v0['i'] as Uint8List));
    })();
  }

  @override
  Query193Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (i: (_v0['i'] as Uint8List));
    })();
  }
}

final query194 = Query194();

class Query194 extends ConvexQuery<Query194Args, Query194Return> {
  Query194() : super("generic_functions:query194");

  @override
  Map<String, Object?> parseArgs(Query194Args args) {
    return (() {
      final _v0 = args;
      return {if (_v0.i.isDefined) 'i': _v0.i.asDefined().value};
    })();
  }

  @override
  Query194Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: _v0.containsKey('i')
            ? Defined<bool>((_v0['i'] as bool))
            : Undefined<bool>(),
      );
    })();
  }

  @override
  Query194Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: _v0.containsKey('i')
            ? Defined<bool>((_v0['i'] as bool))
            : Undefined<bool>(),
      );
    })();
  }
}

final query195 = Query195();

class Query195 extends ConvexQuery<Query195Args, Query195Return> {
  Query195() : super("generic_functions:query195");

  @override
  Map<String, Object?> parseArgs(Query195Args args) {
    return (() {
      final _v0 = args;
      return {'i': _v0.i};
    })();
  }

  @override
  Query195Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (i: _v0['i'] == null ? null : (_v0['i'] as num).toDouble());
    })();
  }

  @override
  Query195Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (i: _v0['i'] == null ? null : (_v0['i'] as num).toDouble());
    })();
  }
}

final query196 = Query196();

class Query196 extends ConvexQuery<Query196Args, Query196Return> {
  Query196() : super("generic_functions:query196");

  @override
  Map<String, Object?> parseArgs(Query196Args args) {
    return (() {
      final _v0 = args;
      return {'i': _v0.i.map<Object?>((_v1) => _v1).toList(growable: false)};
    })();
  }

  @override
  Query196Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as List)
            .map<String>((_v1) => (_v1 as String))
            .toList(growable: false),
      );
    })();
  }

  @override
  Query196Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as List)
            .map<String>((_v1) => (_v1 as String))
            .toList(growable: false),
      );
    })();
  }
}

final query197 = Query197();

class Query197 extends ConvexQuery<Query197Args, Query197Return> {
  Query197() : super("generic_functions:query197");

  @override
  Map<String, Object?> parseArgs(Query197Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': {for (final _v1 in _v0.i.entries) _v1.key: _v1.value},
      };
    })();
  }

  @override
  Query197Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as Map).cast<String, Object?>().map(
          (_v1, _v2) => MapEntry(_v1, (_v2 as num).toDouble()),
        ),
      );
    })();
  }

  @override
  Query197Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as Map).cast<String, Object?>().map(
          (_v1, _v2) => MapEntry(_v1, (_v2 as num).toDouble()),
        ),
      );
    })();
  }
}

final query198 = Query198();

class Query198 extends ConvexQuery<Query198Args, Query198Return> {
  Query198() : super("generic_functions:query198");

  @override
  Map<String, Object?> parseArgs(Query198Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': (() {
          final _v1 = _v0.i;
          return {'name': _v1.name, 'value': _v1.value};
        })(),
      };
    })();
  }

  @override
  Query198Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (() {
          final _v1 = (_v0['i'] as Map).cast<String, Object?>();
          return (name: (_v1['name'] as String), value: _v1['value']);
        })(),
      );
    })();
  }

  @override
  Query198Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (() {
          final _v1 = (_v0['i'] as Map).cast<String, Object?>();
          return (name: (_v1['name'] as String), value: _v1['value']);
        })(),
      );
    })();
  }
}

final query199 = Query199();

class Query199 extends ConvexQuery<Query199Args, Query199Return> {
  Query199() : super("generic_functions:query199");

  @override
  Map<String, Object?> parseArgs(Query199Args args) {
    return (() {
      final _v0 = args;
      return {'i': _v0.i.value.value};
    })();
  }

  @override
  Query199Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (i: $a$b$c.fromValue(_v0['i'] as Object));
    })();
  }

  @override
  Query199Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (i: $a$b$c.fromValue(_v0['i'] as Object));
    })();
  }
}

final query201 = Query201();

class Query201 extends ConvexQuery<Query201Args, Query201Return> {
  Query201() : super("generic_functions:query201");

  @override
  Map<String, Object?> parseArgs(Query201Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': (() {
          final _v1 = _v0.i;
          return {'a': _v1.a, 'b': _v1.b};
        })(),
      };
    })();
  }

  @override
  Query201Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (() {
          final _v1 = (_v0['i'] as Map).cast<String, Object?>();
          return (a: (_v1['a'] as String), b: (_v1['b'] as String));
        })(),
      );
    })();
  }

  @override
  Query201Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (() {
          final _v1 = (_v0['i'] as Map).cast<String, Object?>();
          return (a: (_v1['a'] as String), b: (_v1['b'] as String));
        })(),
      );
    })();
  }
}

final query203 = Query203();

class Query203 extends ConvexQuery<Query203Args, Query203Return> {
  Query203() : super("generic_functions:query203");

  @override
  Map<String, Object?> parseArgs(Query203Args args) {
    return (() {
      final _v0 = args;
      return {'i': _v0.i.split((_v1) => _v1, (_v2) => _v2)};
    })();
  }

  @override
  Query203Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: Union2<String, double>(() {
          try {
            return (_v0['i'] as String);
          } catch (e) {}

          try {
            return (_v0['i'] as num).toDouble();
          } catch (e) {}

          throw Exception(
            (_v0['i'].toString()) +
                r" cannot be deserialized into a Union2<String, double>",
          );
        }()),
      );
    })();
  }

  @override
  Query203Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: Union2<String, double>(() {
          try {
            return (_v0['i'] as String);
          } catch (e) {}

          try {
            return (_v0['i'] as num).toDouble();
          } catch (e) {}

          throw Exception(
            (_v0['i'].toString()) +
                r" cannot be deserialized into a Union2<String, double>",
          );
        }()),
      );
    })();
  }
}

final query204 = Query204();

class Query204 extends ConvexQuery<Query204Args, Query204Return> {
  Query204() : super("generic_functions:query204");

  @override
  Map<String, Object?> parseArgs(Query204Args args) {
    return (() {
      final _v0 = args;
      return {'i': _v0.i.map<Object?>((_v1) => _v1).toList(growable: false)};
    })();
  }

  @override
  Query204Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as List)
            .map<BigInt>((_v1) => (_v1 as BigInt))
            .toList(growable: false),
      );
    })();
  }

  @override
  Query204Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as List)
            .map<BigInt>((_v1) => (_v1 as BigInt))
            .toList(growable: false),
      );
    })();
  }
}

final query205 = Query205();

class Query205 extends ConvexQuery<Query205Args, Query205Return> {
  Query205() : super("generic_functions:query205");

  @override
  Map<String, Object?> parseArgs(Query205Args args) {
    return (() {
      final _v0 = args;
      return {
        if (_v0.i.isDefined)
          'i': {
            for (final _v1 in _v0.i.asDefined().value.entries)
              _v1.key: _v1.value,
          },
      };
    })();
  }

  @override
  Query205Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: _v0.containsKey('i')
            ? Defined<Map<String, String>>(
                (_v0['i'] as Map).cast<String, Object?>().map(
                  (_v1, _v2) => MapEntry(_v1, (_v2 as String)),
                ),
              )
            : Undefined<Map<String, String>>(),
      );
    })();
  }

  @override
  Query205Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: _v0.containsKey('i')
            ? Defined<Map<String, String>>(
                (_v0['i'] as Map).cast<String, Object?>().map(
                  (_v1, _v2) => MapEntry(_v1, (_v2 as String)),
                ),
              )
            : Undefined<Map<String, String>>(),
      );
    })();
  }
}

final query206 = Query206();

class Query206 extends ConvexQuery<Query206Args, Query206Return> {
  Query206() : super("generic_functions:query206");

  @override
  Map<String, Object?> parseArgs(Query206Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': (() {
          final _v1 = _v0.i;
          return {
            'data': _v1.data
                .map<Object?>(
                  (_v2) => (() {
                    final _v3 = _v2;
                    return {'value': _v3.value};
                  })(),
                )
                .toList(growable: false),
          };
        })(),
      };
    })();
  }

  @override
  Query206Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (() {
          final _v1 = (_v0['i'] as Map).cast<String, Object?>();
          return (
            data: (_v1['data'] as List)
                .map<({double value})>(
                  (_v2) => (() {
                    final _v3 = (_v2 as Map).cast<String, Object?>();
                    return (value: (_v3['value'] as num).toDouble());
                  })(),
                )
                .toList(growable: false),
          );
        })(),
      );
    })();
  }

  @override
  Query206Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (() {
          final _v1 = (_v0['i'] as Map).cast<String, Object?>();
          return (
            data: (_v1['data'] as List)
                .map<({double value})>(
                  (_v2) => (() {
                    final _v3 = (_v2 as Map).cast<String, Object?>();
                    return (value: (_v3['value'] as num).toDouble());
                  })(),
                )
                .toList(growable: false),
          );
        })(),
      );
    })();
  }
}

final query208 = Query208();

class Query208 extends ConvexQuery<Query208Args, Query208Return> {
  Query208() : super("generic_functions:query208");

  @override
  Map<String, Object?> parseArgs(Query208Args args) {
    return (() {
      final _v0 = args;
      return {'i': _v0.i.value.value};
    })();
  }

  @override
  Query208Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (i: $on$off.fromValue(_v0['i'] as Object));
    })();
  }

  @override
  Query208Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (i: $on$off.fromValue(_v0['i'] as Object));
    })();
  }
}

final query209 = Query209();

class Query209 extends ConvexQuery<Query209Args, Query209Return> {
  Query209() : super("generic_functions:query209");

  @override
  Map<String, Object?> parseArgs(Query209Args args) {
    return (() {
      final _v0 = args;
      return {'i': _v0.i.map<Object?>((_v1) => _v1).toList(growable: false)};
    })();
  }

  @override
  Query209Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as List)
            .map<String?>((_v1) => _v1 == null ? null : (_v1 as String))
            .toList(growable: false),
      );
    })();
  }

  @override
  Query209Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as List)
            .map<String?>((_v1) => _v1 == null ? null : (_v1 as String))
            .toList(growable: false),
      );
    })();
  }
}

final query210 = Query210();

class Query210 extends ConvexQuery<Query210Args, Query210Return> {
  Query210() : super("generic_functions:query210");

  @override
  Map<String, Object?> parseArgs(Query210Args args) {
    return (() {
      final _v0 = args;
      return {'i': _v0.i.value};
    })();
  }

  @override
  Query210Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (i: $_1_0.validate(_v0['i']));
    })();
  }

  @override
  Query210Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (i: $_1_0.validate(_v0['i']));
    })();
  }
}

final query211 = Query211();

class Query211 extends ConvexQuery<Query211Args, Query211Return> {
  Query211() : super("generic_functions:query211");

  @override
  Map<String, Object?> parseArgs(Query211Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': (() {
          final _v1 = _v0.i;
          return {
            'tags': _v1.tags.map<Object?>((_v2) => _v2).toList(growable: false),
          };
        })(),
      };
    })();
  }

  @override
  Query211Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (() {
          final _v1 = (_v0['i'] as Map).cast<String, Object?>();
          return (
            tags: (_v1['tags'] as List)
                .map<String>((_v2) => (_v2 as String))
                .toList(growable: false),
          );
        })(),
      );
    })();
  }

  @override
  Query211Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (() {
          final _v1 = (_v0['i'] as Map).cast<String, Object?>();
          return (
            tags: (_v1['tags'] as List)
                .map<String>((_v2) => (_v2 as String))
                .toList(growable: false),
          );
        })(),
      );
    })();
  }
}

final query212 = Query212();

class Query212 extends ConvexQuery<Query212Args, Query212Return> {
  Query212() : super("generic_functions:query212");

  @override
  Map<String, Object?> parseArgs(Query212Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': {
          for (final _v1 in _v0.i.entries)
            _v1.key: _v1.value
                .map<Object?>((_v2) => _v2)
                .toList(growable: false),
        },
      };
    })();
  }

  @override
  Query212Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as Map).cast<String, Object?>().map(
          (_v1, _v2) => MapEntry(
            _v1,
            (_v2 as List).map<Object?>((_v3) => _v3).toList(growable: false),
          ),
        ),
      );
    })();
  }

  @override
  Query212Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as Map).cast<String, Object?>().map(
          (_v1, _v2) => MapEntry(
            _v1,
            (_v2 as List).map<Object?>((_v3) => _v3).toList(growable: false),
          ),
        ),
      );
    })();
  }
}

final query213 = Query213();

class Query213 extends ConvexQuery<Query213Args, Query213Return> {
  Query213() : super("generic_functions:query213");

  @override
  Map<String, Object?> parseArgs(Query213Args args) {
    return (() {
      final _v0 = args;
      return {'i': _v0.i.split((_v1) => _v1.name, (_v2) => _v2.name)};
    })();
  }

  @override
  Query213Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: Union2<UsersId, AdminsId>(() {
          try {
            return UsersId(_v0['i'] as String);
          } catch (e) {}

          try {
            return AdminsId(_v0['i'] as String);
          } catch (e) {}

          throw Exception(
            (_v0['i'].toString()) +
                r" cannot be deserialized into a Union2<UsersId, AdminsId>",
          );
        }()),
      );
    })();
  }

  @override
  Query213Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: Union2<UsersId, AdminsId>(() {
          try {
            return UsersId(_v0['i'] as String);
          } catch (e) {}

          try {
            return AdminsId(_v0['i'] as String);
          } catch (e) {}

          throw Exception(
            (_v0['i'].toString()) +
                r" cannot be deserialized into a Union2<UsersId, AdminsId>",
          );
        }()),
      );
    })();
  }
}

final query214 = Query214();

class Query214 extends ConvexQuery<Query214Args, Query214Return> {
  Query214() : super("generic_functions:query214");

  @override
  Map<String, Object?> parseArgs(Query214Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': _v0.i
            .map<Object?>(
              (_v1) => (() {
                final _v2 = _v1;
                return {'id': _v2.id, 'score': _v2.score};
              })(),
            )
            .toList(growable: false),
      };
    })();
  }

  @override
  Query214Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as List)
            .map<({String id, double score})>(
              (_v1) => (() {
                final _v2 = (_v1 as Map).cast<String, Object?>();
                return (
                  id: (_v2['id'] as String),
                  score: (_v2['score'] as num).toDouble(),
                );
              })(),
            )
            .toList(growable: false),
      );
    })();
  }

  @override
  Query214Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as List)
            .map<({String id, double score})>(
              (_v1) => (() {
                final _v2 = (_v1 as Map).cast<String, Object?>();
                return (
                  id: (_v2['id'] as String),
                  score: (_v2['score'] as num).toDouble(),
                );
              })(),
            )
            .toList(growable: false),
      );
    })();
  }
}

final query215 = Query215();

class Query215 extends ConvexQuery<Query215Args, Query215Return> {
  Query215() : super("generic_functions:query215");

  @override
  Map<String, Object?> parseArgs(Query215Args args) {
    return (() {
      final _v0 = args;
      return {
        if (_v0.i.isDefined)
          'i': _v0.i
              .asDefined()
              .value
              .map<Object?>((_v1) => _v1)
              .toList(growable: false),
      };
    })();
  }

  @override
  Query215Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: _v0.containsKey('i')
            ? Defined<List<bool>>(
                (_v0['i'] as List)
                    .map<bool>((_v1) => (_v1 as bool))
                    .toList(growable: false),
              )
            : Undefined<List<bool>>(),
      );
    })();
  }

  @override
  Query215Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: _v0.containsKey('i')
            ? Defined<List<bool>>(
                (_v0['i'] as List)
                    .map<bool>((_v1) => (_v1 as bool))
                    .toList(growable: false),
              )
            : Undefined<List<bool>>(),
      );
    })();
  }
}

final query216 = Query216();

class Query216 extends ConvexQuery<Query216Args, Query216Return> {
  Query216() : super("generic_functions:query216");

  @override
  Map<String, Object?> parseArgs(Query216Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': (() {
          final _v1 = _v0.i;
          return {'payload': _v1.payload, 'timestamp': _v1.timestamp};
        })(),
      };
    })();
  }

  @override
  Query216Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (() {
          final _v1 = (_v0['i'] as Map).cast<String, Object?>();
          return (
            payload: _v1['payload'],
            timestamp: (_v1['timestamp'] as num).toDouble(),
          );
        })(),
      );
    })();
  }

  @override
  Query216Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (() {
          final _v1 = (_v0['i'] as Map).cast<String, Object?>();
          return (
            payload: _v1['payload'],
            timestamp: (_v1['timestamp'] as num).toDouble(),
          );
        })(),
      );
    })();
  }
}

final query217 = Query217();

class Query217 extends ConvexQuery<Query217Args, Query217Return> {
  Query217() : super("generic_functions:query217");

  @override
  Map<String, Object?> parseArgs(Query217Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': {for (final _v1 in _v0.i.entries) _v1.key: _v1.value.value},
      };
    })();
  }

  @override
  Query217Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as Map).cast<String, Object?>().map(
          (_v1, _v2) => MapEntry(_v1, $value.validate(_v2)),
        ),
      );
    })();
  }

  @override
  Query217Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as Map).cast<String, Object?>().map(
          (_v1, _v2) => MapEntry(_v1, $value.validate(_v2)),
        ),
      );
    })();
  }
}

final query218 = Query218();

class Query218 extends ConvexQuery<Query218Args, Query218Return> {
  Query218() : super("generic_functions:query218");

  @override
  Map<String, Object?> parseArgs(Query218Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': _v0.i.split(
          (_v1) => (() {
            final _v2 = _v1;
            return {'data': _v2.data, 'success': _v2.success.value};
          })(),
          (_v3) => (() {
            final _v4 = _v3;
            return {'error': _v4.error, 'success': _v4.success.value};
          })(),
        ),
      };
    })();
  }

  @override
  Query218Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i:
            Union2<
              ({Object? data, $true success}),
              ({String error, $false success})
            >(() {
              try {
                return (() {
                  final _v1 = (_v0['i'] as Map).cast<String, Object?>();
                  return (
                    data: _v1['data'],
                    success: $true.validate(_v1['success']),
                  );
                })();
              } catch (e) {}

              try {
                return (() {
                  final _v2 = (_v0['i'] as Map).cast<String, Object?>();
                  return (
                    error: (_v2['error'] as String),
                    success: $false.validate(_v2['success']),
                  );
                })();
              } catch (e) {}

              throw Exception(
                (_v0['i'].toString()) +
                    r" cannot be deserialized into a Union2<({Object? data,$true success}), ({String error,$false success})>",
              );
            }()),
      );
    })();
  }

  @override
  Query218Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i:
            Union2<
              ({Object? data, $true success}),
              ({String error, $false success})
            >(() {
              try {
                return (() {
                  final _v1 = (_v0['i'] as Map).cast<String, Object?>();
                  return (
                    data: _v1['data'],
                    success: $true.validate(_v1['success']),
                  );
                })();
              } catch (e) {}

              try {
                return (() {
                  final _v2 = (_v0['i'] as Map).cast<String, Object?>();
                  return (
                    error: (_v2['error'] as String),
                    success: $false.validate(_v2['success']),
                  );
                })();
              } catch (e) {}

              throw Exception(
                (_v0['i'].toString()) +
                    r" cannot be deserialized into a Union2<({Object? data,$true success}), ({String error,$false success})>",
              );
            }()),
      );
    })();
  }
}

final query219 = Query219();

class Query219 extends ConvexQuery<Query219Args, Query219Return> {
  Query219() : super("generic_functions:query219");

  @override
  Map<String, Object?> parseArgs(Query219Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': _v0.i
            .map<Object?>(
              (_v1) => {for (final _v2 in _v1.entries) _v2.key: _v2.value},
            )
            .toList(growable: false),
      };
    })();
  }

  @override
  Query219Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as List)
            .map<Map<String, Object?>>(
              (_v1) => (_v1 as Map).cast<String, Object?>().map(
                (_v2, _v3) => MapEntry(_v2, _v3),
              ),
            )
            .toList(growable: false),
      );
    })();
  }

  @override
  Query219Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as List)
            .map<Map<String, Object?>>(
              (_v1) => (_v1 as Map).cast<String, Object?>().map(
                (_v2, _v3) => MapEntry(_v2, _v3),
              ),
            )
            .toList(growable: false),
      );
    })();
  }
}

final query220 = Query220();

class Query220 extends ConvexQuery<Query220Args, Query220Return> {
  Query220() : super("generic_functions:query220");

  @override
  Map<String, Object?> parseArgs(Query220Args args) {
    return (() {
      final _v0 = args;
      return {'i': _v0.i.value};
    })();
  }

  @override
  Query220Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (i: $.validate(_v0['i']));
    })();
  }

  @override
  Query220Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (i: $.validate(_v0['i']));
    })();
  }
}

final query221 = Query221();

class Query221 extends ConvexQuery<Query221Args, Query221Return> {
  Query221() : super("generic_functions:query221");

  @override
  Map<String, Object?> parseArgs(Query221Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': (() {
          final _v1 = _v0.i;
          return {
            if (_v1.a.isDefined)
              'a': (() {
                final _v2 = _v1.a.asDefined().value;
                return {'b': _v2.b};
              })(),
          };
        })(),
      };
    })();
  }

  @override
  Query221Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (() {
          final _v1 = (_v0['i'] as Map).cast<String, Object?>();
          return (
            a: _v1.containsKey('a')
                ? Defined<({String b})>(
                    (() {
                      final _v2 = (_v1['a'] as Map).cast<String, Object?>();
                      return (b: (_v2['b'] as String));
                    })(),
                  )
                : Undefined<({String b})>(),
          );
        })(),
      );
    })();
  }

  @override
  Query221Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (() {
          final _v1 = (_v0['i'] as Map).cast<String, Object?>();
          return (
            a: _v1.containsKey('a')
                ? Defined<({String b})>(
                    (() {
                      final _v2 = (_v1['a'] as Map).cast<String, Object?>();
                      return (b: (_v2['b'] as String));
                    })(),
                  )
                : Undefined<({String b})>(),
          );
        })(),
      );
    })();
  }
}

final query223 = Query223();

class Query223 extends ConvexQuery<Query223Args, Query223Return> {
  Query223() : super("generic_functions:query223");

  @override
  Map<String, Object?> parseArgs(Query223Args args) {
    return (() {
      final _v0 = args;
      return {'i': _v0.i.split((_v1) => _v1, (_v2) => _v2)};
    })();
  }

  @override
  Query223Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: Union2<BigInt, Uint8List>(() {
          try {
            return (_v0['i'] as BigInt);
          } catch (e) {}

          try {
            return (_v0['i'] as Uint8List);
          } catch (e) {}

          throw Exception(
            (_v0['i'].toString()) +
                r" cannot be deserialized into a Union2<BigInt, Uint8List>",
          );
        }()),
      );
    })();
  }

  @override
  Query223Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: Union2<BigInt, Uint8List>(() {
          try {
            return (_v0['i'] as BigInt);
          } catch (e) {}

          try {
            return (_v0['i'] as Uint8List);
          } catch (e) {}

          throw Exception(
            (_v0['i'].toString()) +
                r" cannot be deserialized into a Union2<BigInt, Uint8List>",
          );
        }()),
      );
    })();
  }
}

final query224 = Query224();

class Query224 extends ConvexQuery<Query224Args, Query224Return> {
  Query224() : super("generic_functions:query224");

  @override
  Map<String, Object?> parseArgs(Query224Args args) {
    return (() {
      final _v0 = args;
      return {
        'i': _v0.i
            .map<Object?>((_v1) => _v1.value.value)
            .toList(growable: false),
      };
    })();
  }

  @override
  Query224Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as List)
            .map<$cat$dog>((_v1) => $cat$dog.fromValue(_v1 as Object))
            .toList(growable: false),
      );
    })();
  }

  @override
  Query224Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: (_v0['i'] as List)
            .map<$cat$dog>((_v1) => $cat$dog.fromValue(_v1 as Object))
            .toList(growable: false),
      );
    })();
  }
}

final query225 = Query225();

class Query225 extends ConvexQuery<Query225Args, Query225Return> {
  Query225() : super("generic_functions:query225");

  @override
  Map<String, Object?> parseArgs(Query225Args args) {
    return (() {
      final _v0 = args;
      return {
        if (_v0.i.isDefined)
          'i': _v0.i.asDefined().value.split((_v1) => _v1, (_v2) => _v2),
      };
    })();
  }

  @override
  Query225Args parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        i: _v0.containsKey('i')
            ? Defined<Union2<String, double>>(
                Union2<String, double>(() {
                  try {
                    return (_v0['i'] as String);
                  } catch (e) {}

                  try {
                    return (_v0['i'] as num).toDouble();
                  } catch (e) {}

                  throw Exception(
                    (_v0['i'].toString()) +
                        r" cannot be deserialized into a Union2<String, double>",
                  );
                }()),
              )
            : Undefined<Union2<String, double>>(),
      );
    })();
  }

  @override
  Query225Return parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        i: _v0.containsKey('i')
            ? Defined<Union2<String, double>>(
                Union2<String, double>(() {
                  try {
                    return (_v0['i'] as String);
                  } catch (e) {}

                  try {
                    return (_v0['i'] as num).toDouble();
                  } catch (e) {}

                  throw Exception(
                    (_v0['i'].toString()) +
                        r" cannot be deserialized into a Union2<String, double>",
                  );
                }()),
              )
            : Undefined<Union2<String, double>>(),
      );
    })();
  }
}

typedef Query1Args = ({String i});
typedef Query1Return = ({String i});
typedef Query2Args = ({double i});
typedef Query2Return = ({double i});
typedef Query3Args = ({bool i});
typedef Query3Return = ({bool i});
typedef Query4Args = ({BigInt i});
typedef Query4Return = ({BigInt i});
typedef Query5Args = ({Uint8List i});
typedef Query5Return = ({Uint8List i});
typedef Query6Args = ({TasksId i});
typedef Query6Return = ({TasksId i});
typedef Query7Args = ({Object? i});
typedef Query7Return = ({Object? i});
typedef Query9Args = ({$hi i});
typedef Query9Return = ({$hi i});
typedef Query10Args = ({$1_0 i});
typedef Query10Return = ({$1_0 i});
typedef Query11Args = ({$true i});
typedef Query11Return = ({$true i});
typedef Query13Args = ({Optional<String> i});
typedef Query13Return = ({Optional<String> i});
typedef Query14Args = ({Optional<double> i});
typedef Query14Return = ({Optional<double> i});
typedef Query15Args = ({Optional<bool> i});
typedef Query15Return = ({Optional<bool> i});
typedef Query16Args = ({Optional<BigInt> i});
typedef Query16Return = ({Optional<BigInt> i});
typedef Query17Args = ({Optional<Uint8List> i});
typedef Query17Return = ({Optional<Uint8List> i});
typedef Query18Args = ({Optional<TasksId> i});
typedef Query18Return = ({Optional<TasksId> i});
typedef Query19Args = ({Optional<Object?> i});
typedef Query19Return = ({Optional<Object?> i});
typedef Query20Args = ({Optional<$hi> i});
typedef Query20Return = ({Optional<$hi> i});
typedef Query21Args = ({Optional<$1_0> i});
typedef Query21Return = ({Optional<$1_0> i});
typedef Query22Args = ({Optional<$true> i});
typedef Query22Return = ({Optional<$true> i});
typedef Query24Args = ({String? i});
typedef Query24Return = ({String? i});
typedef Query25Args = ({double? i});
typedef Query25Return = ({double? i});
typedef Query26Args = ({bool? i});
typedef Query26Return = ({bool? i});
typedef Query27Args = ({BigInt? i});
typedef Query27Return = ({BigInt? i});
typedef Query28Args = ({Uint8List? i});
typedef Query28Return = ({Uint8List? i});
typedef Query29Args = ({TasksId? i});
typedef Query29Return = ({TasksId? i});
typedef Query30Args = ({Object? i});
typedef Query30Return = ({Object? i});
typedef Query31Args = ({$hi? i});
typedef Query31Return = ({$hi? i});
typedef Query32Args = ({$1_0? i});
typedef Query32Return = ({$1_0? i});
typedef Query33Args = ({$true? i});
typedef Query33Return = ({$true? i});
typedef Query34WithNullArgs = ({$blue$red? i});
typedef Query34WithNullReturn = ({$blue$red? i});
typedef Query34NonNullArgs = ({$blue$red i});
typedef Query34NonNullReturn = ({$blue$red i});
typedef Query35Args = ({List<String> i});
typedef Query35Return = ({List<String> i});
typedef Query36Args = ({List<double> i});
typedef Query36Return = ({List<double> i});
typedef Query37Args = ({List<bool> i});
typedef Query37Return = ({List<bool> i});
typedef Query38Args = ({List<BigInt> i});
typedef Query38Return = ({List<BigInt> i});
typedef Query39Args = ({List<Uint8List> i});
typedef Query39Return = ({List<Uint8List> i});
typedef Query40Args = ({List<TasksId> i});
typedef Query40Return = ({List<TasksId> i});
typedef Query41Args = ({List<Object?> i});
typedef Query41Return = ({List<Object?> i});
typedef Query42Args = ({List<Null> i});
typedef Query42Return = ({List<Null> i});
typedef Query43Args = ({List<$hi> i});
typedef Query43Return = ({List<$hi> i});
typedef Query44Args = ({List<$1_0> i});
typedef Query44Return = ({List<$1_0> i});
typedef Query45Args = ({List<$true> i});
typedef Query45Return = ({List<$true> i});
typedef Query58Args = ({List<String?> i});
typedef Query58Return = ({List<String?> i});
typedef Query59Args = ({List<double?> i});
typedef Query59Return = ({List<double?> i});
typedef Query60Args = ({List<bool?> i});
typedef Query60Return = ({List<bool?> i});
typedef Query61Args = ({List<BigInt?> i});
typedef Query61Return = ({List<BigInt?> i});
typedef Query62Args = ({List<Uint8List?> i});
typedef Query62Return = ({List<Uint8List?> i});
typedef Query63Args = ({List<TasksId?> i});
typedef Query63Return = ({List<TasksId?> i});
typedef Query64Args = ({List<Object?> i});
typedef Query64Return = ({List<Object?> i});
typedef Query65Args = ({List<$hi?> i});
typedef Query65Return = ({List<$hi?> i});
typedef Query66Args = ({List<$1_0?> i});
typedef Query66Return = ({List<$1_0?> i});
typedef Query67Args = ({List<$true?> i});
typedef Query67Return = ({List<$true?> i});
typedef Query69Args = ({Map<String, String> i});
typedef Query69Return = ({Map<String, String> i});
typedef Query70Args = ({Map<String, double> i});
typedef Query70Return = ({Map<String, double> i});
typedef Query71Args = ({Map<String, bool> i});
typedef Query71Return = ({Map<String, bool> i});
typedef Query72Args = ({Map<String, BigInt> i});
typedef Query72Return = ({Map<String, BigInt> i});
typedef Query73Args = ({Map<String, Uint8List> i});
typedef Query73Return = ({Map<String, Uint8List> i});
typedef Query74Args = ({Map<String, TasksId> i});
typedef Query74Return = ({Map<String, TasksId> i});
typedef Query75Args = ({Map<String, Object?> i});
typedef Query75Return = ({Map<String, Object?> i});
typedef Query76Args = ({Map<String, Null> i});
typedef Query76Return = ({Map<String, Null> i});
typedef Query77Args = ({Map<String, $hi> i});
typedef Query77Return = ({Map<String, $hi> i});
typedef Query78Args = ({Map<String, $1_0> i});
typedef Query78Return = ({Map<String, $1_0> i});
typedef Query79Args = ({Map<String, $true> i});
typedef Query79Return = ({Map<String, $true> i});
typedef Query81Args = ({Map<String, String?> i});
typedef Query81Return = ({Map<String, String?> i});
typedef Query82Args = ({Map<String, double?> i});
typedef Query82Return = ({Map<String, double?> i});
typedef Query83Args = ({Map<String, bool?> i});
typedef Query83Return = ({Map<String, bool?> i});
typedef Query84Args = ({Map<String, BigInt?> i});
typedef Query84Return = ({Map<String, BigInt?> i});
typedef Query85Args = ({Map<String, Uint8List?> i});
typedef Query85Return = ({Map<String, Uint8List?> i});
typedef Query86Args = ({Map<String, TasksId?> i});
typedef Query86Return = ({Map<String, TasksId?> i});
typedef Query87Args = ({Map<String, Object?> i});
typedef Query87Return = ({Map<String, Object?> i});
typedef Query88Args = ({Map<String, $hi?> i});
typedef Query88Return = ({Map<String, $hi?> i});
typedef Query89Args = ({Map<String, $1_0?> i});
typedef Query89Return = ({Map<String, $1_0?> i});
typedef Query90Args = ({Map<String, $true?> i});
typedef Query90Return = ({Map<String, $true?> i});
typedef Query92Args = ({Union2<String, double> i});
typedef Query92Return = ({Union2<String, double> i});
typedef Query93Args = ({Union2<bool, double> i});
typedef Query93Return = ({Union2<bool, double> i});
typedef Query94Args = ({Union2<String, bool> i});
typedef Query94Return = ({Union2<String, bool> i});
typedef Query95Args = ({Union3<String, double, bool> i});
typedef Query95Return = ({Union3<String, double, bool> i});
typedef Query96Args = ({String? i});
typedef Query96Return = ({String? i});
typedef Query97Args = ({Union2<double, bool>? i});
typedef Query97Return = ({Union2<double, bool>? i});
typedef Query98Args = ({Union2<Uint8List, String> i});
typedef Query98Return = ({Union2<Uint8List, String> i});
typedef Query100Args = ({$yes$no i});
typedef Query100Return = ({$yes$no i});
typedef Query101Args = ({$10$20$30 i});
typedef Query101Return = ({$10$20$30 i});
typedef Query102Args = ({$admin$user$guest i});
typedef Query102Return = ({$admin$user$guest i});
typedef Query103Args = ({Union2<BigInt, double> i});
typedef Query103Return = ({Union2<BigInt, double> i});
typedef Query104Args = ({Union3<String, double, bool>? i});
typedef Query104Return = ({Union3<String, double, bool>? i});
typedef Query105Args = ({Object? i});
typedef Query105Return = ({Object? i});
typedef Query106Args = ({$true$false i});
typedef Query106Return = ({$true$false i});
typedef Query107Args = ({Union2<Uint8List, BigInt>? i});
typedef Query107Return = ({Union2<Uint8List, BigInt>? i});
typedef Query110Args = ({$mixed? i});
typedef Query110Return = ({$mixed? i});
typedef Query111Args = ({({double age, String name}) i});
typedef Query111Return = ({({double age, String name}) i});
typedef Query112Args = ({({bool completed, TasksId id, String title}) i});
typedef Query112Return = ({({bool completed, TasksId id, String title}) i});
typedef Query113Args = ({
  ({
    ({bool notifications, String theme}) settings,
    ({String email, String name}) user,
  })
  i,
});
typedef Query113Return = ({
  ({
    ({bool notifications, String theme}) settings,
    ({String email, String name}) user,
  })
  i,
});
typedef Query114Args = ({
  ({Optional<String> email, Optional<String> name, String? phone}) i,
});
typedef Query114Return = ({
  ({Optional<String> email, Optional<String> name, String? phone}) i,
});
typedef Query115Args = ({
  ({List<$work$personal$urgent> categories, List<String> tags}) i,
});
typedef Query115Return = ({
  ({List<$work$personal$urgent> categories, List<String> tags}) i,
});
typedef Query116Args = ({
  ({
    ({$text$number$boolean type, Object? value}) data,
    Map<String, Object?> metadata,
  })
  i,
});
typedef Query116Return = ({
  ({
    ({$text$number$boolean type, Object? value}) data,
    Map<String, Object?> metadata,
  })
  i,
});
typedef Query117Args = ({
  ({
    List<({String author, String text, double timestamp})> comments,
    Optional<({TasksId id, String name})> reviewer,
    $pending$approved$rejected status,
  })
  i,
});
typedef Query117Return = ({
  ({
    List<({String author, String text, double timestamp})> comments,
    Optional<({TasksId id, String name})> reviewer,
    $pending$approved$rejected status,
  })
  i,
});
typedef Query118Args = ({
  ({
    Map<String, Union3<String, double, bool>> config,
    ({bool enabled, Object? value}) fallback,
  })
  i,
});
typedef Query118Return = ({
  ({
    Map<String, Union3<String, double, bool>> config,
    ({bool enabled, Object? value}) fallback,
  })
  i,
});
typedef Query119Args = ({
  ({
    Union3<
      ({String content, $text type}),
      ({double content, $number type}),
      ({bool content, $boolean type})
    >
    data,
  })
  i,
});
typedef Query119Return = ({
  ({
    Union3<
      ({String content, $text type}),
      ({double content, $number type}),
      ({bool content, $boolean type})
    >
    data,
  })
  i,
});
typedef Query120Args = ({
  ({
    List<
      ({
        String id,
        Map<String, Object?> metadata,
        String name,
        double? price,
        Optional<double> quantity,
      })
    >
    items,
    double total,
  })
  i,
});
typedef Query120Return = ({
  ({
    List<
      ({
        String id,
        Map<String, Object?> metadata,
        String name,
        double? price,
        Optional<double> quantity,
      })
    >
    items,
    double total,
  })
  i,
});
typedef Query121Args = ({
  List<
    ({
      List<
        ({
          Union2<String, ({List<String> media, String text})> content,
          String id,
          double likes,
          List<String> tags,
        })
      >
      posts,
      ({
        Map<String, Union3<String, double, bool>> preferences,
        ({Optional<String> avatar, String name}) profile,
      })
      user,
    })
  >
  i,
});
typedef Query121Return = ({
  List<
    ({
      List<
        ({
          Union2<String, ({List<String> media, String text})> content,
          String id,
          double likes,
          List<String> tags,
        })
      >
      posts,
      ({
        Map<String, Union3<String, double, bool>> preferences,
        ({Optional<String> avatar, String name}) profile,
      })
      user,
    })
  >
  i,
});
typedef Query122Args = ({
  Map<
    String,
    ({
      bool required,
      Union3<
        ({$string$number$boolean primitive}),
        ({Map<String, String> fields}),
        ({String elementType})
      >
      schema,
      $primitive$object$array type,
    })
  >
  i,
});
typedef Query122Return = ({
  Map<
    String,
    ({
      bool required,
      Union3<
        ({$string$number$boolean primitive}),
        ({Map<String, String> fields}),
        ({String elementType})
      >
      schema,
      $primitive$object$array type,
    })
  >
  i,
});
typedef Query123Args = ({
  Union3<
    ({
      String content,
      Optional<({bool bold, $red$blue$green color, bool italic})> formatting,
      $text type,
    }),
    ({
      Optional<String> alt,
      ({double height, double width}) dimensions,
      $image type,
      String url,
    }),
    ({List<String> items, bool ordered, $list type})
  >
  i,
});
typedef Query123Return = ({
  Union3<
    ({
      String content,
      Optional<({bool bold, $red$blue$green color, bool italic})> formatting,
      $text type,
    }),
    ({
      Optional<String> alt,
      ({double height, double width}) dimensions,
      $image type,
      String url,
    }),
    ({List<String> items, bool ordered, $list type})
  >
  i,
});
typedef Query124Args = ({
  ({
    ({
      Map<
        String,
        ({
          Optional<bool> auth,
          $get$post$put$delete method,
          Map<String, Union3<String, double, bool>> params,
          String path,
          Object? response,
        })
      >
      endpoints,
      ({double requests, $minute$hour$day window}) rateLimit,
    })
    api,
    ({
      Map<
        String,
        ({
          List<({List<String> fields, String name, bool unique})> indexes,
          Map<String, $string$number$boolean$date> schema,
        })
      >
      tables,
    })
    database,
  })
  i,
});
typedef Query124Return = ({
  ({
    ({
      Map<
        String,
        ({
          Optional<bool> auth,
          $get$post$put$delete method,
          Map<String, Union3<String, double, bool>> params,
          String path,
          Object? response,
        })
      >
      endpoints,
      ({double requests, $minute$hour$day window}) rateLimit,
    })
    api,
    ({
      Map<
        String,
        ({
          List<({List<String> fields, String name, bool unique})> indexes,
          Map<String, $string$number$boolean$date> schema,
        })
      >
      tables,
    })
    database,
  })
  i,
});
typedef Query125Args = ({
  ({
    ({
      List<
        ({
          Map<String, Object?> config,
          Optional<({String handler, ({double count, double delay}) retry})>
          error,
          String id,
          String name,
          Optional<String> next,
          $action$condition$loop type,
        })
      >
      steps,
      List<
        Union3<
          ({String cron, $schedule type}),
          ({$webhook type, String url}),
          ({String eventType, $event type})
        >
      >
      triggers,
      Map<String, Union4<String, double, bool, List<Object?>>> variables,
    })
    workflow,
  })
  i,
});
typedef Query125Return = ({
  ({
    ({
      List<
        ({
          Map<String, Object?> config,
          Optional<({String handler, ({double count, double delay}) retry})>
          error,
          String id,
          String name,
          Optional<String> next,
          $action$condition$loop type,
        })
      >
      steps,
      List<
        Union3<
          ({String cron, $schedule type}),
          ({$webhook type, String url}),
          ({String eventType, $event type})
        >
      >
      triggers,
      Map<String, Union4<String, double, bool, List<Object?>>> variables,
    })
    workflow,
  })
  i,
});
typedef Query126Args = ({({$action$condition$loop stepType}) i});
typedef Query126Return = ({({$action$condition$loop stepType}) i});
typedef Query127Args = ({
  ({Map<String, Union4<String, double, bool, List<Object?>>> variables}) i,
});
typedef Query127Return = ({
  ({Map<String, Union4<String, double, bool, List<Object?>>> variables}) i,
});
typedef Query128Args = ({
  ({
    List<
      Union3<
        ({String cron, $schedule type}),
        ({$webhook type, String url}),
        ({String eventType, $event type})
      >
    >
    triggers,
  })
  i,
});
typedef Query128Return = ({
  ({
    List<
      Union3<
        ({String cron, $schedule type}),
        ({$webhook type, String url}),
        ({String eventType, $event type})
      >
    >
    triggers,
  })
  i,
});
typedef Query129Args = ({
  ({Optional<({String handler, ({double count, double delay}) retry})> error})
  i,
});
typedef Query129Return = ({
  ({Optional<({String handler, ({double count, double delay}) retry})> error})
  i,
});
typedef Query130Args = ({
  ({
    List<
      ({
        Map<String, Object?> config,
        String id,
        String name,
        Optional<String> next,
      })
    >
    steps,
  })
  i,
});
typedef Query130Return = ({
  ({
    List<
      ({
        Map<String, Object?> config,
        String id,
        String name,
        Optional<String> next,
      })
    >
    steps,
  })
  i,
});
typedef Query131Args = ({
  ({
    List<
      ({
        Optional<({String handler, ({double count, double delay}) retry})>
        error,
        $action$condition$loop type,
      })
    >
    steps,
    List<
      Union3<
        ({String cron, $schedule type}),
        ({$webhook type, String url}),
        ({String eventType, $event type})
      >
    >
    triggers,
    Map<String, Union4<String, double, bool, List<Object?>>> variables,
  })
  i,
});
typedef Query131Return = ({
  ({
    List<
      ({
        Optional<({String handler, ({double count, double delay}) retry})>
        error,
        $action$condition$loop type,
      })
    >
    steps,
    List<
      Union3<
        ({String cron, $schedule type}),
        ({$webhook type, String url}),
        ({String eventType, $event type})
      >
    >
    triggers,
    Map<String, Union4<String, double, bool, List<Object?>>> variables,
  })
  i,
});
typedef Query132Args = ({({List<({String b})> a}) i});
typedef Query132Return = ({({List<({String b})> a}) i});
typedef Query133Args = ({({Optional<Map<String, double>> a}) i});
typedef Query133Return = ({({Optional<Map<String, double>> a}) i});
typedef Query134Args = ({({Union2<String, List<bool>> a}) i});
typedef Query134Return = ({({Union2<String, List<bool>> a}) i});
typedef Query135Args = ({List<({String a, Optional<double> b})> i});
typedef Query135Return = ({List<({String a, Optional<double> b})> i});
typedef Query137Args = ({
  Union2<({String a, $A type}), ({double b, $B type})> i,
});
typedef Query137Return = ({
  Union2<({String a, $A type}), ({double b, $B type})> i,
});
typedef Query138Args = ({Union2<List<String>, Map<String, double>> i});
typedef Query138Return = ({Union2<List<String>, Map<String, double>> i});
typedef Query139Args = ({Map<String, ({List<Object?> a})> i});
typedef Query139Return = ({Map<String, ({List<Object?> a})> i});
typedef Query141Args = ({({({({List<({String d})> c}) b}) a}) i});
typedef Query141Return = ({({({({List<({String d})> c}) b}) a}) i});
typedef Query144Args = ({String arg1, double arg2, bool arg3});
typedef Query144Return = ({String arg1, double arg2, bool arg3});
typedef Query146Args = ({({Uint8List data, Optional<Object?> metadata}) i});
typedef Query146Return = ({({Uint8List data, Optional<Object?> metadata}) i});
typedef Query148Args = ({Map<String, List<ItemsId>> i});
typedef Query148Return = ({Map<String, List<ItemsId>> i});
typedef Query149Args = ({({$foo a, $123_0 b, $false c}) i});
typedef Query149Return = ({({$foo a, $123_0 b, $false c}) i});
typedef Query150Args = ({List<Union3<String, double, bool>> i});
typedef Query150Return = ({List<Union3<String, double, bool>> i});
typedef Query151Args = ({({List<BigInt> a}) i});
typedef Query151Return = ({({List<BigInt> a}) i});
typedef Query152Args = ({Map<String, bool> i});
typedef Query152Return = ({Map<String, bool> i});
typedef Query153Args = ({Union2<Uint8List, String> i});
typedef Query153Return = ({Union2<Uint8List, String> i});
typedef Query154Args = ({List<$a> i});
typedef Query154Return = ({List<$a> i});
typedef Query155Args = ({Optional<UsersId> i});
typedef Query155Return = ({Optional<UsersId> i});
typedef Query156Args = ({Object? i});
typedef Query156Return = ({Object? i});
typedef Query157Args = ({Map<String, Object?> i});
typedef Query157Return = ({Map<String, Object?> i});
typedef Query158Args = ({({String a, double b}) i});
typedef Query158Return = ({({String a, double b}) i});
typedef Query159Args = ({$10$20 i});
typedef Query159Return = ({$10$20 i});
typedef Query161Args = ({({Optional<String> a}) i});
typedef Query161Return = ({({Optional<String> a}) i});
typedef Query163Args = ({Union2<AId, BId> i});
typedef Query163Return = ({Union2<AId, BId> i});
typedef Query164Args = ({List<Uint8List> i});
typedef Query164Return = ({List<Uint8List> i});
typedef Query165Args = ({Optional<Object?> i});
typedef Query165Return = ({Optional<Object?> i});
typedef Query166Args = ({({({bool b}) a}) i});
typedef Query166Return = ({({({bool b}) a}) i});
typedef Query167Args = ({Map<String, PostsId> i});
typedef Query167Return = ({Map<String, PostsId> i});
typedef Query168Args = ({String? i});
typedef Query168Return = ({String? i});
typedef Query169Args = ({List<List<String>> i});
typedef Query169Return = ({List<List<String>> i});
typedef Query170Args = ({$helloworld i});
typedef Query170Return = ({$helloworld i});
typedef Query171Args = ({({String a, Optional<double> b, List<bool> c}) i});
typedef Query171Return = ({({String a, Optional<double> b, List<bool> c}) i});
typedef Query172Args = ({Map<String, Union2<String, double>> i});
typedef Query172Return = ({Map<String, Union2<String, double>> i});
typedef Query173Args = ({Union2<({$A type}), ({$B type})> i});
typedef Query173Return = ({Union2<({$A type}), ({$B type})> i});
typedef Query174Args = ({List<Object?> i});
typedef Query174Return = ({List<Object?> i});
typedef Query175Args = ({Optional<Uint8List> i});
typedef Query175Return = ({Optional<Uint8List> i});
typedef Query176Args = ({({Map<String, ({double lastUpdated})> metadata}) i});
typedef Query176Return = ({({Map<String, ({double lastUpdated})> metadata}) i});
typedef Query177Args = ({Map<String, BigInt> i});
typedef Query177Return = ({Map<String, BigInt> i});
typedef Query178Args = ({Union2<List<String>, List<double>> i});
typedef Query178Return = ({Union2<List<String>, List<double>> i});
typedef Query179Args = ({List<MessagesId> i});
typedef Query179Return = ({List<MessagesId> i});
typedef Query180Args = ({$3_14 i});
typedef Query180Return = ({$3_14 i});
typedef Query181Args = ({({({({String value}) nested}) deeply}) i});
typedef Query181Return = ({({({({String value}) nested}) deeply}) i});
typedef Query183Args = ({Union2<({String a}), ({double a})> i});
typedef Query183Return = ({Union2<({String a}), ({double a})> i});
typedef Query184Args = ({List<Map<String, bool>> i});
typedef Query184Return = ({List<Map<String, bool>> i});
typedef Query185Args = ({Optional<$on> i});
typedef Query185Return = ({Optional<$on> i});
typedef Query186Args = ({({List<$read$write$admin> permissions}) i});
typedef Query186Return = ({({List<$read$write$admin> permissions}) i});
typedef Query187Args = ({Map<String, Map<String, String>> i});
typedef Query187Return = ({Map<String, Map<String, String>> i});
typedef Query188Args = ({Union2<Object?, FallbackId> i});
typedef Query188Return = ({Union2<Object?, FallbackId> i});
typedef Query189Args = ({List<({List<NodesId> children, NodesId id})> i});
typedef Query189Return = ({List<({List<NodesId> children, NodesId id})> i});
typedef Query190Args = ({$true i});
typedef Query190Return = ({$true i});
typedef Query191Args = ({AnotherTableId i});
typedef Query191Return = ({AnotherTableId i});
typedef Query192Args = ({BigInt i});
typedef Query192Return = ({BigInt i});
typedef Query193Args = ({Uint8List i});
typedef Query193Return = ({Uint8List i});
typedef Query194Args = ({Optional<bool> i});
typedef Query194Return = ({Optional<bool> i});
typedef Query195Args = ({double? i});
typedef Query195Return = ({double? i});
typedef Query196Args = ({List<String> i});
typedef Query196Return = ({List<String> i});
typedef Query197Args = ({Map<String, double> i});
typedef Query197Return = ({Map<String, double> i});
typedef Query198Args = ({({String name, Object? value}) i});
typedef Query198Return = ({({String name, Object? value}) i});
typedef Query199Args = ({$a$b$c i});
typedef Query199Return = ({$a$b$c i});
typedef Query201Args = ({({String a, String b}) i});
typedef Query201Return = ({({String a, String b}) i});
typedef Query203Args = ({Union2<String, double> i});
typedef Query203Return = ({Union2<String, double> i});
typedef Query204Args = ({List<BigInt> i});
typedef Query204Return = ({List<BigInt> i});
typedef Query205Args = ({Optional<Map<String, String>> i});
typedef Query205Return = ({Optional<Map<String, String>> i});
typedef Query206Args = ({({List<({double value})> data}) i});
typedef Query206Return = ({({List<({double value})> data}) i});
typedef Query208Args = ({$on$off i});
typedef Query208Return = ({$on$off i});
typedef Query209Args = ({List<String?> i});
typedef Query209Return = ({List<String?> i});
typedef Query210Args = ({$_1_0 i});
typedef Query210Return = ({$_1_0 i});
typedef Query211Args = ({({List<String> tags}) i});
typedef Query211Return = ({({List<String> tags}) i});
typedef Query212Args = ({Map<String, List<Object?>> i});
typedef Query212Return = ({Map<String, List<Object?>> i});
typedef Query213Args = ({Union2<UsersId, AdminsId> i});
typedef Query213Return = ({Union2<UsersId, AdminsId> i});
typedef Query214Args = ({List<({String id, double score})> i});
typedef Query214Return = ({List<({String id, double score})> i});
typedef Query215Args = ({Optional<List<bool>> i});
typedef Query215Return = ({Optional<List<bool>> i});
typedef Query216Args = ({({Object? payload, double timestamp}) i});
typedef Query216Return = ({({Object? payload, double timestamp}) i});
typedef Query217Args = ({Map<String, $value> i});
typedef Query217Return = ({Map<String, $value> i});
typedef Query218Args = ({
  Union2<({Object? data, $true success}), ({String error, $false success})> i,
});
typedef Query218Return = ({
  Union2<({Object? data, $true success}), ({String error, $false success})> i,
});
typedef Query219Args = ({List<Map<String, Object?>> i});
typedef Query219Return = ({List<Map<String, Object?>> i});
typedef Query220Args = ({$ i});
typedef Query220Return = ({$ i});
typedef Query221Args = ({({Optional<({String b})> a}) i});
typedef Query221Return = ({({Optional<({String b})> a}) i});
typedef Query223Args = ({Union2<BigInt, Uint8List> i});
typedef Query223Return = ({Union2<BigInt, Uint8List> i});
typedef Query224Args = ({List<$cat$dog> i});
typedef Query224Return = ({List<$cat$dog> i});
typedef Query225Args = ({Optional<Union2<String, double>> i});
typedef Query225Return = ({Optional<Union2<String, double>> i});
