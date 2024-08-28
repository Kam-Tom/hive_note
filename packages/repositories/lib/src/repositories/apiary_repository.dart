import 'package:app_database/app_database.dart';

class ApiaryRepository {

  final AppDatabase _database;
  const ApiaryRepository(AppDatabase database) : _database = database;
  
  Stream<List<Apiary>> watchApiaries() => _database.watchApiaries();
  
}
