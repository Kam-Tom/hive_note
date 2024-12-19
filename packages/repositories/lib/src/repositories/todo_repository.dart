import 'package:app_database/app_database.dart';

class TodoRepository {

  final AppDatabase _database;
  const TodoRepository(AppDatabase database) : _database = database;
  
  Stream<List<Todo>> watchTodos() => _database.watchTodos();
  Stream<List<Todo>> watchNotCompletedTodos() => _database.watchNotCompletedTodos();

  Future insertTodo(Todo todo) async {
    await _database.insertTodo(todo);
    await _database.insertHistoryLog(HistoryLog(
      referenceId: todo.id,
      logType: LogType.todo,
      actionType: ActionType.create,
    ));
  } 
  Future updateTodo(Todo todo) async {
    await _database.updateTodo(todo);
    await _database.insertHistoryLog(
      HistoryLog(
        referenceId: todo.id,
        logType: LogType.todo,
        actionType: ActionType.update,
      ),
    );
  }
  Future removeTodo(Todo todo) async {
    await _database.removeTodo(todo);
    await _database.insertHistoryLog(
      HistoryLog(
        referenceId: todo.id,
        logType: LogType.todo,
        actionType: ActionType.delete,
      ),
    );

  }

  Future<Todo> getTodo(String todoId) => _database.getTodo(todoId); 
}
