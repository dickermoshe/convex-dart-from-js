// ignore_for_file: type=lint, unused_import, unnecessary_question_mark, dead_code, dead_null_aware_expression
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter, invalid_use_of_internal_member
import "dart:typed_data";
import "package:convex_dart/convex_dart.dart";
import "package:convex_dart/src/optional.dart";
import "package:convex_dart/src/union.dart";
import "../schema.dart";
import "../literals.dart";

final voidReturn = VoidReturn();

class VoidReturn extends ConvexQuery<Null, VoidReturnReturn> {
  VoidReturn() : super("primitive_returns:voidReturn");

  @override
  Map<String, Object?> parseArgs(Null args) {
    return <String, Object?>{};
  }

  @override
  Null parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return null;
  }

  @override
  VoidReturnReturn parseReturns(Object? returns) {
    return returns;
  }
}

final strReturn = StrReturn();

class StrReturn extends ConvexQuery<Null, StrReturnReturn> {
  StrReturn() : super("primitive_returns:strReturn");

  @override
  Map<String, Object?> parseArgs(Null args) {
    return <String, Object?>{};
  }

  @override
  Null parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return null;
  }

  @override
  StrReturnReturn parseReturns(Object? returns) {
    return (returns as String);
  }
}

final numReturn = NumReturn();

class NumReturn extends ConvexQuery<Null, NumReturnReturn> {
  NumReturn() : super("primitive_returns:numReturn");

  @override
  Map<String, Object?> parseArgs(Null args) {
    return <String, Object?>{};
  }

  @override
  Null parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return null;
  }

  @override
  NumReturnReturn parseReturns(Object? returns) {
    return (returns as num).toDouble();
  }
}

final boolReturn = BoolReturn();

class BoolReturn extends ConvexQuery<Null, BoolReturnReturn> {
  BoolReturn() : super("primitive_returns:boolReturn");

  @override
  Map<String, Object?> parseArgs(Null args) {
    return <String, Object?>{};
  }

  @override
  Null parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return null;
  }

  @override
  BoolReturnReturn parseReturns(Object? returns) {
    return (returns as bool);
  }
}

final int64Return = Int64Return();

class Int64Return extends ConvexQuery<Null, Int64ReturnReturn> {
  Int64Return() : super("primitive_returns:int64Return");

  @override
  Map<String, Object?> parseArgs(Null args) {
    return <String, Object?>{};
  }

  @override
  Null parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return null;
  }

  @override
  Int64ReturnReturn parseReturns(Object? returns) {
    return (returns as BigInt);
  }
}

final bytesReturn = BytesReturn();

class BytesReturn extends ConvexQuery<Null, BytesReturnReturn> {
  BytesReturn() : super("primitive_returns:bytesReturn");

  @override
  Map<String, Object?> parseArgs(Null args) {
    return <String, Object?>{};
  }

  @override
  Null parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return null;
  }

  @override
  BytesReturnReturn parseReturns(Object? returns) {
    return (returns as Uint8List);
  }
}

final nullReturn = NullReturn();

class NullReturn extends ConvexQuery<Null, NullReturnReturn> {
  NullReturn() : super("primitive_returns:nullReturn");

  @override
  Map<String, Object?> parseArgs(Null args) {
    return <String, Object?>{};
  }

  @override
  Null parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return null;
  }

  @override
  NullReturnReturn parseReturns(Object? returns) {
    return null;
  }
}

final unionReturn = UnionReturn();

class UnionReturn extends ConvexQuery<Null, UnionReturnReturn> {
  UnionReturn() : super("primitive_returns:unionReturn");

  @override
  Map<String, Object?> parseArgs(Null args) {
    return <String, Object?>{};
  }

  @override
  Null parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return null;
  }

  @override
  UnionReturnReturn parseReturns(Object? returns) {
    return Union2<String, double>(() {
      try {
        return (returns as String);
      } catch (e) {}

      try {
        return (returns as num).toDouble();
      } catch (e) {}

      throw Exception(
        (returns.toString()) +
            r" cannot be deserialized into a Union2<String, double>",
      );
    }());
  }
}

final arrayReturn = ArrayReturn();

class ArrayReturn extends ConvexQuery<Null, ArrayReturnReturn> {
  ArrayReturn() : super("primitive_returns:arrayReturn");

  @override
  Map<String, Object?> parseArgs(Null args) {
    return <String, Object?>{};
  }

  @override
  Null parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return null;
  }

  @override
  ArrayReturnReturn parseReturns(Object? returns) {
    return (returns as List)
        .map<String>((_v0) => (_v0 as String))
        .toList(growable: false);
  }
}

final idReturn = IdReturn();

class IdReturn extends ConvexQuery<Null, IdReturnReturn> {
  IdReturn() : super("primitive_returns:idReturn");

  @override
  Map<String, Object?> parseArgs(Null args) {
    return <String, Object?>{};
  }

  @override
  Null parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return null;
  }

  @override
  IdReturnReturn parseReturns(Object? returns) {
    return TasksId(returns as String);
  }
}

final recordReturn = RecordReturn();

class RecordReturn extends ConvexQuery<Null, RecordReturnReturn> {
  RecordReturn() : super("primitive_returns:recordReturn");

  @override
  Map<String, Object?> parseArgs(Null args) {
    return <String, Object?>{};
  }

  @override
  Null parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return null;
  }

  @override
  RecordReturnReturn parseReturns(Object? returns) {
    return (returns as Map).cast<String, Object?>().map(
      (_v0, _v1) => MapEntry(_v0, (_v1 as String)),
    );
  }
}

final anyReturn = AnyReturn();

class AnyReturn extends ConvexQuery<Null, AnyReturnReturn> {
  AnyReturn() : super("primitive_returns:anyReturn");

  @override
  Map<String, Object?> parseArgs(Null args) {
    return <String, Object?>{};
  }

  @override
  Null parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return null;
  }

  @override
  AnyReturnReturn parseReturns(Object? returns) {
    return returns;
  }
}

final objectReturn = ObjectReturn();

class ObjectReturn extends ConvexQuery<Null, ObjectReturnReturn> {
  ObjectReturn() : super("primitive_returns:objectReturn");

  @override
  Map<String, Object?> parseArgs(Null args) {
    return <String, Object?>{};
  }

  @override
  Null parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return null;
  }

  @override
  ObjectReturnReturn parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (i: (_v0['i'] as String));
    })();
  }
}

final privateObjectReturn = PrivateObjectReturn();

class PrivateObjectReturn extends ConvexQuery<Null, PrivateObjectReturnReturn> {
  PrivateObjectReturn() : super("primitive_returns:privateObjectReturn");

  @override
  Map<String, Object?> parseArgs(Null args) {
    return <String, Object?>{};
  }

  @override
  Null parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return null;
  }

  @override
  PrivateObjectReturnReturn parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (i: (_v0['_i'] as String));
    })();
  }
}

final emptyObjectArgsReturn = EmptyObjectArgsReturn();

class EmptyObjectArgsReturn
    extends ConvexQuery<Null, EmptyObjectArgsReturnReturn> {
  EmptyObjectArgsReturn() : super("primitive_returns:emptyObjectArgsReturn");

  @override
  Map<String, Object?> parseArgs(Null args) {
    return <String, Object?>{};
  }

  @override
  Null parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return null;
  }

  @override
  EmptyObjectArgsReturnReturn parseReturns(Object? returns) {
    return returns;
  }
}

typedef VoidReturnReturn = Object?;
typedef StrReturnReturn = String;
typedef NumReturnReturn = double;
typedef BoolReturnReturn = bool;
typedef Int64ReturnReturn = BigInt;
typedef BytesReturnReturn = Uint8List;
typedef NullReturnReturn = Null;
typedef UnionReturnReturn = Union2<String, double>;
typedef ArrayReturnReturn = List<String>;
typedef IdReturnReturn = TasksId;
typedef RecordReturnReturn = Map<String, String>;
typedef AnyReturnReturn = Object?;
typedef ObjectReturnReturn = ({String i});
typedef PrivateObjectReturnReturn = ({String i});
typedef EmptyObjectArgsReturnReturn = Object?;
