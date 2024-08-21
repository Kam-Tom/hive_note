import 'package:db_api/db_api.dart';
import 'package:drift/drift.dart';

@DataClassName('EntryMetadataEntity')
class EntryMetadataTable extends Table {
  TextColumn get id => text()();
  TextColumn get label => text().withLength(max: 32)();
  TextColumn get hint => text().withLength(max: 32)();
  IntColumn get valueType => intEnum<EntryType>()();
  IntColumn get raportType => intEnum<RaportType>()();

  @override
  Set<Column> get primaryKey => {id};
}