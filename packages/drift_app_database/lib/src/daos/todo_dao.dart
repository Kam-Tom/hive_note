import 'package:app_database/app_database.dart';
import 'package:drift/drift.dart';
import 'package:drift_app_database/drift_app_database.dart';
import 'package:drift_app_database/src/tabels/tabels.dart';

part 'todo_dao.g.dart';


@DriftAccessor(tables: [TodoTable])
class TodoDao extends DatabaseAccessor<DriftAppDatabase> with _$TodoDaoMixin {
  TodoDao(DriftAppDatabase db) : super(db);

  Stream<List<Todo>> watchTodos() => select(todoTable).watch();

  Stream<List<Todo>> watchNotCompletedTodos() => (select(todoTable)..where((t) => t.isCompleted.equals(false))).watch();

  Future insertTodo(Todo todo) => into(todoTable).insert(todo.toCompanion());

  Future updateTodo(Todo todo) => update(todoTable).replace(todo.toCompanion());
  
  Future removeTodo(Todo todo) => (delete(todoTable)..where((t) => t.id.equals(todo.id))).go();

  Future<Todo> getTodo(String todoId) => (select(todoTable)..where((t) => t.id.equals(todoId))).getSingle();

}

extension on Todo {
  TodoTableCompanion toCompanion() {
    return TodoTableCompanion(
      id: Value(id),
      location: Value(location),
      description: Value(description),
      categoryType: Value(categoryType),
      dueTo: Value(dueTo),
      isCompleted: Value(isCompleted),
    );
  }
}
