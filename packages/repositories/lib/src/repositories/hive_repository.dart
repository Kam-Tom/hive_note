import 'package:app_database/app_database.dart';

class HiveRepository {
  final AppDatabase _database;
  const HiveRepository(AppDatabase database) : _database = database;

  Stream<List<HiveWithQueen>> watchHivesWithQueenByApiary(Apiary? apiary) => _database.watchHivesWithQueenByApiary(apiary);

  Future insertHive(Hive hive) => _database.insertHive(hive);

  Future deleteHive(Hive hive) => _database.deleteHive(hive);

  Future<void> updateHives(List<Hive> hivesToUpdate) =>
      _database.updateHives(hivesToUpdate);
}
