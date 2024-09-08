import 'package:app_database/app_database.dart';

class ApiaryRepository {

  final AppDatabase _database;
  const ApiaryRepository(AppDatabase database) : _database = database;
  
  Stream<List<Apiary>> watchApiaries() => _database.watchApiaries();
  
  Future insertApiary(Apiary apiary) => _database.insertApiary(apiary);
  
  Future insertHive(Hive hive) => _database.insertHive(hive);
}
