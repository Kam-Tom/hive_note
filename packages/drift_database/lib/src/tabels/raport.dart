import 'package:database/database.dart';
import 'package:drift/drift.dart';
import 'package:drift_database/src/tabels/tabels.dart';

@UseRowClass(Raport)
class RaportTable extends Table{
  TextColumn get id => text()();
  TextColumn get hiveId => text().nullable().references(HiveTable, #id)();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}