import 'package:app_database/app_database.dart';
import 'package:drift/drift.dart';
import 'package:drift_app_database/drift_app_database.dart';
import 'package:drift_app_database/src/tabels/tabels.dart';
import 'package:rxdart/rxdart.dart';

part 'hive_dao.g.dart';

@DriftAccessor(tables: [HiveTable, QueenTable])
class HiveDao extends DatabaseAccessor<DriftAppDatabase> with _$HiveDaoMixin {
  HiveDao(DriftAppDatabase db) : super(db);

  Stream<List<HiveWithQueen>> watchHivesWithQueenByApiary(Apiary? apiary) {
    final hiveStream = (select(hiveTable)
          ..orderBy([(a) => OrderingTerm(expression: a.order)])
          ..where((h) => h.apiaryId.equalsNullable(apiary?.id))).watch();
        
    final queenStream = select(queenTable).watch();

    final rx = Rx.combineLatest2(
      hiveStream,
      queenStream,
      (List<Hive> hives, List<Queen> queens) {
        final queenMap = {
          for (var queen in queens)
            if (queen.hiveId != null) queen.hiveId: queen
        };

        return hives.map((hive) {
          final queen = queenMap[hive.id];
          return HiveWithQueen(hive: hive, queen: queen);
        }).toList();
      },
    );

    return rx;
  }

  Future insertHive(Hive hive) => into(hiveTable).insert(hive.toCompanion());

  Future updateHive(Hive hive) => update(hiveTable).replace(hive.toCompanion());

  Future deleteHive(Hive hive) =>
      (delete(hiveTable)..where((t) => t.id.equals(hive.id))).go();

  Future updateHives(List<Hive> hivesToUpdate) {
    return batch((batch) {
      batch.replaceAll(
          hiveTable, hivesToUpdate.map((hive) => hive.toCompanion()));
    });
  }
}

extension on Hive {
  HiveTableCompanion toCompanion() {
    return HiveTableCompanion(
      id: Value(id),
      name: Value(name),
      order: Value(order),
      type: Value(type),
      apiaryId: Value(apiaryId),
      createdAt: Value(createdAt),
    );
  }
}
