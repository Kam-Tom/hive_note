import 'package:db_api/db_api.dart';
import 'package:drift/drift.dart';
import 'package:drift_db_api/src/tabels/tabels.dart';

@UseRowClass(TextEntry)
class TextEntryTable extends Table{
  TextColumn get id => text()();
  TextColumn get raportId => text().references(RaportTable, #id)();
  TextColumn get entryMetadataId => text().references(EntryMetadataTable, #id)();
  TextColumn get value => text()();

  @override
  Set<Column> get primaryKey => {id};
}