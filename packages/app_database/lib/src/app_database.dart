import 'package:app_database/app_database.dart';

abstract class AppDatabase {
  Stream<List<Todo>> watchTodos();
  Stream<List<Todo>> watchNotCompletedTodos();
  Stream<List<ApiaryWithHiveCount>> watchApiariesWithHiveCount();
  Stream<List<Apiary>> watchApiaries();

  /// Returns a [List] of [HiveWithQueen] where `hive.apiaryId` matches the [apiary]'s id.
  /// 
  /// If [apiary] is null, it returns only hives without an associated apiary.
  /// 
  /// - [apiary]: The [Apiary] to filter hives by. If null, returns hives without an apiary.
  Stream<List<HiveWithQueen>> watchHivesWithQueenByApiary(Apiary? apiary);

  Future<void> insertApiary(Apiary apiary);
  Future<void> updateApiary(Apiary apiary);
  Future<void> deleteApiary(Apiary apiary);

  Future<void> updateApiaries(List<Apiary> apiariesToUpdate);
  Future<void> updateHives(List<Hive> hivesToUpdate);

  Future<void> insertHive(Hive hive);
  Future<void> updateHive(Hive hive);
  Future<void> deleteHive(Hive hive);

  Future<void> insertTodo(Todo todo);
  Future<void> updateTodo(Todo todo);
  Future<void> deleteTodo(Todo todo);

}
