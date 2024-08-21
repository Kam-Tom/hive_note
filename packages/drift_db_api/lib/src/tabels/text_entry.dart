import 'package:drift/drift.dart';
import 'package:drift_db_api/src/tabels/tabels.dart';

@DataClassName('TextEntryEntity')
class TextEntryTable extends Table{
  TextColumn get id => text()();
  TextColumn get raportId => text().references(RaportTable, #id)();
  TextColumn get entryMetadataId => text().references(EntryMetadataTable, #id)();
  TextColumn get value => text()();

  @override
  Set<Column> get primaryKey => {id};
}