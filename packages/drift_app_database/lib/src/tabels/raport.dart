import 'package:app_database/app_database.dart';
import 'package:drift/drift.dart';
import 'package:drift_app_database/src/tabels/tabels.dart';

@UseRowClass(Raport)
class RaportTable extends Table{
  TextColumn get id => text()();
  TextColumn get hiveId => text().nullable().references(HiveTable, #id)();
  TextColumn get apiaryId => text().nullable().references(ApiaryTable, #id)();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}