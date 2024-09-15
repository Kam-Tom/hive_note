import 'package:app_database/app_database.dart';
import 'package:drift/drift.dart';
import 'package:drift_app_database/src/tabels/tabels.dart';

@UseRowClass(Hive)
class HiveTable extends Table {
  TextColumn get id => text()();
  TextColumn get name => text().withLength(max: 32)();
  IntColumn get order => integer()();
  TextColumn get type => text().withLength(max: 32)(); //Langstroth, Top Bar, Warre
  TextColumn get queenId => text().nullable().references(QueenTable, #id, onDelete: KeyAction.setNull)();
  TextColumn get apiaryId => text().nullable().references(ApiaryTable, #id, onDelete: KeyAction.setNull)();

  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}