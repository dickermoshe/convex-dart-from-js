// ignore_for_file: constant_identifier_names

import 'package:dart_mappable/dart_mappable.dart';
import 'package:equatable/equatable.dart';
import 'package:recase/recase.dart';
import 'package:path/path.dart' as path;
import 'package:collection/collection.dart';
import 'package:dart_style/dart_style.dart';
part 'types.mapper.dart';

final deepEqual = DeepCollectionEquality.unordered();
final formatter = DartFormatter(
  languageVersion: DartFormatter.latestLanguageVersion,
);

class ClientBuildContext {
  final Map<String, String> outputs = {};
  final Set<JsLiteral> literals = {};
  // ignore: library_private_types_in_public_api
  final Set<_LiteralsUnion> enums = {};
  final Set<String> tables = {};
  ClientBuildContext();
}

class FunctionBuildContext {
  final StringBuffer headerBuffer = StringBuffer();
  final StringBuffer functionBuffer = StringBuffer();
  final StringBuffer typedefBuffer = StringBuffer();
  final TempNameAllocator tempNames = TempNameAllocator();

  final ClientBuildContext clientContext;
  FunctionBuildContext(this.clientContext);

  void resetTempNames() {
    tempNames.reset();
  }
}

class TempNameAllocator {
  int _next = 0;

  String next() {
    return '_v${_next++}';
  }

  void reset() {
    _next = 0;
  }
}

/// A generated Convex function plus the module import metadata needed by
/// client.dart.
class BuiltFunctionSpec {
  BuiltFunctionSpec({required this.function});

  final FunctionSpec function;

  String get importPath =>
      './functions/${path.posix.joinAll(function.modulePathParts)}';

  List<String> get apiPathParts => [
    ...function.convexFunctionIdentifier.split(':').first.split('/'),
    function.functionName,
  ];
}

@MappableClass()
class FunctionsSpec with FunctionsSpecMappable {
  final String url;
  final List<BaseFunctionSpec> functions;

  FunctionsSpec(this.url, this.functions);

  Future<void> build(
    ClientBuildContext context, {
    required bool publicSerialize,
  }) async {
    final moduleContexts = <String, FunctionBuildContext>{};
    final builtFunctionSpecs = <BuiltFunctionSpec>[];

    // Create the functions
    for (final function in functions.whereType<FunctionSpec>()) {
      try {
        // Skip internal functions
        if (function.visibility.kind == VisibilityType.internal) {
          continue;
        }
        // Build the function into the Dart file matching its source module.
        final filePath = path.posix.joinAll([
          'functions',
          ...function.modulePathParts,
        ]);
        final functionContext = moduleContexts.putIfAbsent(
          filePath,
          () => FunctionBuildContext(context),
        );
        function.build(functionContext, publicSerialize: publicSerialize);
        builtFunctionSpecs.add(BuiltFunctionSpec(function: function));
      } catch (e, stackTrace) {
        // ignore: avoid_print
        print(
          'ERROR: Failed to build function ${function.convexFunctionIdentifier}\n'
          '  Function Type: ${function.functionType}\n'
          '  Visibility: ${function.visibility.kind.name}\n'
          '  Error: $e\n'
          '  Stack Trace: $stackTrace\n'
          '\nTroubleshooting:\n'
          '  1. Check the function signature and return type\n'
          '  2. Ensure all types are supported by the Dart client\n'
          '  3. Verify the function exports are correct\n'
          '  4. Consider simplifying complex union types',
        );
      }
    }

    for (final entry in moduleContexts.entries) {
      final functionContext = entry.value;
      context.outputs[entry.key] =
          '${functionContext.headerBuffer}'
          '\n${functionContext.functionBuffer}'
          '\n${functionContext.typedefBuffer}';
    }

    // Create the client.dart file
    _buildClient(
      context,
      functions.whereType<HttpFunctionSpec>(),
      builtFunctionSpecs,
    );
    // Create the schema.dart file
    _buildSchema(context);
    // Create the literals.dart file
    _buildLiterals(context);
    // Format the code
    int formattedCount = 0;
    int formatFailedCount = 0;
    for (final entry in context.outputs.entries) {
      try {
        context.outputs[entry.key] = formatter.format(entry.value);
        formattedCount++;
      } catch (e) {
        formatFailedCount++;
        // ignore: avoid_print
        print(
          'WARNING: Failed to format generated file ${entry.key}\n'
          '  Error: $e\n'
          '  The file will still be generated but may not be properly formatted.\n'
          "  You can manually format it using 'dart format' after generation.",
        );
      }
    }

    if (formatFailedCount > 0) {
      // ignore: avoid_print
      print(
        'Code formatting summary: $formattedCount files formatted successfully, '
        '$formatFailedCount files failed formatting but were still generated.',
      );
    }
  }

  void _buildSchema(ClientBuildContext context) {
    final schemaBuffer = StringBuffer("""
// ignore_for_file: type=lint, unused_import, unnecessary_question_mark, dead_code,unnecessary_non_null_assertion
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter, invalid_use_of_internal_member
import "dart:typed_data";
import 'dart:async';
import "package:convex_dart/convex_dart.dart";
""");
    for (final tableName in context.tables) {
      schemaBuffer.writeln('''
class ${tableName.pascalCase}Id  implements TableId {
  @override
  final String name;
  static const String tableName = "$tableName";
  const ${tableName.pascalCase}Id(this.name);
  @override
  bool operator ==(Object other) {
    if (other is ${tableName.pascalCase}Id) {
      return name == other.name;
    }
    return false;
  }

  @override
  int get hashCode => name.hashCode;

  @override
  String toString() {
    return name;
  }
}
''');
    }
    context.outputs[path.posix.join('schema.dart')] = schemaBuffer.toString();
  }

  void _buildClient(
    ClientBuildContext context,
    Iterable<HttpFunctionSpec> httpFunctions,
    Iterable<BuiltFunctionSpec> builtFunctionSpecs,
  ) {
    final builtSpecs = builtFunctionSpecs.toList();
    final httpFunctionsBuffer = StringBuffer();
    for (final httpFunction in httpFunctions) {
      try {
        httpFunctionsBuffer.writeln(httpFunction.build());
      } catch (e) {
        // ignore: avoid_print
        print(
          'WARNING: Skipping function ${httpFunction.method.name} ${httpFunction.path} due to error: $e',
        );
      }
    }

    final importPrefixes = <String, String>{};
    for (final spec in builtSpecs) {
      importPrefixes.putIfAbsent(
        spec.importPath,
        () => 'functions${importPrefixes.length}',
      );
    }
    final moduleImports = importPrefixes.entries
        .map((entry) => 'import "${entry.key}" as ${entry.value};')
        .join('\n');

    final tree = TreeNode();
    for (final spec in builtSpecs) {
      var root = tree;
      for (final part in spec.apiPathParts.take(spec.apiPathParts.length - 1)) {
        final node = root.children.putIfAbsent(part, () => TreeNode());
        if (node is! TreeNode) {
          throw StateError(
            "Unable to build API: A function cannot have the same name as a folder. Found both a folder and a function named '$part'.",
          );
        }
        root = node;
      }
      final leafName = spec.apiPathParts.last;
      final existing = root.children.putIfAbsent(
        leafName,
        () => LeafNode(spec),
      );
      if (existing is! LeafNode || existing.function != spec) {
        throw StateError(
          "Unable to build API: duplicate generated API member '$leafName'.",
        );
      }
    }

    context.outputs[path.posix.join('client.dart')] =
        '''
// ignore_for_file: type=lint, unused_import, unnecessary_question_mark, dead_code, unnecessary_non_null_assertion
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter, invalid_use_of_internal_member
import "dart:convert" as \$convert;

import "package:convex_dart/convex_dart.dart";
import "package:http/http.dart" as \$http;

$moduleImports

class MyConvexClient extends ConvexHttpClient {
  MyConvexClient({ConvexHttpClientOptions? options})
    : super("$url", options: options);

  final String httpUrl = "${_httpActionUrl(url)}";

$httpFunctionsBuffer
}

class MyConvexWebsocketClient extends ConvexClient {
  MyConvexWebsocketClient({
    ConvexClientOptions options = const ConvexClientOptions(),
  }) : super("$url", options: options);
}

${tree.children.isNotEmpty ? 'final api = ${tree.build(importPrefixes)};' : ''}
''';
  }

  String _httpActionUrl(String deploymentUrl) {
    final uri = Uri.tryParse(deploymentUrl);
    if (uri != null &&
        (uri.host == '127.0.0.1' || uri.host == 'localhost') &&
        uri.hasPort &&
        uri.port == 3210) {
      return uri.replace(port: 3211).toString();
    }
    return deploymentUrl.replaceAll(RegExp(r'\.cloud$'), '.site');
  }

  void _buildLiterals(ClientBuildContext context) {
    final literalsBuffer = StringBuffer('''
// ignore_for_file: type=lint, unused_import, unnecessary_question_mark, dead_code,unnecessary_non_null_assertion
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_raw_type, inference_failure_on_untyped_parameter, invalid_use_of_internal_member
import "package:convex_dart/convex_dart.dart";
''');

    for (final $enum in context.enums) {
      literalsBuffer.writeln($enum.enumCode(context));
    }
    for (final literal in context.literals) {
      literalsBuffer.writeln(literal._literalCode);
    }
    context.outputs[path.posix.join('literals.dart')] = literalsBuffer
        .toString();
  }
}

sealed class BaseNode {}

class TreeNode extends BaseNode {
  final children = <String, BaseNode>{};

  String build(Map<String, String> importPrefixes) {
    final buffer = StringBuffer('(\n');
    for (final child in children.entries) {
      final key = stringToDart(child.key).camelCase;
      switch (child.value) {
        case TreeNode treeNode:
          buffer.write('$key: ${treeNode.build(importPrefixes)},\n');
        case LeafNode(:final function):
          final importPrefix = importPrefixes[function.importPath];
          if (importPrefix == null) {
            throw StateError(
              'Missing import prefix for ${function.importPath}',
            );
          }
          buffer.write(
            '$key: $importPrefix.${function.function.dartFunctionName},\n',
          );
      }
    }
    buffer.write(')');
    return buffer.toString();
  }
}

class LeafNode extends BaseNode {
  final BuiltFunctionSpec function;
  LeafNode(this.function);
}

@MappableEnum(mode: ValuesMode.named)
enum VisibilityType {
  @MappableValue('public')
  public,
  @MappableValue('internal')
  internal,
}

@MappableClass()
class Visibility with VisibilityMappable {
  final VisibilityType kind;
  const Visibility(this.kind);
}

class EmptyObjectToAnyHook extends MappingHook {
  const EmptyObjectToAnyHook();
  @override
  dynamic afterDecode(dynamic value) {
    if (value == null) {
      return JsAny('any');
    }
    if (value is JsObject && value.value.isEmpty) {
      return JsAny('any');
    }
    return value;
  }
}

@MappableEnum(mode: ValuesMode.named)
enum HttpMethod {
  @MappableValue('GET')
  GET,
  @MappableValue('POST')
  POST,
  @MappableValue('PUT')
  PUT,
  @MappableValue('DELETE')
  DELETE,
  @MappableValue('OPTIONS')
  OPTIONS,
  @MappableValue('PATCH')
  PATCH,
}

@MappableClass()
sealed class BaseFunctionSpec with BaseFunctionSpecMappable {
  final String functionType;
  const BaseFunctionSpec(this.functionType);
}

@MappableClass(discriminatorValue: HttpFunctionSpec.checkType)
class HttpFunctionSpec extends BaseFunctionSpec with HttpFunctionSpecMappable {
  final HttpMethod method;
  final String path;
  const HttpFunctionSpec(super.functionType, this.method, this.path);
  static bool checkType(dynamic value) {
    return value is Map && value['functionType'] == 'HttpAction';
  }

  String build() {
    if (method == HttpMethod.OPTIONS) {
      throw StateError('OPTIONS requests are not supported');
    }
    final buffer = StringBuffer('Future<\$http.Response> ');
    final hasSuffix = path.endsWith('*');
    final pathWithoutSuffix = path.replaceAll(RegExp(r'\*$'), '');

    String methodName = method.name.camelCase + stringToDart(path).pascalCase;
    buffer.write('$methodName({Map<String, String>? headers,');
    if (hasSuffix) {
      buffer.write("String suffix = '',");
    }
    switch (method) {
      case HttpMethod.POST ||
          HttpMethod.PUT ||
          HttpMethod.DELETE ||
          HttpMethod.PATCH:
        buffer.write('Object? body, \$convert.Encoding? encoding,');
      default:
    }
    buffer.writeln('}){');
    buffer.writeln(
      """final uri = Uri.parse(httpUrl + r'$pathWithoutSuffix' ${hasSuffix ? "+ suffix" : ""});""",
    );
    buffer.writeln('return rawHttpAction(');
    switch (method) {
      case HttpMethod.GET:
        buffer.write("'GET',");
      case HttpMethod.POST:
        buffer.write("'POST',");
      case HttpMethod.PUT:
        buffer.write("'PUT',");
      case HttpMethod.DELETE:
        buffer.write("'DELETE',");
      case HttpMethod.PATCH:
        buffer.write("'PATCH',");
      case HttpMethod.OPTIONS:
        throw StateError('Unreachable Area');
    }
    buffer.write('uri,headers:headers,');
    switch (method) {
      case HttpMethod.POST ||
          HttpMethod.PUT ||
          HttpMethod.DELETE ||
          HttpMethod.PATCH:
        buffer.write('body:body,encoding:encoding,');
      default:
    }
    buffer.write(');');

    buffer.write('}');
    return buffer.toString();
  }
}

@MappableClass(discriminatorValue: FunctionSpec.checkType)
class FunctionSpec extends BaseFunctionSpec with FunctionSpecMappable {
  @MappableField(hook: EmptyObjectToAnyHook())
  final JsType args;
  @MappableField(hook: EmptyObjectToAnyHook())
  final JsType returns;
  final String identifier;
  final Visibility visibility;

  const FunctionSpec(
    this.args,
    this.identifier,
    this.visibility,
    super.functionType, [
    this.returns = const JsAny('any'),
  ]);

  static bool checkType(dynamic value) {
    return value is Map && value['functionType'] != 'HttpAction';
  }

  List<String> get pathParts {
    final parts = convexFunctionIdentifier.split(':').first.split('/');
    parts.add("${convexFunctionIdentifier.split(":").last}.dart");

    return parts;
  }

  List<String> get modulePathParts {
    final parts = convexFunctionIdentifier.split(':').first.split('/');
    final moduleName = parts.removeLast();
    parts.add('$moduleName.dart');
    return parts;
  }

  String get functionName {
    return identifier.split(':').last;
  }

  String get dartFunctionName => stringToDart(functionName).camelCase;

  String get className => stringToDart(functionName).pascalCase;

  String get convexFunctionIdentifier {
    // folder/file.ts:fnName
    // remove the .ts
    return identifier.replaceAll(RegExp(r'\.[^.:\s]+(?=:)'), '');
  }

  // The name of the typedef for the arguments
  // e.g. "MyFunctionArgs or void"
  String get argsTypeName {
    switch (args) {
      case JsAny():
        return 'Null';
      case JsObject():
        return '${className}Args';
      default:
        throw UnimplementedError(
          'Unsupported argument type: ${args.type} for the function $functionName.',
        );
    }
  }

  String get returnsTypeName => '${className}Return';

  void build(FunctionBuildContext context, {required bool publicSerialize}) {
    if (context.headerBuffer.isEmpty) {
      final importPathPrefix = List.generate(
        modulePathParts.length,
        (index) => '..',
      ).join('/');

      context.headerBuffer.write('''
// ignore_for_file: type=lint, unused_import, unnecessary_question_mark, dead_code, dead_null_aware_expression, unnecessary_non_null_assertion
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter, invalid_use_of_internal_member
import "dart:typed_data";
import "package:convex_dart/convex_dart.dart";
import "package:convex_dart/src/optional.dart";
import "package:convex_dart/src/union.dart";
import "$importPathPrefix/schema.dart";
import "$importPathPrefix/literals.dart";
''');
    }

    switch (args) {
      case JsAny():
        break;
      case JsObject obj:
        context.typedefBuffer.write(
          'typedef $argsTypeName = ${obj.dartType(context)};',
        );
      default:
        throw ArgumentError(
          'Function arguments must be either JsAny (for dynamic/any type) or JsObject (for structured object types). '
          'Found: ${args.type} for the function $functionName.',
        );
    }

    context.typedefBuffer.write(
      'typedef $returnsTypeName = ${returns.dartType(context)};',
    );

    final baseClass = switch (functionType) {
      'Query' => 'ConvexQuery',
      'Mutation' => 'ConvexMutation',
      'Action' => 'ConvexAction',
      _ => throw UnimplementedError('Unsupported function type: $functionType'),
    };

    final String argsToRawCode;
    if (args is JsAny) {
      argsToRawCode = '<String, Object?>{}';
    } else {
      context.resetTempNames();
      argsToRawCode = args.serialize(context, 'args', nullable: false);
    }

    context.resetTempNames();
    final argsFromRawCode = switch (args) {
      JsAny() => 'null',
      JsObject obj => obj.deserialize(context, 'rawArgs', nullable: false),
      _ => throw ArgumentError(
        'Function arguments must be either JsAny (for dynamic/any type) or JsObject (for structured object types). '
        'Found: ${args.type} for the function $functionName.',
      ),
    };

    context.resetTempNames();
    final returnsFromRawCode = returns.deserialize(
      context,
      'returns',
      nullable: false,
    );

    context.functionBuffer.writeln('''
final $dartFunctionName = $className();

class $className extends $baseClass<$argsTypeName, $returnsTypeName> {
  $className() : super("$convexFunctionIdentifier");

  @override
  Map<String, Object?> parseArgs($argsTypeName args) {
    return $argsToRawCode;
  }

  @override
  $argsTypeName parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return $argsFromRawCode;
  }

  @override
  $returnsTypeName parseReturns(Object? returns) {
    return $returnsFromRawCode;
  }
}
''');
  }
}

@MappableClass()
class JsField with JsFieldMappable {
  final JsType fieldType;
  final bool optional;
  const JsField(this.fieldType, this.optional);
  String dartType(FunctionBuildContext context) {
    String type = fieldType.dartType(context);
    if (optional) {
      type = 'Optional<$type>';
    }
    return type;
  }
}

@MappableClass(discriminatorKey: 'type')
sealed class JsType with JsTypeMappable {
  final String type;

  const JsType(this.type);
  String dartType(FunctionBuildContext context);
  String serialize(
    FunctionBuildContext context,
    String name, {
    required bool nullable,
  });
  String deserialize(
    FunctionBuildContext context,
    String name, {
    required bool nullable,
  });
}

@MappableClass(discriminatorValue: 'any')
class JsAny extends JsType with JsAnyMappable {
  const JsAny(super.type);
  @override
  String dartType(FunctionBuildContext context) => 'Object?';
  @override
  String serialize(
    FunctionBuildContext context,
    String name, {
    required bool nullable,
  }) => name;

  @override
  String deserialize(
    FunctionBuildContext context,
    String name, {
    required bool nullable,
  }) {
    return name;
  }
}

@MappableClass(discriminatorValue: 'boolean')
class JsBoolean extends JsType with JsBooleanMappable {
  const JsBoolean(super.type);
  @override
  String dartType(FunctionBuildContext context) => 'bool';
  @override
  String serialize(
    FunctionBuildContext context,
    String name, {
    required bool nullable,
  }) => name;
  @override
  String deserialize(
    FunctionBuildContext context,
    String name, {
    required bool nullable,
  }) {
    if (nullable) {
      return '$name == null ? null : ($name as bool)';
    }
    return '($name as bool)';
  }
}

@MappableClass(discriminatorValue: 'string')
class JsString extends JsType with JsStringMappable {
  const JsString(super.type);
  @override
  String dartType(FunctionBuildContext context) => 'String';
  @override
  String serialize(
    FunctionBuildContext context,
    String name, {
    required bool nullable,
  }) => name;
  @override
  String deserialize(
    FunctionBuildContext context,
    String name, {
    required bool nullable,
  }) {
    if (nullable) {
      return '$name == null ? null : ($name as String)';
    }
    return '($name as String)';
  }
}

@MappableClass(discriminatorValue: 'number')
class JsNumber extends JsType with JsNumberMappable {
  const JsNumber(super.type);
  @override
  String dartType(FunctionBuildContext context) => 'double';
  @override
  String serialize(
    FunctionBuildContext context,
    String name, {
    required bool nullable,
  }) => name;
  @override
  String deserialize(
    FunctionBuildContext context,
    String name, {
    required bool nullable,
  }) {
    if (nullable) {
      return '$name == null ? null : ($name as num).toDouble()';
    }
    return '($name as num).toDouble()';
  }
}

@MappableClass(discriminatorValue: 'null')
class JsNull extends JsType with JsNullMappable {
  const JsNull(super.type);
  @override
  String dartType(FunctionBuildContext context) => 'Null';
  @override
  String serialize(
    FunctionBuildContext context,
    String name, {
    required bool nullable,
  }) => 'null';
  @override
  String deserialize(
    FunctionBuildContext context,
    String name, {
    required bool nullable,
  }) {
    return 'null';
  }
}

@MappableClass(discriminatorValue: 'bigint')
class JsBigInt extends JsType with JsBigIntMappable {
  const JsBigInt(super.type);
  @override
  String dartType(FunctionBuildContext context) => 'BigInt';
  @override
  String serialize(
    FunctionBuildContext context,
    String name, {
    required bool nullable,
  }) => name;
  @override
  String deserialize(
    FunctionBuildContext context,
    String name, {
    required bool nullable,
  }) {
    if (nullable) {
      return '$name == null ? null : ($name as BigInt)';
    }
    return '($name as BigInt)';
  }
}

@MappableClass(discriminatorValue: 'bytes')
class JsBytes extends JsType with JsBytesMappable {
  const JsBytes(super.type);
  @override
  String dartType(FunctionBuildContext context) => 'Uint8List';
  @override
  String serialize(
    FunctionBuildContext context,
    String name, {
    required bool nullable,
  }) => name;
  @override
  String deserialize(
    FunctionBuildContext context,
    String name, {
    required bool nullable,
  }) {
    if (nullable) {
      return '$name == null ? null : ($name as Uint8List)';
    }
    return '($name as Uint8List)';
  }
}

@MappableClass(discriminatorValue: 'literal')
class JsLiteral extends JsType with JsLiteralMappable {
  final dynamic value;
  const JsLiteral(this.value, super.type);

  /// The name of the class which we will generate for this literal
  String get literalTypeName {
    String buildValue = switch (value) {
      int value => value.toDouble().toString(),
      _ => value.toString(),
    };
    //Replace . with _ (1.0) and - with _ (-50)
    buildValue = buildValue.replaceAll('.', '_').replaceAll('-', '_');
    // Remove any other non-alphanumeric characters
    buildValue = buildValue.replaceAll(RegExp(r'[^a-zA-Z0-9_]'), '');
    // Append a dollar sign to the value
    buildValue = '\$$buildValue';
    return buildValue;
  }

  dynamic get literalValueCode {
    // Ensure that this literal type can be encoded
    if (value is! String &&
        value is! int &&
        value is! double &&
        value is! bool &&
        value != null) {
      throw UnimplementedError(
        'Unsupported literal type: ${value.runtimeType} for value: $value',
      );
    }

    final dynamic valueString;
    if (value is String) {
      valueString = "'$value'";
    } else if (value is int) {
      // It is not possible to use a int literal at this time
      // https://github.com/get-convex/convex-backend/issues/212
      // This means that we can work around issue
      // https://github.com/get-convex/convex-backend/issues/213
      // by converting the int to a double
      valueString = (value as int).toDouble();
    } else {
      valueString = value;
    }
    return valueString;
  }

  // The code of the literal class
  String get _literalCode {
    return '''

class $literalTypeName implements Literal {
  const $literalTypeName();
  const $literalTypeName.validate(dynamic value):assert(value == $literalValueCode, r"Value mismatch for $literalTypeName");
  
  @override
  final value = $literalValueCode; 

  @override
  bool operator ==(Object other) {
    if (other is $literalTypeName) {
      return value == other.value;
    }
    return false;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return r"$literalTypeName($value)";
  }
}
''';
  }

  @override
  String dartType(FunctionBuildContext context) {
    context.clientContext.literals.add(this);
    return literalTypeName;
  }

  @override
  String serialize(
    FunctionBuildContext context,
    String name, {
    required bool nullable,
  }) {
    if (nullable) {
      return '$name == null ? null : $name!.value';
    }
    return '$name.value';
  }

  @override
  String deserialize(
    FunctionBuildContext context,
    String name, {
    required bool nullable,
  }) {
    if (nullable) {
      return '$name == null ? null : $literalTypeName.validate($name)';
    }
    // While we really don't have to, it would be nice to catch any mismatches between
    // the type returned by the backend and the value we expect.
    return '$literalTypeName.validate($name)';
  }
}

sealed class _BaseUnion {
  // Does this union contain a JsNull.
  final bool nullable;
  _BaseUnion({required this.nullable});

  String dartType(FunctionBuildContext context);
  String serialize(
    FunctionBuildContext context,
    String name, {
    required bool nullable,
  });
  String deserialize(
    FunctionBuildContext context,
    String name, {
    required bool nullable,
  });
}

// A union of a single type, this is really just a wrapper around a built in type
class _WrapperUnion extends _BaseUnion {
  final JsType wrappedType;
  _WrapperUnion({required super.nullable, required this.wrappedType});

  @override
  String dartType(FunctionBuildContext context) {
    final wrapped = wrappedType.dartType(context);
    if (nullable && !wrapped.endsWith('?')) {
      return '$wrapped?';
    }
    return wrapped;
  }

  @override
  String serialize(
    FunctionBuildContext context,
    String name, {
    required bool nullable,
  }) {
    nullable = nullable || this.nullable;
    return wrappedType.serialize(context, name, nullable: nullable);
  }

  @override
  String deserialize(
    FunctionBuildContext context,
    String name, {
    required bool nullable,
  }) {
    nullable = nullable || this.nullable;
    return wrappedType.deserialize(context, name, nullable: nullable);
  }
}

// A union of literals, we will use an enhanced enum for this
class _LiteralsUnion extends _BaseUnion with EquatableMixin {
  final Set<JsLiteral> literals;
  _LiteralsUnion({required super.nullable, required this.literals});

  @override
  // Nullable Literal Unions have the same underlying type
  // as non-nullable Literal Unions, we implement the null possibility
  // at the serialization level
  List<Object?> get props => [literals];

  @override
  String dartType(FunctionBuildContext context) {
    context.clientContext.enums.add(this);
    return "$enumName${nullable ? "?" : ""}";
  }

  String get enumName {
    return literals.map((e) => e.literalTypeName.pascalCase).join('');
  }

  String enumCode(ClientBuildContext context) {
    for (final literal in literals) {
      context.literals.add(literal);
    }
    final enumBuffer = StringBuffer('enum $enumName {');
    for (final literal in literals) {
      enumBuffer.writeln(
        '${literal.literalTypeName}Member(${literal.literalTypeName}()),',
      );
    }
    enumBuffer.writeln(';');
    enumBuffer.writeln('''
const $enumName(this.value);
final Literal value;
static final _map = {''');

    for (final literal in literals) {
      enumBuffer.write(
        '${literal.literalValueCode} : ${literal.literalTypeName}Member,',
      );
    }

    enumBuffer.writeln('};');
    enumBuffer.writeln('''
static $enumName fromValue(Object value) {
  if (_map.containsKey(value)) {
    return _map[value] as $enumName;
  }
  throw Exception(value.toString() + r" cannot be converted to a $enumName");
}
''');
    enumBuffer.writeln('}');

    return enumBuffer.toString();
  }

  @override
  String serialize(
    FunctionBuildContext context,
    String name, {
    required bool nullable,
  }) {
    nullable = nullable || this.nullable;
    if (nullable) {
      return '$name == null ? null : $name!.value.value';
    }
    return '$name.value.value';
  }

  @override
  String deserialize(
    FunctionBuildContext context,
    String name, {
    required bool nullable,
  }) {
    if (this.nullable || nullable) {
      return '$name == null ? null : $enumName.fromValue($name as Object)';
    } else {
      return '$enumName.fromValue($name as Object)';
    }
  }
}

// A union of assorted objects, we will use Union#<> for this
class _ObjectsUnion extends _BaseUnion {
  final Iterable<JsType> types;
  _ObjectsUnion({required super.nullable, required this.types});

  @override
  String dartType(FunctionBuildContext context) {
    final type =
        "Union${types.length}<${types.map((e) => e.dartType(context)).join(', ')}>";
    return "$type${nullable ? "?" : ""}";
  }

  @override
  String serialize(
    FunctionBuildContext context,
    String name, {
    required bool nullable,
  }) {
    nullable = nullable || this.nullable;

    final List<String> ons = [];
    for (final type in types) {
      final argName = context.tempNames.next();
      ons.add(
        '($argName) => ${type.serialize(context, argName, nullable: false)}',
      );
    }
    if (nullable) {
      return "$name == null ? null : $name!.split(${ons.join(", ")})";
    }
    return "$name.split(${ons.join(", ")})";
  }

  @override
  String deserialize(
    FunctionBuildContext context,
    String name, {
    required bool nullable,
  }) {
    nullable = nullable || this.nullable;
    String type =
        "Union${types.length}<${types.map((e) => e.dartType(context)).join(', ')}>";
    final fnBuffer = StringBuffer();
    for (final type in types) {
      fnBuffer.writeln('''
try{
  return ${type.deserialize(context, name, nullable: false)};
} catch(e){}
''');
    }
    fnBuffer.writeln('''
throw Exception(($name.toString()) + r" cannot be deserialized into a $type");
''');

    final union = '''$type((){$fnBuffer}())''';
    if (nullable) {
      return '$name == null ? null : $union';
    }
    return union;
  }
}

@MappableClass(discriminatorValue: 'union')
class JsUnion extends JsType with JsUnionMappable {
  final List<JsType> value;
  const JsUnion(this.value, super.type);

  _BaseUnion _buildUnion() {
    final isNullable = value.any((e) => e is JsNull);
    final objects = value.where((e) => e is! JsNull && e is! JsLiteral);
    final literals = value.whereType<JsLiteral>();

    // A union may not contain a String type and a ConvexId type
    // We have no way to differentiate between the two
    // So we need to throw an error
    if (objects.any((e) => e is JsString) && value.any((e) => e is ConvexId)) {
      throw UnimplementedError(
        'A union may not contain a String type and a ConvexId type. If you are seeing this and are having trouble, please file an issue on GitHub.',
      );
    }
    // Ensure we don't have a union between literal and a non-literal type
    if (objects.isNotEmpty && literals.isNotEmpty) {
      throw UnimplementedError(
        'A union may not contain a literal type and a non-literal type. If you are seeing this and are having trouble, please file an issue on GitHub.',
      );
    }
    // A union of more than 9 objects is not supported (Union2..9<> only goes up to Union9)
    if (objects.length > 9) {
      throw UnimplementedError(
        'Your cannot have a union of more than 9 objects',
      );
    }
    if (objects.length == 1) {
      return _WrapperUnion(nullable: isNullable, wrappedType: objects.first);
    }
    if (objects.length > 1) {
      return _ObjectsUnion(nullable: isNullable, types: objects);
    }
    if (literals.length == 1) {
      return _WrapperUnion(nullable: isNullable, wrappedType: literals.first);
    }
    if (literals.length > 1) {
      return _LiteralsUnion(nullable: isNullable, literals: {...literals});
    }

    throw UnimplementedError('Your union most contain at least one real type');
  }

  // Whether this uses the real union type, or is only a nullable type
  bool get isRealUnion => value.where((e) => e is! JsNull).length > 1;

  @override
  String dartType(FunctionBuildContext context) {
    return _buildUnion().dartType(context);
  }

  @override
  String serialize(
    FunctionBuildContext context,
    String name, {
    required bool nullable,
  }) {
    return _buildUnion().serialize(context, name, nullable: nullable);
  }

  @override
  String deserialize(
    FunctionBuildContext context,
    String name, {
    required bool nullable,
  }) {
    return _buildUnion().deserialize(context, name, nullable: nullable);
  }
}

@MappableClass(discriminatorValue: 'record')
class JsRecord extends JsType with JsRecordMappable {
  final JsType keys;
  final JsField values;
  const JsRecord(this.keys, this.values, super.type);
  @override
  String dartType(FunctionBuildContext context) {
    if (keys is! JsString) {
      throw UnimplementedError(
        'Record keys must be a string. If you are seeing this and are having trouble, please file an issue on GitHub.',
      );
    }
    return 'Map<String, ${values.dartType(context)}>';
  }

  @override
  String serialize(
    FunctionBuildContext context,
    String name, {
    required bool nullable,
  }) {
    final argName = context.tempNames.next();
    final map =
        "{for (final $argName in $name.entries) $argName.key: ${values.fieldType.serialize(context, "$argName.value", nullable: false)}}";
    if (nullable) {
      return '$name == null ? null : $map';
    }
    return map;
  }

  @override
  String deserialize(
    FunctionBuildContext context,
    String name, {
    required bool nullable,
  }) {
    final keyArgName = context.tempNames.next();
    final valueArgName = context.tempNames.next();
    final map =
        '($name as Map).cast<String, Object?>().map(($keyArgName, $valueArgName) => MapEntry($keyArgName, ${values.fieldType.deserialize(context, valueArgName, nullable: false)}))';
    if (nullable) {
      return '$name == null ? null : $map';
    }
    return map;
  }
}

@MappableClass(discriminatorValue: 'object')
class JsObject extends JsType with JsObjectMappable {
  final Map<String, JsField> value;
  const JsObject(this.value, super.type);

  Iterable<MapEntry<String, JsField>> get optionalFields =>
      value.entries.where((entry) => entry.value.optional);

  String safeDartKey(String name) {
    if (name.startsWith('_')) {
      name = '\$$name';
    }
    if (_dartKeywords.contains(name)) {
      name = '\$$name';
    }
    if (name.startsWith('\$_')) {
      name = name.substring(2);
    }
    return name.camelCase;
  }

  @override
  String dartType(FunctionBuildContext context) {
    if (value.isEmpty) {
      throw UnimplementedError(
        'convex_dart does not support empty objects. If you are seeing this and are having trouble, please file an issue on GitHub.',
      );
    }
    return "({${value.entries.map((entry) => "${entry.value.dartType(context)} ${safeDartKey(entry.key)}").join(",")}})";
  }

  @override
  String serialize(
    FunctionBuildContext context,
    String name, {
    required bool nullable,
  }) {
    final objectName = context.tempNames.next();
    final buffer = StringBuffer('{');
    for (final entry in value.entries) {
      if (entry.value.optional) {
        final fieldName = '$objectName.${safeDartKey(entry.key)}';
        buffer.write(
          "if ($fieldName.isDefined) '${entry.key}': ${entry.value.fieldType.serialize(context, "$fieldName.asDefined().value", nullable: false)},",
        );
      } else {
        buffer.write(
          "'${entry.key}': ${entry.value.fieldType.serialize(context, "$objectName.${safeDartKey(entry.key)}", nullable: false)},",
        );
      }
    }
    buffer.write('}');
    final object = '((){ final $objectName = $name; return $buffer; })()';
    if (nullable) {
      return '$name == null ? null : $object';
    }
    return object;
  }

  @override
  String deserialize(
    FunctionBuildContext context,
    String name, {
    required bool nullable,
  }) {
    final argName = context.tempNames.next();
    final buffer = StringBuffer(
      '((){ final $argName = ($name as Map).cast<String, Object?>(); return (',
    );
    for (final entry in value.entries) {
      if (entry.value.optional) {
        buffer.write(
          "${safeDartKey(entry.key)}: $argName.containsKey('${entry.key}') ? Defined<${entry.value.fieldType.dartType(context)}>(${entry.value.fieldType.deserialize(context, "$argName['${entry.key}']", nullable: false)}) : Undefined<${entry.value.fieldType.dartType(context)}>(),",
        );
      } else {
        buffer.write(
          "${safeDartKey(entry.key)}: ${entry.value.fieldType.deserialize(context, "$argName['${entry.key}']", nullable: false)},",
        );
      }
    }
    buffer.write('); })()');
    final object = buffer.toString();
    if (nullable) {
      return '$name == null ? null : $object';
    }
    return object;
  }
}

@MappableClass(discriminatorValue: 'array')
class JsArray extends JsType with JsArrayMappable {
  final JsType value;
  const JsArray(this.value, super.type);
  @override
  String dartType(FunctionBuildContext context) {
    return 'List<${value.dartType(context)}>';
  }

  @override
  String serialize(
    FunctionBuildContext context,
    String name, {
    required bool nullable,
  }) {
    final argName = context.tempNames.next();
    final list =
        '$name.map<Object?>(($argName) => ${value.serialize(context, argName, nullable: false)}).toList(growable: false)';
    if (nullable) {
      return '$name == null ? null : $list';
    }
    return list;
  }

  @override
  String deserialize(
    FunctionBuildContext context,
    String name, {
    required bool nullable,
  }) {
    final randName = context.tempNames.next();
    final list =
        '($name as List).map<${value.dartType(context)}>(($randName) => ${value.deserialize(context, randName, nullable: false)}).toList(growable: false)';
    if (nullable) {
      return '$name == null ? null : $list';
    }
    return list;
  }
}

@MappableClass(discriminatorValue: 'id')
class ConvexId extends JsType with ConvexIdMappable {
  final String tableName;
  const ConvexId(this.tableName, super.type);

  String get typeName => '${tableName.pascalCase}Id';

  @override
  String dartType(FunctionBuildContext context) {
    context.clientContext.tables.add(tableName);
    return typeName;
  }

  @override
  String serialize(
    FunctionBuildContext context,
    String name, {
    required bool nullable,
  }) {
    if (nullable) {
      return '$name == null ? null : $name!.name';
    }
    return '$name.name';
  }

  @override
  String deserialize(
    FunctionBuildContext context,
    String name, {
    required bool nullable,
  }) {
    if (nullable) {
      return '$name == null ? null : $typeName($name as String)';
    }
    return '$typeName($name as String)';
  }
}

List<String> _dartKeywords = [
  'abstract',
  'as',
  'assert',
  'async',
  'await',
  'break',
  'case',
  'catch',
  'class',
  'const',
  'continue',
  'covariant',
  'default',
  'deferred',
  'do',
  'dynamic',
  'else',
  'enum',
  'export',
  'extends',
  'extension',
  'external',
  'factory',
  'false',
  'final',
  'finally',
  'for',
  'Function',
  'get',
  'hide',
  'if',
  'implements',
  'import',
  'in',
  'interface',
  'is',
  'library',
  'mixin',
  'new',
  'null',
  'on',
  'operator',
  'part',
  'rethrow',
  'return',
  'set',
  'show',
  'static',
  'super',
  'switch',
  'sync',
  'this',
  'throw',
  'true',
  'try',
  'typedef',
  'var',
  'void',
  'while',
  'with',
  'yield',
];
String stringToDart(String value) {
  // Replace "." and "-" with "_"
  value = value.replaceAll('.', '_').replaceAll('-', '_').replaceAll(' ', '_');
  // Replace any non dart chars with $
  value = value.replaceAll(RegExp(r'[^a-zA-Z0-9_$]'), r'$');
  if (_dartKeywords.contains(value)) {
    value = '\$$value';
  }
  return value;
}
