import 'package:db_api/db_api.dart';
import 'package:drift/drift.dart';
import 'package:drift_db_api/src/tabels/tabels.dart';

@UseRowClass(Raport)
class RaportTable extends Table{
  TextColumn get id => text()();
  TextColumn get hiveId => text().nullable().references(HiveTable, #id)();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}