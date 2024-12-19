import 'package:app_database/app_database.dart';

class ApiaryRepository {

  final AppDatabase _database;
  const ApiaryRepository(AppDatabase database) : _database = database;
  
  Stream<List<ApiaryWithHiveCount>> watchApiariesWithHiveCount({bool onlyActive = true}) => _database.watchApiariesWithHiveCount(onlyActive);
  
  Stream<List<Apiary>> watchApiaries() => _database.watchApiaries();

  Future<Apiary> getApiary(String apiaryId) => _database.getApiary(apiaryId);
  
  Future insertApiary(Apiary apiary) async {
    await _database.insertApiary(apiary);
    await _database.insertHistoryLog(HistoryLog(
      referenceId: apiary.id,
      logType: LogType.apiary,
      actionType: ActionType.create,
    ));

  }

  Future updateApiary(Apiary apiary) async {
    await _database.updateApiary(apiary);
    await _database.insertHistoryLog(HistoryLog(
      referenceId: apiary.id,
      logType: LogType.apiary,
      actionType: ActionType.update,
    ));
    
  } 

  Future<void> updateApiaries(List<Apiary> apiariesToUpdate) async {
    await _database.updateApiaries(apiariesToUpdate);

    for (final apiary in apiariesToUpdate) {
      await _database.insertHistoryLog(HistoryLog(
        referenceId: apiary.id,
        logType: LogType.apiary,
        actionType: ActionType.update,
        shadowLog: true,
      ));
    }
  }
  
  Future<void> deleteApiary(Apiary apiary) async {
    await _database.deleteApiary(apiary);

    await _database.insertHistoryLog(HistoryLog(
      referenceId: apiary.id,
      logType: LogType.apiary,
      actionType: ActionType.delete,
    ));
    
  } 

  Stream<ApiaryWithHives> watchApiaryWithHives(String apiaryId) => _database.watchApiaryWithHives(apiaryId);

  Future<List<Apiary>> getApiaries() => _database.getApiaries();

  Future<Apiary?> getApiaryForHive(Hive hive) {
    if(hive.apiaryId == null) {
      return Future.value(null);
    }
    return getApiary(hive.apiaryId!);
  }
}
