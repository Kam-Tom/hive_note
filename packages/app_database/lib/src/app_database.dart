import 'package:app_database/app_database.dart';

abstract class AppDatabase {
  Stream<List<Todo>> watchTodos();
  Stream<List<Todo>> watchNotCompletedTodos();
  Stream<List<ApiaryWithHiveCount>> watchApiariesWithHiveCount(bool onlyActive);
  Stream<List<Apiary>> watchApiaries();
  Stream<ApiaryWithHives> watchApiaryWithHives(String apiaryId);

  /// Returns a [List] of [HiveWithQueen] where `hive.apiaryId` matches the [apiary]'s id.
  /// 
  /// If [apiary] is null, it returns only hives without an associated apiary.
  /// 
  /// - [apiary]: The [Apiary] to filter hives by. If null, returns hives without an apiary.
  Stream<List<HiveWithQueen>> watchHivesWithQueenByApiary(Apiary? apiary);
  
  Stream<HiveWithQueen> watchHiveWithQueen(String hiveId);

  /// Returns a [List] of [QueenWithHive] where the `hive.apiaryId` matches the [apiary]'s id, or the hive is null.
  /// 
  /// If [apiary] is null, it returns only queens without an associated apiary.
  /// 
  /// - [apiary]: The [Apiary] to filter queens by hive.apiaryId. If null, returns queens without an apiary.
  Stream<List<QueenWithHive>> watchQueensWithHiveByApiary(Apiary? apiary);
  Stream<Queen> watchQueen(String queenId);

  Future<void> insertApiary(Apiary apiary);
  Future<void> updateApiary(Apiary apiary);
  Future<void> deleteApiary(Apiary apiary);

  Future<void> updateApiaries(List<Apiary> apiariesToUpdate);
  Future<void> updateHives(List<Hive> hivesToUpdate);

  Future<void> insertHive(Hive hive);
  Future<void> updateHive(Hive hive);
  Future<void> deleteHive(Hive hive);  
  
  Future<void> insertQueen(Queen queen);
  Future<void> updateQueen(Queen queen);
  Future<void> deleteQueen(Queen queen);

  Future<void> insertTodo(Todo todo);
  Future<void> updateTodo(Todo todo);
  Future<void> deleteTodo(Todo todo);

  Stream<List<Queen>> watchAvailableQueens();

}
