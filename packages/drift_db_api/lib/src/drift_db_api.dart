import 'package:db_api/db_api.dart';
import 'package:drift/drift.dart';
import 'package:drift_db_api/src/daos/daos.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'tabels/tabels.dart';
part 'drift_db_api.g.dart';

/// {@template drift_db_api}
/// A Flutter implementation of the DBApi that uses SQLite with Drift ORM.
/// {@endtemplate}

@DriftDatabase(
  tables: [
    ApiaryTable,
    QueenTable,
    HiveTable,
    RaportTable,
    EntryMetadataTable,
    BooleanEntryTable,
    TextEntryTable,
    NumericEntryTable,
    HistoryLogTable,
  ],
  daos: [
    ApiaryDao,
    HiveDao,
    QueenDao,
    RaportDao,
    EntryMetadataDao,
    BooleanEntryDao,
    TextEntryDao,
    NumericEntryDao,
    HistoryLogDao,
  ],
)
class DriftDbApi extends _$DriftDbApi implements DbApi {
  /// {@macro drift_db_api}
  DriftDbApi() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'hive_note_database');
  }

  @override
  MigrationStrategy get migration =>
      MigrationStrategy(beforeOpen: (details) async {
        await customStatement('PRAGMA foreign_keys = ON');
      });

  @override
  Future<void> deleteApiary(Apiary apiary) {
    // TODO: implement deleteApiary
    throw UnimplementedError();
  }

  @override
  Future<void> deleteBooleanEntry(BooleanEntry booleanEntry) {
    // TODO: implement deleteBooleanEntry
    throw UnimplementedError();
  }

  @override
  Future<void> deleteHistoryLog(HistoryLog historyLog) {
    // TODO: implement deleteHistoryLog
    throw UnimplementedError();
  }

  @override
  Future<void> deleteHive(Hive hive) {
    // TODO: implement deleteHive
    throw UnimplementedError();
  }

  @override
  Future<void> deleteNumericEntry(NumericEntry numericEntry) {
    // TODO: implement deleteNumericEntry
    throw UnimplementedError();
  }

  @override
  Future<void> deleteQueen(Queen queen) {
    // TODO: implement deleteQueen
    throw UnimplementedError();
  }

  @override
  Future<void> deleteRaport(Raport raport) {
    // TODO: implement deleteRaport
    throw UnimplementedError();
  }

  @override
  Future<void> deleteTextEntry(TextEntry textEntry) {
    // TODO: implement deleteTextEntry
    throw UnimplementedError();
  }

  @override
  Future<List<Apiary>> getApiaries() {
    // TODO: implement getApiaries
    throw UnimplementedError();
  }

  @override
  Future<Apiary> getApiary(String id) {
    // TODO: implement getApiary
    throw UnimplementedError();
  }

  @override
  Future<List<BooleanEntry>> getBooleanEntries() {
    // TODO: implement getBooleanEntries
    throw UnimplementedError();
  }

  @override
  Future<BooleanEntry> getBooleanEntry(String id) {
    // TODO: implement getBooleanEntry
    throw UnimplementedError();
  }

  @override
  Future<HistoryLog> getHistoryLog(String id) {
    // TODO: implement getHistoryLog
    throw UnimplementedError();
  }

  @override
  Future<List<HistoryLog>> getHistoryLogs() {
    // TODO: implement getHistoryLogs
    throw UnimplementedError();
  }

  @override
  Future<Hive> getHive(String id) {
    // TODO: implement getHive
    throw UnimplementedError();
  }

  @override
  Future<List<Hive>> getHives() {
    // TODO: implement getHives
    throw UnimplementedError();
  }

  @override
  Future<List<NumericEntry>> getNumericEntries() {
    // TODO: implement getNumericEntries
    throw UnimplementedError();
  }

  @override
  Future<NumericEntry> getNumericEntry(String id) {
    // TODO: implement getNumericEntry
    throw UnimplementedError();
  }

  @override
  Future<Queen> getQueen(String id) {
    // TODO: implement getQueen
    throw UnimplementedError();
  }

  @override
  Future<List<Queen>> getQueens() {
    // TODO: implement getQueens
    throw UnimplementedError();
  }

  @override
  Future<Raport> getRaport(String id) {
    // TODO: implement getRaport
    throw UnimplementedError();
  }

  @override
  Future<List<Raport>> getRaports() {
    // TODO: implement getRaports
    throw UnimplementedError();
  }

  @override
  Future<List<TextEntry>> getTextEntries() {
    // TODO: implement getTextEntries
    throw UnimplementedError();
  }

  @override
  Future<TextEntry> getTextEntry(String id) {
    // TODO: implement getTextEntry
    throw UnimplementedError();
  }

  @override
  Future<void> init() {
    // TODO: implement init
    throw UnimplementedError();
  }

  @override
  Future<void> insertApiary(Apiary apiary) {
    // TODO: implement insertApiary
    throw UnimplementedError();
  }

  @override
  Future<void> insertBooleanEntry(BooleanEntry booleanEntry) {
    // TODO: implement insertBooleanEntry
    throw UnimplementedError();
  }

  @override
  Future<void> insertHistoryLog(HistoryLog historyLog) {
    // TODO: implement insertHistoryLog
    throw UnimplementedError();
  }

  @override
  Future<void> insertHive(Hive hive) {
    // TODO: implement insertHive
    throw UnimplementedError();
  }

  @override
  Future<void> insertNumericEntry(NumericEntry numericEntry) {
    // TODO: implement insertNumericEntry
    throw UnimplementedError();
  }

  @override
  Future<void> insertQueen(Queen queen) {
    // TODO: implement insertQueen
    throw UnimplementedError();
  }

  @override
  Future<void> insertRaport(Raport raport) {
    // TODO: implement insertRaport
    throw UnimplementedError();
  }

  @override
  Future<void> insertTextEntry(TextEntry textEntry) {
    // TODO: implement insertTextEntry
    throw UnimplementedError();
  }

  @override
  Future<void> updateApiary(Apiary apiary) {
    // TODO: implement updateApiary
    throw UnimplementedError();
  }

  @override
  Future<void> updateBooleanEntry(BooleanEntry booleanEntry) {
    // TODO: implement updateBooleanEntry
    throw UnimplementedError();
  }

  @override
  Future<void> updateHive(Hive hive) {
    // TODO: implement updateHive
    throw UnimplementedError();
  }

  @override
  Future<void> updateNumericEntry(NumericEntry numericEntry) {
    // TODO: implement updateNumericEntry
    throw UnimplementedError();
  }

  @override
  Future<void> updateQueen(Queen queen) {
    // TODO: implement updateQueen
    throw UnimplementedError();
  }

  @override
  Future<void> updateRaport(Raport raport) {
    // TODO: implement updateRaport
    throw UnimplementedError();
  }

  @override
  Future<void> updateTextEntry(TextEntry textEntry) {
    // TODO: implement updateTextEntry
    throw UnimplementedError();
  }

  @override
  Stream<List<Apiary>> watchApiaries() {
    // TODO: implement watchApiaries
    throw UnimplementedError();
  }

  @override
  Stream<List<BooleanEntry>> watchBooleanEntries() {
    // TODO: implement watchBooleanEntries
    throw UnimplementedError();
  }

  @override
  Stream<List<HistoryLog>> watchHistoryLogs() {
    // TODO: implement watchHistoryLogs
    throw UnimplementedError();
  }

  @override
  Stream<List<Hive>> watchHives() {
    // TODO: implement watchHives
    throw UnimplementedError();
  }

  @override
  Stream<List<NumericEntry>> watchNumericEntries() {
    // TODO: implement watchNumericEntries
    throw UnimplementedError();
  }

  @override
  Stream<List<Queen>> watchQueens() {
    // TODO: implement watchQueens
    throw UnimplementedError();
  }

  @override
  Stream<List<Raport>> watchRaports() {
    // TODO: implement watchRaports
    throw UnimplementedError();
  }

  @override
  Stream<List<TextEntry>> watchTextEntries() {
    // TODO: implement watchTextEntries
    throw UnimplementedError();
  }
}
