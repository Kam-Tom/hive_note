import 'package:app_database/app_database.dart';

class ApiaryRepository {

  final AppDatabase _database;
  const ApiaryRepository(AppDatabase database) : _database = database;
  
  Stream<List<Apiary>> watchApiaries() => _database.watchApiaries();
  
  Future insertApiary(Apiary apiary) => _database.insertApiary(apiary);
  
  Future insertHive(Hive hive) => _database.insertHive(hive);

  Future updateApiary(Apiary apiary)  => _database.updateApiary(apiary);

  Future<void> updateApiaries(List<Apiary> apiariesToUpdate) => _database.updateApiaries(apiariesToUpdate);
  
  Future<void> updateHives(List<Hive> hivesToUpdate) => _database.updateHives(hivesToUpdate);

  Stream<Apiary> watchApiary(String id) => _database.watchApiary(id);

  Future<void> deleteApiary(Apiary apiary) => _database.deleteApiary(apiary);
}
