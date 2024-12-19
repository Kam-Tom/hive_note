import 'package:app_database/app_database.dart';
import 'package:drift/drift.dart';

@UseRowClass(HistoryLog)
class HistoryLogTable extends Table {
  TextColumn get id => text()();
  TextColumn get referenceId => text()(); // id of the changed object
  IntColumn get logType => intEnum<LogType>()();
  IntColumn get actionType => intEnum<ActionType>()();
  DateTimeColumn get createdAt => dateTime()();
  BoolColumn get shadowLog => boolean()();

  @override
  Set<Column> get primaryKey => {id};
}

