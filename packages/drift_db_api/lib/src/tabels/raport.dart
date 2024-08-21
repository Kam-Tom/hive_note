import 'package:drift/drift.dart';
import 'package:drift_db_api/src/tabels/tabels.dart';

@DataClassName('RaportEntity')
class RaportTable extends Table{
  TextColumn get id => text()();
  TextColumn get hiveId => text().nullable().references(HiveTable, #id)();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}