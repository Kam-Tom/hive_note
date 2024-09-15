import 'package:app_database/app_database.dart';
import 'package:drift/drift.dart';

@UseRowClass(Apiary)
class ApiaryTable extends Table {
  TextColumn get id => text()();
  TextColumn get name => text().withLength(max: 32)();
  IntColumn get order => integer()();
  IntColumn get colorValue => integer()();
  BoolColumn get isActive => boolean()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

