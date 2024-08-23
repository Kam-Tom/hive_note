import 'package:database/database.dart';
import 'package:drift/drift.dart';

@UseRowClass(ToDo)
class ToDoTable extends Table {
  TextColumn get id => text()();
  TextColumn get location => text().withLength(max: 32)();
  TextColumn get description => text().withLength(max: 128)();
  IntColumn get categoryType => intEnum<CategoryType>()();
  DateTimeColumn get dueTo => dateTime()();
  BoolColumn get isCompleted => boolean()();

  @override
  Set<Column> get primaryKey => {id};
}