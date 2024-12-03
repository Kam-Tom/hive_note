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

  Stream<HiveWithQueen> watchHiveWithQueen(String hiveId) {
    final hiveStream = (select(hiveTable)
          ..where((h) => h.id.equals(hiveId)))
        .watchSingle();

    final queenStream = select(queenTable)
      .watch();

    return Rx.combineLatest2(
      hiveStream,
      queenStream,
      (Hive hive, List<Queen> queens) {
        Queen? queen = null;
        for (final q in queens) {
          if (q.hiveId == hive.id) {
            queen = q;
            break;
          }
        }
        return HiveWithQueen(hive: hive, queen: queen);
      }
    );
  }
  
  Stream<ApiaryWithHives> watchApiaryWithHives(String apiaryId) {
    final apiaryStream = (select(apiaryTable)
          ..where((a) => a.id.equals(apiaryId)))
        .watchSingle();

    final hivesStream = (select(hiveTable)
          ..where((h) => h.apiaryId.equals(apiaryId))
          ..orderBy([(h) => OrderingTerm(expression: h.order)]))
        .watch();

    return Rx.combineLatest2(
      apiaryStream,
      hivesStream,
      (Apiary apiary, List<Hive> hives) => ApiaryWithHives(
        apiary: apiary,
        hives: hives,
      ),
    );
  }

  Future<List<HiveWithQueen>> getHivesWithQueenByApiary(Apiary? apiary) async {
    final hives = await (select(hiveTable)
          ..orderBy([(a) => OrderingTerm(expression: a.order)])
          ..where((h) => h.apiaryId.equalsNullable(apiary?.id)))
        .get();

    final queens = await select(queenTable).get();

    final queenMap = {for (var queen in queens) queen.hiveId: queen};

    return hives.map((hive) {
      final queen = queenMap[hive.id]; 
      return HiveWithQueen(hive: hive, queen: queen); 
    }).toList();
  }

  Future<List<Hive>> getHivesByApiary(Apiary? apiary) async {
    if(apiary == null) {
      return (select(hiveTable)..where((h) => h.apiaryId.isNull())).get();
    }
    return (select(hiveTable)..where((h) => h.apiaryId.equals(apiary.id))).get();
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
