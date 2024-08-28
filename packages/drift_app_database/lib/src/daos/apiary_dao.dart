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
    final apiaryStream = select(apiaryTable).watch();

    final hiveStream = select(hiveTable).watch();

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

}

extension on Apiary {
  ApiaryTableCompanion toCompanion() {
    return ApiaryTableCompanion(
      id: Value(id),
      name: Value(name),
      latitude: Value(latitude),
      longitude: Value(longitude),
      createdAt: Value(createdAt),
    );
  }
}