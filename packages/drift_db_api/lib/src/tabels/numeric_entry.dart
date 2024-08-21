import 'package:drift/drift.dart';
import 'package:drift_db_api/src/tabels/tabels.dart';

@DataClassName('NumericEntryEntity')
class NumericEntryTable extends Table {
  TextColumn get id => text()();
  TextColumn get raportId => text().references(RaportTable, #id)();
  TextColumn get entryMetadataId => text().references(EntryMetadataTable, #id)();
  RealColumn get value => real()();

  @override
  Set<Column> get primaryKey => {id};
}