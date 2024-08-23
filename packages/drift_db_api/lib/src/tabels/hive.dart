import 'package:db_api/db_api.dart';
import 'package:drift/drift.dart';
import 'package:drift_db_api/src/tabels/tabels.dart';

@UseRowClass(Hive)
class HiveTable extends Table {
  TextColumn get id => text()();
  TextColumn get name => text().withLength(max: 32)();
  IntColumn get order => integer()();
  TextColumn get type => text().withLength(max: 32)(); //Langstroth, Top Bar, Warre
  TextColumn get queenId => text().nullable().references(QueenTable, #id)();
  TextColumn get apiaryId => text().nullable().references(ApiaryTable, #id)();

  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}