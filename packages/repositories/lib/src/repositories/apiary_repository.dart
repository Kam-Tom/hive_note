import 'package:app_database/app_database.dart';

class ApiaryRepository {

  final AppDatabase _database;
  const ApiaryRepository(AppDatabase database) : _database = database;
  
  Stream<List<ApiaryWithHiveCount>> watchApiariesWithHiveCount({bool onlyActive = true}) => _database.watchApiariesWithHiveCount(onlyActive);
  
  Stream<List<Apiary>> watchApiaries() => _database.watchApiaries();

  Future<Apiary> getApiary(String apiaryId) => _database.getApiary(apiaryId);
  
  Future insertApiary(Apiary apiary) => _database.insertApiary(apiary);

  Future updateApiary(Apiary apiary)  => _database.updateApiary(apiary);

  Future<void> updateApiaries(List<Apiary> apiariesToUpdate) => _database.updateApiaries(apiariesToUpdate);
  
  Future<void> deleteApiary(Apiary apiary) => _database.deleteApiary(apiary);

  Stream<ApiaryWithHives> watchApiaryWithHives(String apiaryId) => _database.watchApiaryWithHives(apiaryId);
}
