import 'package:convex_dart_cli/types.dart';
import 'package:test/test.dart';

void main() {
  group('FunctionsSpec generation', () {
    test('groups functions by source module and omits client.dart', () async {
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
      ]);

      final context = ClientBuildContext();
      await spec.build(context, publicSerialize: false);

      expect(context.outputs, contains('functions/generic_functions.dart'));
      expect(context.outputs, isNot(contains('client.dart')));
      expect(
        context.outputs.keys.where(
          (path) => path.startsWith('functions/generic_functions/'),
        ),
        isEmpty,
      );

      final module = context.outputs['functions/generic_functions.dart']!;
      expect(module, contains('final query1 = _Query1();'));
      expect(module, contains('final query2 = _Query2();'));
      expect(module, contains('final query3 = _Query3();'));
      expect(module, contains('class _Query1 extends ConvexQuery'));
      expect(module, contains('class _Query3 extends ConvexMutation'));
      expect(module, contains('typedef _Query1Args = ({String i});'));
      expect(module, contains('typedef _Query1Return = ({String i});'));
      expect(module, contains('Uint8List'));
      expect(module, contains('List<Map<String, Uint8List>>'));
      expect(module, isNot(contains('Uint8ListWithEquality')));
      expect(module, isNot(contains('IList')));
      expect(module, isNot(contains('IMap')));
    });

    test('keeps implementation details private and parses ids', () async {
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
      expect(module, contains('final updateTask = _UpdateTask();'));
      expect(module, contains('class _UpdateTask extends ConvexMutation'));
      expect(module, contains('typedef _UpdateTaskArgs'));
      expect(module, contains('Optional<String> text'));
      expect(module, contains("'id': _v0.id.name"));
      expect(module, contains("if (_v0.text.isDefined) 'text':"));
      expect(module, contains('typedef _UpdateTaskReturn = TasksId;'));
      expect(module, contains('return TasksId(returns as String);'));

      final schema = context.outputs['schema.dart']!;
      expect(schema, contains('class TasksId implements TableId'));
    });
  });
}
