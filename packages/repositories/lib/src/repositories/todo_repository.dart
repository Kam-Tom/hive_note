import 'package:app_database/app_database.dart';

class TodoRepository {

  final AppDatabase _database;
  const TodoRepository(AppDatabase database) : _database = database;
  
  Stream<List<Todo>> watchTodos() => _database.watchTodos();
  Stream<List<Todo>> watchNotCompletedTodos() => _database.watchNotCompletedTodos();

  Future insertTodo(Todo todo) => _database.insertTodo(todo);
  Future updateTodo(Todo todo) 
  {
    print("WF");
   return _database.updateTodo(todo);
  }
}
