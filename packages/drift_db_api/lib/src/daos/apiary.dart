import 'package:db_api/db_api.dart';
import 'package:drift/drift.dart';
import 'package:drift_db_api/drift_db_api.dart';
import 'package:drift_db_api/src/tabels/tabels.dart';

part 'apiary.g.dart';

// the ApiaryDaoMixin will be created by drift. It contains all the necessary
// fields for the tables. The <DriftDbApi> type annotation is the database class
// that should use this dao.
@DriftAccessor(tables: [ApiaryTable])
class ApiaryDao extends DatabaseAccessor<DriftDbApi> with _$ApiaryDaoMixin {
  // this constructor is required so that the main database can create an instance
  // of this object.
  ApiaryDao(DriftDbApi db) : super(db);
  
  Future<Apiary> getApiary(String id) async {
    final apiaryQuery = select(apiaryTable)..where((item) => item.id.equals(id));

    final apiary = await apiaryQuery.getSingle().onError((error, stackTrace) {
      throw ResourceNotFoundException('Apiary with id $id not found');
    });

    return Apiary(
      id: apiary.id,
      name: apiary.name,
      latitude: apiary.latitude,
      longitude: apiary.longitude,
      createdAt: apiary.createdAt,
    );
  }

  Stream<List<Apiary>> watchApiaries() {
    final apiaryQuery = select(apiaryTable);
    return apiaryQuery.map((row) => Apiary(
      id: row.id,
      name: row.name,
      latitude: row.latitude,
      longitude: row.longitude,
      createdAt: row.createdAt,
    )).watch();
  }

  Future<List<Apiary>> getApiaries() async {
    final apiaryQuery = select(apiaryTable);
    final apiaries = await apiaryQuery.get();
    return apiaries.map((row) => Apiary(
      id: row.id,
      name: row.name,
      latitude: row.latitude,
      longitude: row.longitude,
      createdAt: row.createdAt,
    )).toList();
  }

  Future<void> insertApiary(Apiary apiary) async {
    final companion = ApiaryTableCompanion(
      id: Value(apiary.id),
      name: Value(apiary.name),
      latitude: Value(apiary.latitude),
      longitude: Value(apiary.longitude),
      createdAt: Value(apiary.createdAt),
    );
    await into(apiaryTable).insert(companion).onError(
      (error, stackTrace) {
        throw ResourceAlreadyExistsException('Apiary with id ${apiary.id} already exists');
      },
    );
  }

  Future<void> updateApiary(Apiary apiary) async {
    final companion = ApiaryTableCompanion(
      id: Value(apiary.id),
      name: Value(apiary.name),
      latitude: Value(apiary.latitude),
      longitude: Value(apiary.longitude),
      createdAt: Value(apiary.createdAt),
    );

    bool replaced = await update(apiaryTable).replace(companion);
    if(!replaced){
      throw ResourceNotFoundException('Apiary with id ${apiary.id} not found');
    };
  }

  Future<void> deleteApiary(Apiary apiary) async {
    final rows = await (delete(apiaryTable)..where((item) => item.id.equals(apiary.id))).go();
    if(rows == 0) {
      throw ResourceNotFoundException('Apiary with id ${apiary.id} not found');
    }
  }
}