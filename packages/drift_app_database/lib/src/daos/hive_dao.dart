import 'package:app_database/app_database.dart';
import 'package:drift/drift.dart';
import 'package:drift_app_database/drift_app_database.dart';
import 'package:drift_app_database/src/tabels/tabels.dart';

part 'hive_dao.g.dart';


@DriftAccessor(tables: [HiveTable])
class HiveDao extends DatabaseAccessor<DriftAppDatabase> with _$HiveDaoMixin {
  HiveDao(DriftAppDatabase db) : super(db);

  Future insertHive(Hive hive) => into(hiveTable).insert(hive.toCompanion());

  Future updateHive(Hive hive) => update(hiveTable).replace(hive.toCompanion());

  Future deleteHive(Hive hive) => (delete(hiveTable)..where((t) => t.id.equals(hive.id))).go();

}

extension on Hive {
  HiveTableCompanion toCompanion() {
    return HiveTableCompanion(
      id: Value(id),
      name: Value(name),
      order: Value(order),
      type: Value(type),
      queenId: Value(queenId),
      apiaryId: Value(apiaryId),
      createdAt: Value(createdAt),
    );
  }
}