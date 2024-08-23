import 'package:db_api/db_api.dart';
import 'package:drift/drift.dart';
import 'package:drift_db_api/src/tabels/tabels.dart';

@UseRowClass(BooleanEntry)
class BooleanEntryTable extends Table {
  TextColumn get id => text()();
  TextColumn get raportId => text().references(RaportTable, #id)();
  TextColumn get entryMetadataId => text().references(EntryMetadataTable, #id)();
  BoolColumn get value => boolean()();

  @override
  Set<Column> get primaryKey => {id};
}
