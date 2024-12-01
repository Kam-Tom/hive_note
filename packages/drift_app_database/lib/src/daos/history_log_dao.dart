import 'package:app_database/app_database.dart';
import 'package:drift/drift.dart';
import 'package:drift_app_database/drift_app_database.dart';
import 'package:drift_app_database/src/tabels/tabels.dart';
import 'package:rxdart/rxdart.dart';

part 'history_log_dao.g.dart';

@DriftAccessor(tables: [HistoryLogTable])
class HistoryLogDao extends DatabaseAccessor<DriftAppDatabase>
    with _$HistoryLogDaoMixin {
  HistoryLogDao(DriftAppDatabase db) : super(db);

// Stream<List<ApiaryWithHiveCount>> watchApiariesWithHiveCount(onlyActive) {
//   final query = select(apiaryTable).join([
//     leftOuterJoin(hiveTable, hiveTable.apiaryId.equalsExp(apiaryTable.id), useColumns: false)
//   ]);

//   if (onlyActive) {
//     query.where(apiaryTable.isActive.equals(true));
//   }

//   query
//     ..groupBy([apiaryTable.id])
//     ..addColumns([hiveTable.id.count()])
//     ..orderBy([OrderingTerm(expression: apiaryTable.order)]);

//   return query.watch().map((rows) {
//     return rows.map((row) {
//       final apiary = row.readTable(apiaryTable);
//       final hiveCount = row.read(hiveTable.id.count());
//       return ApiaryWithHiveCount(apiary: apiary, hiveCount: hiveCount!);
//     }).toList();
//   });
// }

//   Stream<List<Apiary>> watchApiaries() =>
//       select(apiaryTable).watch();

//   Future insertApiary(Apiary apiary) =>
//       into(apiaryTable).insert(apiary.toCompanion());

//   Future updateApiary(Apiary apiary) =>
//       update(apiaryTable).replace(apiary.toCompanion());

//   Future deleteApiary(Apiary apiary) =>
//       (delete(apiaryTable)..where((t) => t.id.equals(apiary.id))).go();

//   Future updateApiaries(List<Apiary> apiariesToUpdate) {
//     return batch((batch) {
//       batch.replaceAll(
//         apiaryTable,
//         apiariesToUpdate.map((apiary) => apiary.toCompanion()),
//       );
//     });
//   }

//   Stream<ApiaryWithHives> watchApiaryWithHives(String apiaryId) {
//     final apiaryStream = (select(apiaryTable)
//           ..where((tbl) => tbl.id.equals(apiaryId)))
//         .watchSingle();

//     final hivesStream = (select(hiveTable)
//           ..where((tbl) => tbl.apiaryId.equals(apiaryId))
//           ..orderBy([(t) => OrderingTerm(expression: t.order)]))
//         .watch();

//     return Rx.combineLatest2(
//       apiaryStream,
//       hivesStream,
//       (Apiary apiary, List<Hive> hives) =>
//           ApiaryWithHives(apiary: apiary, hives: hives),
//     );
//   }
}

// extension on Apiary {
//   ApiaryTableCompanion toCompanion() {
//     return ApiaryTableCompanion(
//       id: Value(id),
//       name: Value(name),
//       order: Value(order),
//       colorValue: Value(color.value),
//       isActive: Value(isActive),
//       createdAt: Value(createdAt),
//     );
//   }
// }
