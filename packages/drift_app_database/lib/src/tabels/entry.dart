import 'package:app_database/app_database.dart';
import 'package:drift/drift.dart';
import 'package:drift_app_database/src/tabels/tabels.dart';

@UseRowClass(Entry)
class EntryTable extends Table{
  TextColumn get id => text()();
  TextColumn get raportId => text().references(RaportTable, #id, onDelete: KeyAction.cascade)();
  TextColumn get entryMetadataId => text().references(EntryMetadataTable, #id)();
  TextColumn get value => text()();

  @override
  Set<Column> get primaryKey => {id};
}