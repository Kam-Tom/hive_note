import 'package:app_database/app_database.dart';
import 'package:drift/drift.dart';
import 'package:drift_app_database/drift_app_database.dart';
import 'package:drift_app_database/src/tabels/tabels.dart';
import 'package:rxdart/rxdart.dart';

part 'apiary_dao.g.dart';


@DriftAccessor(tables: [ApiaryTable, HiveTable])
class ApiaryDao extends DatabaseAccessor<DriftAppDatabase> with _$ApiaryDaoMixin {
  ApiaryDao(DriftAppDatabase db) : super(db);

  Stream<List<Apiary>> watchApiaries() {
    final apiaryStream = (select(apiaryTable)
      ..orderBy([(a) => OrderingTerm(expression: a.order)])).watch();

    final hiveStream = (select(hiveTable)
      ..orderBy([(h) => OrderingTerm(expression: h.order)])).watch();

    return Rx.combineLatest2(
        apiaryStream, hiveStream,
        (List<Apiary> a, List<Hive> b) {
      return a.map((apiary) {
        final hives = b.where((hive) => hive.apiaryId == apiary.id).toList();

        return apiary.copyWith(hives: hives);

      }).toList();
    });
  }

  Future insertApiary(Apiary apiary) => into(apiaryTable).insert(apiary.toCompanion());

  Future updateApiary(Apiary apiary) => update(apiaryTable).replace(apiary.toCompanion());

  Future deleteApiary(Apiary apiary) => (delete(apiaryTable)..where((t) => t.id.equals(apiary.id))).go();
  
  Future updateApiaries(List<Apiary> apiariesToUpdate) {

    return batch((batch) {
      batch.replaceAll(apiaryTable,
       apiariesToUpdate.map((apiary) => apiary.toCompanion()),
      );
    });

  }

  Stream<Apiary> watchApiary(String id) {
    final apiaryStream = (select(apiaryTable)
      ..where((a) => a.id.equals(id))).watchSingle();

    final hiveStream = (select(hiveTable)
      ..where((h) => h.apiaryId.equals(id))
      ..orderBy([(h) => OrderingTerm(expression: h.order)])).watch();

    return Rx.combineLatest2(
      apiaryStream,    
      hiveStream,      
      (Apiary apiary, List<Hive> hives) {
        return apiary.copyWith(hives: hives);
      },
    );
  }


}

extension on Apiary {
  ApiaryTableCompanion toCompanion() {
    return ApiaryTableCompanion(
      id: Value(id),
      name: Value(name),
      order: Value(order),
      colorValue: Value(color.value),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
    );
  }
}