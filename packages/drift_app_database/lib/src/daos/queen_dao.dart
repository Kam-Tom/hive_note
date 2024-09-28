import 'package:app_database/app_database.dart';
import 'package:drift/drift.dart';
import 'package:drift_app_database/drift_app_database.dart';
import 'package:drift_app_database/src/tabels/tabels.dart';
import 'package:rxdart/rxdart.dart';

part 'queen_dao.g.dart';

@DriftAccessor(tables: [HiveTable, QueenTable])
class QueenDao extends DatabaseAccessor<DriftAppDatabase> with _$QueenDaoMixin {
  QueenDao(DriftAppDatabase db) : super(db);

  Stream<List<QueenWithHive>> watchQueensWithHiveByApiary(Apiary? apiary) {
    final hiveStream = (select(hiveTable)
          ..where((h) => h.apiaryId.equalsNullable(apiary?.id)))
        .watch();

    final queenStream = (select(queenTable)
          ..orderBy([
            (q) =>
                OrderingTerm(expression: q.birthDate)
          ]))
        .watch();

    final rx = Rx.combineLatest2(
      hiveStream,
      queenStream,
      (List<Hive> hives, List<Queen> queens) {
        final hiveMap = {for (var hive in hives) hive.id: hive};

        final List<QueenWithHive> queenWithHive = [];

        for (final queen in queens) {
          final hive = hiveMap[queen.hiveId];
          if (apiary != null) {
            if (hive?.apiaryId != apiary.id) continue;
            if (hive == null) continue;
          }
          queenWithHive.add(QueenWithHive(queen: queen, hive: hive));
        }

        return queenWithHive;
      },
    );

    return rx;
  }

  Future insertQueen(Queen queen) =>
      into(queenTable).insert(queen.toCompanion());

  Future updateQueen(Queen queen) =>
      update(queenTable).replace(queen.toCompanion());

  Future deleteQueen(Queen queen) =>
      (delete(queenTable)..where((q) => q.id.equals(queen.id))).go();
}

extension on Queen {
  QueenTableCompanion toCompanion() {
    return QueenTableCompanion(
      id: Value(id),
      hiveId: hiveId != null ? Value(hiveId) : const Value.absent(),
      breed: Value(breed),
      origin: Value(origin),
      birthDate: Value(birthDate),
      isAlive: Value(isAlive),
    );
  }
}
