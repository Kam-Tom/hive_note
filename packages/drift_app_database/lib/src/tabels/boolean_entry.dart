import 'package:app_database/app_database.dart';
import 'package:drift/drift.dart';
import 'package:drift_app_database/src/tabels/tabels.dart';

@UseRowClass(BooleanEntry)
class BooleanEntryTable extends Table {
  TextColumn get id => text()();
  TextColumn get raportId => text().references(RaportTable, #id)();
  TextColumn get entryMetadataId => text().references(EntryMetadataTable, #id)();
  BoolColumn get value => boolean()();

  @override
  Set<Column> get primaryKey => {id};
}
