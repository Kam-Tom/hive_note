import 'package:app_database/app_database.dart';
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'tabels/tabels.dart';
import 'daos/daos.dart';
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
  BooleanEntryTable,
  TextEntryTable,
  NumericEntryTable,
  TodoTable,
  HistoryLogTable,
],
  daos: [
    ApiaryDao,
    HiveDao,
    TodoDao,

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
  MigrationStrategy get migration =>
      MigrationStrategy(beforeOpen: (details) async {
        await customStatement('PRAGMA foreign_keys = ON');
      });

  @override
  Future deleteApiary(Apiary apiary) => apiaryDao.deleteApiary(apiary);

  @override
  Future deleteHive(Hive hive) => hiveDao.deleteHive(hive);

  @override
  Future deleteTodo(Todo todo) => todoDao.deleteTodo(todo);

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
  Stream<List<ApiaryWithHiveCount>> watchApiariesWithHiveCount() => apiaryDao.watchApiariesWithHiveCount();
}
