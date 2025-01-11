import 'package:app_database/app_database.dart';

class HiveRepository {
  final AppDatabase _database;
  const HiveRepository(AppDatabase database) : _database = database;

  Stream<List<HiveWithQueen>> watchHivesWithQueenByApiary(Apiary? apiary) => _database.watchHivesWithQueenByApiary(apiary);
  
  Stream<HiveWithQueen> watchHiveWithQueen(String hiveId) => _database.watchHiveWithQueen(hiveId);

  Future<List<HiveWithQueen>> getHivesWithQueenByApiary(Apiary? apiary) => _database.getHivesWithQueenByApiary(apiary);

  Future insertHive(Hive hive) async {
    await _database.insertHive(hive);
    await _database.insertHistoryLog(HistoryLog(
      referenceId: hive.id,
      logType: LogType.hive,
      actionType: ActionType.create,
    ));
  }

  Future deleteHive(Hive hive) async {
    await _database.deleteHive(hive);
    await _database.insertHistoryLog(HistoryLog(
      referenceId: hive.id,
      logType: LogType.hive,
      actionType: ActionType.delete,
    ));
  } 

  Future<void> updateHive(Hive hive) async {
    await _database.updateHive(hive);

    await _database.insertHistoryLog(HistoryLog(
      referenceId: hive.id,
      logType: LogType.hive,
      actionType: ActionType.update,
    ));
  }

  Future<void> updateHives(List<Hive> hivesToUpdate) async {
    await _database.updateHives(hivesToUpdate);

    await _database.insertHistoryLog(HistoryLog(
      referenceId: hivesToUpdate.first.id,
      logType: LogType.hive,
      actionType: ActionType.update,
      shadowLog: true,
    ));
  }

  Future<List<Hive>> getHivesByApiary(Apiary? apiary) => _database.getHivesByApiary(apiary);

  Future<Hive> getHive(String hiveId) => _database.getHive(hiveId);

  Future<Hive?> getHiveForQueen(Queen queen) {
    if (queen.hiveId == null) {
      return Future.value(null);
    }
    return _database.getHive(queen.hiveId!);
  }

}
