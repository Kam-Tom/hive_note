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
  Future<void> removeTodo(Todo todo);

  Future<void> insertRaport(Raport raport, List<Entry> entries);
  Future<void> updateRaport(Raport raport, List<Entry> entries);
  Future<void> deleteRaport(Raport raport);

  Future<void> insertEntryMetadata(EntryMetadata entryMetadata);
  Stream<List<EntryMetadata>> watchEntryMetadatasOfRaportType(RaportType raportType);
  Future<void> deleteEntryMetadata(EntryMetadata entryMetadata);

  Stream<List<Queen>> watchAvailableQueens();

  Future<void> updateEntriesMetadata(List<EntryMetadata> entriesMetadata);

  Future<Apiary> getApiary(String apiaryId);

  Future<List<HiveWithQueen>> getHivesWithQueenByApiary(Apiary? apiary);

  Future<List<EntryMetadata>> getEntryMetadatas(RaportType raportType);

  Future<List<Apiary>> getApiaries();

  Future<List<Hive>> getHivesByApiary(Apiary? apiaryId);

  Future<List<HistoryLog>> getHistoryLogs(DateTime startDate, DateTime endDate, bool showShadow);
  Future<void> insertHistoryLog(HistoryLog historyLog);

  Future<Hive> getHive(String hiveId);

  Future<Queen?> getQueenForHive(Hive hive);

  Future<Queen> getQueen(String queenId);

  Future<Raport> getRaport(String raportId);

  Future<List<Entry>> getEntries(Raport raport);

  Future<Todo> getTodo(String todoId);

  Future<Map<String,List<String>>> getHints(RaportType raportType, bool withCount);

  Future<List<Raport>> getRaports(RaportType raportType, DateTime? startDate, DateTime? endDate, List<Apiary>? apiaries, List<Hive>? hives);

}
