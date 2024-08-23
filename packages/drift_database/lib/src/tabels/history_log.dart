import 'package:database/database.dart';
import 'package:drift/drift.dart';

@UseRowClass(HistoryLog)
class HistoryLogTable extends Table {
  TextColumn get id => text()();
  TextColumn get referenceId => text()(); // id of the changed object
  IntColumn get tableType => intEnum<TableType>()();
  IntColumn get actionType => intEnum<ActionType>()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

