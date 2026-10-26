import 'package:convex_dart_cli/types.dart';
import 'package:test/test.dart';

void main() {
  group('FunctionsSpec generation', () {
    test(
      'groups functions by source module and generates client.dart',
      () async {
        final spec = FunctionsSpec('https://example.convex.cloud', [
          FunctionSpec(
            JsObject({'i': JsField(JsString('string'), false)}, 'object'),
            'generic_functions.ts:query1',
            const Visibility(VisibilityType.public),
            'Query',
            JsObject({'i': JsField(JsString('string'), false)}, 'object'),
          ),
          FunctionSpec(
            JsObject({'i': JsField(JsNumber('number'), false)}, 'object'),
            'generic_functions.ts:query2',
            const Visibility(VisibilityType.public),
            'Query',
            JsObject({'i': JsField(JsNumber('number'), false)}, 'object'),
          ),
          FunctionSpec(
            JsObject({'i': JsField(JsBytes('bytes'), false)}, 'object'),
            'generic_functions.ts:query3',
            const Visibility(VisibilityType.public),
            'Mutation',
            JsObject({
              'items': JsField(
                JsArray(
                  JsRecord(
                    JsString('string'),
                    JsField(JsBytes('bytes'), false),
                    'record',
                  ),
                  'array',
                ),
                false,
              ),
            }, 'object'),
          ),
          const HttpFunctionSpec('HttpAction', HttpMethod.GET, '/api/v1/*'),
        ]);

        final context = ClientBuildContext();
        await spec.build(context, publicSerialize: false);

        expect(context.outputs, contains('functions/generic_functions.dart'));
        expect(context.outputs, contains('client.dart'));
        expect(
          context.outputs.keys.where(
            (path) => path.startsWith('functions/generic_functions/'),
          ),
          isEmpty,
        );

        final module = context.outputs['functions/generic_functions.dart']!;
        expect(module, contains(r'final query1 = $Query1();'));
        expect(module, contains(r'final query2 = $Query2();'));
        expect(module, contains(r'final query3 = $Query3();'));
        expect(module, contains(r'class $Query1 extends ConvexQuery'));
        expect(module, contains(r'class $Query3 extends ConvexMutation'));
        expect(module, contains('typedef Query1Args = ({String i});'));
        expect(module, contains('typedef Query1Return = ({String i});'));
        expect(module, contains('Uint8List'));
        expect(module, contains('List<Map<String, Uint8List>>'));
        expect(module, isNot(contains('Uint8ListWithEquality')));
        expect(module, isNot(contains('IList')));
        expect(module, isNot(contains('IMap')));

        final client = context.outputs['client.dart']!;
        expect(
          client,
          contains('class MyConvexClient extends ConvexHttpClient'),
        );
        expect(
          client,
          contains('class MyConvexWebsocketClient extends ConvexClient'),
        );
        expect(
          client,
          contains('const String convexUrl = "https://example.convex.cloud";'),
        );
        expect(
          client,
          contains(
            'const String convexHttpUrl = "https://example.convex.site";',
          ),
        );
        expect(
          client,
          contains('const String convexWebsiteUrl = convexHttpUrl;'),
        );
        expect(client, contains(': super(convexUrl, options: options);'));
        expect(client, contains('final String httpUrl = convexHttpUrl;'));
        expect(client, isNot(contains(r'static Future<$http.Response>')));
        expect(client, contains(r'Future<$http.Response> get$api$v1$$'));
        expect(client, contains("return rawHttpAction('GET', uri"));
        expect(client, contains('import "./functions/generic_functions.dart"'));
        expect(client, contains('as functions0'));
        expect(client, isNot(contains('show query1, query2, query3;')));
        expect(client, contains('final api = ('));
        expect(client, contains('genericFunctions: ('));
        expect(client, contains('query1: functions0.query1,'));
        expect(client, contains('query2: functions0.query2,'));
        expect(client, contains('query3: functions0.query3,'));
        expect(client, contains(r'get$api$v1$$'));
      },
    );

    test('generates function objects and parses ids', () async {
      final spec = FunctionsSpec('https://example.convex.cloud', [
        FunctionSpec(
          JsObject({
            'id': JsField(ConvexId('tasks', 'id'), false),
            'text': JsField(JsString('string'), true),
          }, 'object'),
          'tasks.ts:updateTask',
          const Visibility(VisibilityType.public),
          'Mutation',
          ConvexId('tasks', 'id'),
        ),
      ]);

      final context = ClientBuildContext();
      await spec.build(context, publicSerialize: false);

      final module = context.outputs['functions/tasks.dart']!;
      expect(module, contains(r'final updateTask = $UpdateTask();'));
      expect(module, contains(r'class $UpdateTask extends ConvexMutation'));
      expect(module, contains('typedef UpdateTaskArgs'));
      expect(module, contains('Optional<String> text'));
      expect(module, contains('import "package:convex_dart/optional.dart";'));
      expect(module, contains('Optional<String>.defined('));
      expect(module, contains('Optional<String>.undefined()'));
      expect(module, isNot(contains('Defined<String>(')));
      expect(module, isNot(contains('Undefined<String>()')));
      expect(module, contains("'id': _v0.id.name"));
      expect(module, contains("if (_v0.text.isDefined) 'text':"));
      expect(module, contains('typedef UpdateTaskReturn = TasksId;'));
      expect(module, contains('return TasksId(returns as String);'));

      final client = context.outputs['client.dart']!;
      expect(client, contains('tasks: (updateTask: functions0.updateTask'));

      final schema = context.outputs['schema.dart']!;
      expect(schema, contains('class TasksId implements TableId'));
    });

    test('maps local deployment url to local http action url', () async {
      final spec = FunctionsSpec('http://127.0.0.1:3210', const []);

      final context = ClientBuildContext();
      await spec.build(context, publicSerialize: false);

      final client = context.outputs['client.dart']!;
      expect(
        client,
        contains('const String convexUrl = "http://127.0.0.1:3210";'),
      );
      expect(
        client,
        contains('const String convexHttpUrl = "http://127.0.0.1:3211";'),
      );
      expect(
        client,
        contains('const String convexWebsiteUrl = convexHttpUrl;'),
      );
    });

    test('serializes optional nested objects with nullable guards', () async {
      final quillAttributeValue = JsUnion([
        JsString('string'),
        JsNumber('number'),
        JsBoolean('boolean'),
        JsNull('null'),
      ], 'union');
      final quillDelta = JsObject({
        'ops': JsField(
          JsArray(
            JsObject({
              'insert': JsField(
                JsUnion([
                  JsString('string'),
                  JsObject({
                    'image': JsField(JsString('string'), false),
                  }, 'object'),
                ], 'union'),
                false,
              ),
              'attributes': JsField(
                JsRecord(
                  JsString('string'),
                  JsField(quillAttributeValue, false),
                  'record',
                ),
                true,
              ),
            }, 'object'),
            'array',
          ),
          false,
        ),
      }, 'object');
      final spec = FunctionsSpec('https://example.convex.cloud', [
        FunctionSpec(
          JsObject({'infoQuill': JsField(quillDelta, true)}, 'object'),
          'hospitals.ts:update',
          const Visibility(VisibilityType.public),
          'Mutation',
          JsNull('null'),
        ),
      ]);

      final context = ClientBuildContext();
      await spec.build(context, publicSerialize: false);

      final module = context.outputs['functions/hospitals.dart']!;
      expect(
        module,
        contains("'infoQuill': _v0.infoQuill.asDefined().value == null"),
      );
      expect(
        module,
        contains('final _v1 = (_v0.infoQuill.asDefined().value)!;'),
      );
      expect(module, contains("'ops': _v1.ops"));
      expect(
        module,
        isNot(contains('final _v1 = _v0.infoQuill.asDefined().value;')),
      );
    });

    test('prefixes generated function class names with dollar', () async {
      final spec = FunctionsSpec('https://example.convex.cloud', [
        FunctionSpec(
          JsObject({'limit': JsField(JsNumber('number'), false)}, 'object'),
          'hospitals.ts:list',
          const Visibility(VisibilityType.public),
          'Query',
          JsArray(JsString('string'), 'array'),
        ),
      ]);

      final context = ClientBuildContext();
      await spec.build(context, publicSerialize: false);

      final module = context.outputs['functions/hospitals.dart']!;
      expect(module, contains(r'final list = $List();'));
      expect(module, contains(r'class $List extends ConvexQuery'));
      expect(module, contains(r'$List() : super("hospitals:list");'));
      expect(module, contains('typedef ListArgs = ({double limit});'));
      expect(module, contains('typedef ListReturn = List<String>;'));

      final client = context.outputs['client.dart']!;
      expect(client, contains('hospitals: (list: functions0.list'));
    });
  });
}
