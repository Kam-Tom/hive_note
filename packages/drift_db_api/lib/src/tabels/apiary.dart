import 'package:drift/drift.dart';

@DataClassName('ApiaryEntity')
class ApiaryTable extends Table {
  TextColumn get id => text()();
  TextColumn get name => text().withLength(max: 32)();
  RealColumn get latitude => real().nullable()();
  RealColumn get longitude => real().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
