import 'package:app_database/app_database.dart';

class TodoRepository {

  final AppDatabase _database;
  const TodoRepository(AppDatabase database) : _database = database;
  
  Stream<List<Todo>> watchTodos() => _database.watchTodos();

}
