import 'package:app_database/app_database.dart';
import 'package:drift/drift.dart';
import 'package:drift_app_database/src/daos/entry_metadata_dao.dart';
import 'package:drift_app_database/src/daos/history_log_dao.dart';
import 'package:drift_app_database/src/daos/raport_dao.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'tabels/tabels.dart';
import 'daos/daos.dart';
import 'defaults/entry_metadata_defaults.dart';
part 'drift_app_database.g.dart';

/// {@template drift_db_api}
/// A Flutter implementation of the DBApi that uses SQLite with Drift ORM.
/// {@endtemplate}

@DriftDatabase(tables: [
  ApiaryTable,
  QueenTable,
  HiveTable,
  RaportTable,
  EntryMetadataTable,
  EntryTable,
  TodoTable,
  HistoryLogTable,
],
  daos: [
    ApiaryDao,
    HiveDao,
    TodoDao,
    QueenDao,
    RaportDao,
    EntryMetadataDao,
    HistoryLogDao

  ],
)
class DriftAppDatabase extends _$DriftAppDatabase implements AppDatabase {
  /// {@macro drift_db_api}
  DriftAppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // Named constructor for creating in-memory database
  DriftAppDatabase.forTesting(super.e);

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'hive_note_database');
  }

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
      
      // If this is first run (after clean install), add default entries
      if (details.wasCreated) {
        for (final entry in DefaultEntryMetadata.defaults) {
          await entryMetadataDao.insertEntryMetadata(entry);
        }
      }
    },
  );


  @override
  Future deleteApiary(Apiary apiary) => apiaryDao.deleteApiary(apiary);

  @override
  Future deleteHive(Hive hive) => hiveDao.deleteHive(hive);

  @override
  Future removeTodo(Todo todo) => todoDao.removeTodo(todo);

  @override
  Future insertApiary(Apiary apiary) => apiaryDao.insertApiary(apiary);

  @override
  Future insertHive(Hive hive) => hiveDao.insertHive(hive);

  @override
  Future insertTodo(Todo todo) => todoDao.insertTodo(todo);

  @override
  Future updateApiary(Apiary apiary) => apiaryDao.updateApiary(apiary);  
  
  @override
  Future updateApiaries(List<Apiary> apiariesToUpdate) => apiaryDao.updateApiaries(apiariesToUpdate);

  @override
  Future updateHive(Hive hive) => hiveDao.updateHive(hive);

  @override
  Future updateHives(List<Hive> hivesToUpdate) => hiveDao.updateHives(hivesToUpdate);

  @override
  Future updateTodo(Todo todo) => todoDao.updateTodo(todo);

  @override
  Stream<List<Todo>> watchTodos() => todoDao.watchTodos();
  
  @override
  Stream<List<Todo>> watchNotCompletedTodos() => todoDao.watchNotCompletedTodos();
  
  @override
  Stream<List<ApiaryWithHiveCount>> watchApiariesWithHiveCount(onlyActive) => apiaryDao.watchApiariesWithHiveCount(onlyActive);
  
  @override
  Stream<List<Apiary>> watchApiaries() => apiaryDao.watchApiaries();

  @override
  Stream<List<HiveWithQueen>> watchHivesWithQueenByApiary(Apiary? apiary) => hiveDao.watchHivesWithQueenByApiary(apiary);
  
  @override
  Stream<List<QueenWithHive>> watchQueensWithHiveByApiary(Apiary? apiary) => queenDao.watchQueensWithHiveByApiary(apiary);
  
  @override
  Future<void> deleteQueen(Queen queen) => queenDao.deleteQueen(queen);
  
  @override
  Future<void> insertQueen(Queen queen) => queenDao.insertQueen(queen);
  
  @override
  Future<void> updateQueen(Queen queen) => queenDao.updateQueen(queen);
  
  @override
  Stream<ApiaryWithHives> watchApiaryWithHives(String apiaryId) => apiaryDao.watchApiaryWithHives(apiaryId);

  @override
  Stream<HiveWithQueen> watchHiveWithQueen(String hiveId) => hiveDao.watchHiveWithQueen(hiveId);

  @override
  Stream<List<Queen>> watchAvailableQueens() => queenDao.watchAvailableQueens();
  
  @override
  Stream<Queen> watchQueen(String queenId) => queenDao.watchQueen(queenId);
  
  @override
  Future<void> deleteEntryMetadata(EntryMetadata entryMetadata) => entryMetadataDao.deleteEntryMetadata(entryMetadata);
  
  @override
  Future<void> deleteRaport(Raport raport) => raportDao.deleteRaport(raport);
  
  @override
  Future<void> insertEntryMetadata(EntryMetadata entryMetadata) => entryMetadataDao.insertEntryMetadata(entryMetadata);
  
  @override
  Stream<List<EntryMetadata>> watchEntryMetadatasOfRaportType(RaportType raportType) => entryMetadataDao.watchEntryMetadatasOfRaportType(raportType);
  
  @override
  Future<void> insertRaport(Raport raport, List<Entry> entries) => raportDao.insertRaport(raport, entries);
  
  @override
  Future<void> updateRaport(Raport raport, List<Entry> entries) => raportDao.updateRaport(raport, entries);

  @override
  Future<void> updateEntriesMetadata(List<EntryMetadata> entriesMetadata) => entryMetadataDao.updateEntriesMetadata(entriesMetadata);
  
  @override
  Future<Apiary> getApiary(String apiaryId) => apiaryDao.getApiary(apiaryId);
  
  @override
  Future<List<HiveWithQueen>> getHivesWithQueenByApiary(Apiary? apiary) => hiveDao.getHivesWithQueenByApiary(apiary);
  
  @override
  Future<List<EntryMetadata>> getEntryMetadatas(RaportType raportType) => entryMetadataDao.getEntryMetadatas(raportType);
  
  @override
  Future<List<Apiary>> getApiaries() => apiaryDao.getApiaries();
  
  @override
  Future<List<Hive>> getHivesByApiary(Apiary? apiaryId) => hiveDao.getHivesByApiary(apiaryId);
  
  @override
  Future<List<HistoryLog>> getHistoryLogs(DateTime startDate, DateTime endDate, bool showShadow) => historyLogDao.getHistoryLogs(startDate, endDate,showShadow);
  
  @override
  Future<void> insertHistoryLog(HistoryLog historyLog) => historyLogDao.insertHistoryLog(historyLog);
  
  @override
  Future<Hive> getHive(String hiveId) => hiveDao.getHive(hiveId);
  
  @override
  Future<Queen?> getQueenForHive(Hive hive) => queenDao.getQueenForHive(hive);
  
  @override
  Future<Queen> getQueen(String queenId) => queenDao.getQueen(queenId);
  
  @override
  Future<Raport> getRaport(String raportId) => raportDao.getRaport(raportId);
  
  @override
  Future<List<Entry>> getEntries(Raport raport) => raportDao.getEntries(raport);
  
  @override
  Future<Todo> getTodo(String todoId) => todoDao.getTodo(todoId);
  
  @override
  Future<Map<String, List<String>>> getHints(RaportType raportType, bool withCount) => raportDao.getHints(raportType, withCount);
  
  @override
  Future<List<Raport>> getRaports(RaportType raportType, DateTime? startDate, DateTime? endDate, List<Apiary>? apiaries, List<Hive>? hives) => raportDao.getRaports(raportType, startDate, endDate, apiaries, hives);
}
