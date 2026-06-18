// ignore_for_file: type=lint, unused_import, unnecessary_question_mark, dead_code, dead_null_aware_expression, unnecessary_non_null_assertion
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter, invalid_use_of_internal_member
import "dart:typed_data";
import "package:convex_dart/convex_dart.dart";
import "package:convex_dart/src/optional.dart";
import "package:convex_dart/src/union.dart";
import "../schema.dart";
import "../literals.dart";

final createTask = CreateTask();

class CreateTask extends ConvexMutation<CreateTaskArgs, CreateTaskReturn> {
  CreateTask() : super("tasks:createTask");

  @override
  Map<String, Object?> parseArgs(CreateTaskArgs args) {
    return (() {
      final _v0 = args;
      return {
        if (_v0.isCompleted.isDefined)
          'isCompleted': _v0.isCompleted.asDefined().value,
        'text': _v0.text,
      };
    })();
  }

  @override
  CreateTaskArgs parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        isCompleted: _v0.containsKey('isCompleted')
            ? Defined<bool>((_v0['isCompleted'] as bool))
            : Undefined<bool>(),
        text: (_v0['text'] as String),
      );
    })();
  }

  @override
  CreateTaskReturn parseReturns(Object? returns) {
    return TasksId(returns as String);
  }
}

final getAllTasks = GetAllTasks();

class GetAllTasks extends ConvexQuery<Null, GetAllTasksReturn> {
  GetAllTasks() : super("tasks:getAllTasks");

  @override
  Map<String, Object?> parseArgs(Null args) {
    return <String, Object?>{};
  }

  @override
  Null parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return null;
  }

  @override
  GetAllTasksReturn parseReturns(Object? returns) {
    return (returns as List)
        .map<
          ({double creationTime, TasksId id, bool isCompleted, String text})
        >(
          (_v0) => (() {
            final _v1 = (_v0 as Map).cast<String, Object?>();
            return (
              creationTime: (_v1['_creationTime'] as num).toDouble(),
              id: TasksId(_v1['_id'] as String),
              isCompleted: (_v1['isCompleted'] as bool),
              text: (_v1['text'] as String),
            );
          })(),
        )
        .toList(growable: false);
  }
}

final getTask = GetTask();

class GetTask extends ConvexQuery<GetTaskArgs, GetTaskReturn> {
  GetTask() : super("tasks:getTask");

  @override
  Map<String, Object?> parseArgs(GetTaskArgs args) {
    return (() {
      final _v0 = args;
      return {'id': _v0.id.name};
    })();
  }

  @override
  GetTaskArgs parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (id: TasksId(_v0['id'] as String));
    })();
  }

  @override
  GetTaskReturn parseReturns(Object? returns) {
    return returns == null
        ? null
        : (() {
            final _v0 = (returns as Map).cast<String, Object?>();
            return (
              creationTime: (_v0['_creationTime'] as num).toDouble(),
              id: TasksId(_v0['_id'] as String),
              isCompleted: (_v0['isCompleted'] as bool),
              text: (_v0['text'] as String),
            );
          })();
  }
}

final getTasksByStatus = GetTasksByStatus();

class GetTasksByStatus
    extends ConvexQuery<GetTasksByStatusArgs, GetTasksByStatusReturn> {
  GetTasksByStatus() : super("tasks:getTasksByStatus");

  @override
  Map<String, Object?> parseArgs(GetTasksByStatusArgs args) {
    return (() {
      final _v0 = args;
      return {'isCompleted': _v0.isCompleted};
    })();
  }

  @override
  GetTasksByStatusArgs parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (isCompleted: (_v0['isCompleted'] as bool));
    })();
  }

  @override
  GetTasksByStatusReturn parseReturns(Object? returns) {
    return (returns as List)
        .map<
          ({double creationTime, TasksId id, bool isCompleted, String text})
        >(
          (_v0) => (() {
            final _v1 = (_v0 as Map).cast<String, Object?>();
            return (
              creationTime: (_v1['_creationTime'] as num).toDouble(),
              id: TasksId(_v1['_id'] as String),
              isCompleted: (_v1['isCompleted'] as bool),
              text: (_v1['text'] as String),
            );
          })(),
        )
        .toList(growable: false);
  }
}

final searchTasks = SearchTasks();

class SearchTasks extends ConvexQuery<SearchTasksArgs, SearchTasksReturn> {
  SearchTasks() : super("tasks:searchTasks");

  @override
  Map<String, Object?> parseArgs(SearchTasksArgs args) {
    return (() {
      final _v0 = args;
      return {'searchText': _v0.searchText};
    })();
  }

  @override
  SearchTasksArgs parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (searchText: (_v0['searchText'] as String));
    })();
  }

  @override
  SearchTasksReturn parseReturns(Object? returns) {
    return (returns as List)
        .map<
          ({double creationTime, TasksId id, bool isCompleted, String text})
        >(
          (_v0) => (() {
            final _v1 = (_v0 as Map).cast<String, Object?>();
            return (
              creationTime: (_v1['_creationTime'] as num).toDouble(),
              id: TasksId(_v1['_id'] as String),
              isCompleted: (_v1['isCompleted'] as bool),
              text: (_v1['text'] as String),
            );
          })(),
        )
        .toList(growable: false);
  }
}

final updateTaskText = UpdateTaskText();

class UpdateTaskText
    extends ConvexMutation<UpdateTaskTextArgs, UpdateTaskTextReturn> {
  UpdateTaskText() : super("tasks:updateTaskText");

  @override
  Map<String, Object?> parseArgs(UpdateTaskTextArgs args) {
    return (() {
      final _v0 = args;
      return {'id': _v0.id.name, 'text': _v0.text};
    })();
  }

  @override
  UpdateTaskTextArgs parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (id: TasksId(_v0['id'] as String), text: (_v0['text'] as String));
    })();
  }

  @override
  UpdateTaskTextReturn parseReturns(Object? returns) {
    return null;
  }
}

final toggleTaskCompletion = ToggleTaskCompletion();

class ToggleTaskCompletion
    extends
        ConvexMutation<ToggleTaskCompletionArgs, ToggleTaskCompletionReturn> {
  ToggleTaskCompletion() : super("tasks:toggleTaskCompletion");

  @override
  Map<String, Object?> parseArgs(ToggleTaskCompletionArgs args) {
    return (() {
      final _v0 = args;
      return {'id': _v0.id.name};
    })();
  }

  @override
  ToggleTaskCompletionArgs parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (id: TasksId(_v0['id'] as String));
    })();
  }

  @override
  ToggleTaskCompletionReturn parseReturns(Object? returns) {
    return (returns as bool);
  }
}

final setTaskCompletion = SetTaskCompletion();

class SetTaskCompletion
    extends ConvexMutation<SetTaskCompletionArgs, SetTaskCompletionReturn> {
  SetTaskCompletion() : super("tasks:setTaskCompletion");

  @override
  Map<String, Object?> parseArgs(SetTaskCompletionArgs args) {
    return (() {
      final _v0 = args;
      return {'id': _v0.id.name, 'isCompleted': _v0.isCompleted};
    })();
  }

  @override
  SetTaskCompletionArgs parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        id: TasksId(_v0['id'] as String),
        isCompleted: (_v0['isCompleted'] as bool),
      );
    })();
  }

  @override
  SetTaskCompletionReturn parseReturns(Object? returns) {
    return null;
  }
}

final updateTask = UpdateTask();

class UpdateTask extends ConvexMutation<UpdateTaskArgs, UpdateTaskReturn> {
  UpdateTask() : super("tasks:updateTask");

  @override
  Map<String, Object?> parseArgs(UpdateTaskArgs args) {
    return (() {
      final _v0 = args;
      return {
        'id': _v0.id.name,
        if (_v0.isCompleted.isDefined)
          'isCompleted': _v0.isCompleted.asDefined().value,
        if (_v0.text.isDefined) 'text': _v0.text.asDefined().value,
      };
    })();
  }

  @override
  UpdateTaskArgs parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (
        id: TasksId(_v0['id'] as String),
        isCompleted: _v0.containsKey('isCompleted')
            ? Defined<bool>((_v0['isCompleted'] as bool))
            : Undefined<bool>(),
        text: _v0.containsKey('text')
            ? Defined<String>((_v0['text'] as String))
            : Undefined<String>(),
      );
    })();
  }

  @override
  UpdateTaskReturn parseReturns(Object? returns) {
    return null;
  }
}

final deleteTask = DeleteTask();

class DeleteTask extends ConvexMutation<DeleteTaskArgs, DeleteTaskReturn> {
  DeleteTask() : super("tasks:deleteTask");

  @override
  Map<String, Object?> parseArgs(DeleteTaskArgs args) {
    return (() {
      final _v0 = args;
      return {'id': _v0.id.name};
    })();
  }

  @override
  DeleteTaskArgs parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return (() {
      final _v0 = (rawArgs as Map).cast<String, Object?>();
      return (id: TasksId(_v0['id'] as String));
    })();
  }

  @override
  DeleteTaskReturn parseReturns(Object? returns) {
    return null;
  }
}

final deleteCompletedTasks = DeleteCompletedTasks();

class DeleteCompletedTasks
    extends ConvexMutation<Null, DeleteCompletedTasksReturn> {
  DeleteCompletedTasks() : super("tasks:deleteCompletedTasks");

  @override
  Map<String, Object?> parseArgs(Null args) {
    return <String, Object?>{};
  }

  @override
  Null parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return null;
  }

  @override
  DeleteCompletedTasksReturn parseReturns(Object? returns) {
    return (returns as num).toDouble();
  }
}

final deleteAllTasks = DeleteAllTasks();

class DeleteAllTasks extends ConvexMutation<Null, DeleteAllTasksReturn> {
  DeleteAllTasks() : super("tasks:deleteAllTasks");

  @override
  Map<String, Object?> parseArgs(Null args) {
    return <String, Object?>{};
  }

  @override
  Null parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return null;
  }

  @override
  DeleteAllTasksReturn parseReturns(Object? returns) {
    return (returns as num).toDouble();
  }
}

final getTaskCount = GetTaskCount();

class GetTaskCount extends ConvexQuery<Null, GetTaskCountReturn> {
  GetTaskCount() : super("tasks:getTaskCount");

  @override
  Map<String, Object?> parseArgs(Null args) {
    return <String, Object?>{};
  }

  @override
  Null parseArgsFromRaw(Map<String, Object?> rawArgs) {
    return null;
  }

  @override
  GetTaskCountReturn parseReturns(Object? returns) {
    return (() {
      final _v0 = (returns as Map).cast<String, Object?>();
      return (
        completed: (_v0['completed'] as num).toDouble(),
        pending: (_v0['pending'] as num).toDouble(),
        total: (_v0['total'] as num).toDouble(),
      );
    })();
  }
}

typedef CreateTaskArgs = ({Optional<bool> isCompleted, String text});
typedef CreateTaskReturn = TasksId;
typedef GetAllTasksReturn =
    List<({double creationTime, TasksId id, bool isCompleted, String text})>;
typedef GetTaskArgs = ({TasksId id});
typedef GetTaskReturn = ({
  double creationTime,
  TasksId id,
  bool isCompleted,
  String text,
})?;
typedef GetTasksByStatusArgs = ({bool isCompleted});
typedef GetTasksByStatusReturn =
    List<({double creationTime, TasksId id, bool isCompleted, String text})>;
typedef SearchTasksArgs = ({String searchText});
typedef SearchTasksReturn =
    List<({double creationTime, TasksId id, bool isCompleted, String text})>;
typedef UpdateTaskTextArgs = ({TasksId id, String text});
typedef UpdateTaskTextReturn = Null;
typedef ToggleTaskCompletionArgs = ({TasksId id});
typedef ToggleTaskCompletionReturn = bool;
typedef SetTaskCompletionArgs = ({TasksId id, bool isCompleted});
typedef SetTaskCompletionReturn = Null;
typedef UpdateTaskArgs = ({
  TasksId id,
  Optional<bool> isCompleted,
  Optional<String> text,
});
typedef UpdateTaskReturn = Null;
typedef DeleteTaskArgs = ({TasksId id});
typedef DeleteTaskReturn = Null;
typedef DeleteCompletedTasksReturn = double;
typedef DeleteAllTasksReturn = double;
typedef GetTaskCountReturn = ({double completed, double pending, double total});
