import 'package:app_database/app_database.dart';

abstract class AppDatabase {
  Stream<List<Todo>> watchTodos();
  Stream<List<Apiary>> watchApiaries();

  Future<void> insertApiary(Apiary apiary);
  Future<void> updateApiary(Apiary apiary);
  Future<void> deleteApiary(Apiary apiary);

  Future<void> insertHive(Hive hive);
  Future<void> updateHive(Hive hive);
  Future<void> deleteHive(Hive hive);

  Future<void> insertTodo(Todo todo);
  Future<void> updateTodo(Todo todo);
  Future<void> deleteTodo(Todo todo);

}
