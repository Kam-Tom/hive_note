import 'package:app_database/app_database.dart';
/// {@template todo_repository}
/// A repository that handles toDo related requests.
/// {@endtemplate}
class TodoRepository {
  /// {@macro todo_repository}
  final AppDatabase _database;
  const TodoRepository(AppDatabase database) : _database = database;
  
  /// Watch all todos.
  Stream<List<ToDo>> watchTodos() {
    return _database.watchTodos();
  }
}
