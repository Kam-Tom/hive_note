import 'package:app_database/app_database.dart';
import 'package:drift/drift.dart';
import 'package:drift_app_database/src/tabels/tabels.dart';

@UseRowClass(NumericEntry)
class NumericEntryTable extends Table {
  TextColumn get id => text()();
  TextColumn get raportId => text().references(RaportTable, #id)();
  TextColumn get entryMetadataId => text().references(EntryMetadataTable, #id)();
  RealColumn get value => real()();

  @override
  Set<Column> get primaryKey => {id};
}