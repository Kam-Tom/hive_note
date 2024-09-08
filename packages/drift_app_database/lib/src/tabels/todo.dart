import 'package:app_database/app_database.dart';
import 'package:drift/drift.dart';

@UseRowClass(Todo)
class TodoTable extends Table {
  TextColumn get id => text()();
  TextColumn get location => text().withLength(max: 32)();
  TextColumn get description => text().withLength(max: 256)();
  IntColumn get categoryType => intEnum<CategoryType>()();
  DateTimeColumn get dueTo => dateTime()();
  BoolColumn get isCompleted => boolean()();

  @override
  Set<Column> get primaryKey => {id};
}