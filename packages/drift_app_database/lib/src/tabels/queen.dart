import 'package:app_database/app_database.dart';
import 'package:drift/drift.dart';
import 'package:drift_app_database/src/tabels/tabels.dart';

@UseRowClass(Queen)
class QueenTable extends Table {

  // Color can be derived from the birthDate
  
  TextColumn get id => text()();
  TextColumn get hiveId => text().nullable().references(HiveTable, #id, onDelete: KeyAction.setNull)();
  TextColumn get breed => text().withLength(max: 32)();
  TextColumn get origin => text().withLength(max: 32)();
  DateTimeColumn get birthDate => dateTime()();
  BoolColumn get isAlive => boolean().withDefault(Constant(true))();


  @override
  Set<Column> get primaryKey => {id};
}