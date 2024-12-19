import 'package:app_database/app_database.dart';

class QueenRepository {
  final AppDatabase _database;
  const QueenRepository(AppDatabase database) : _database = database;

  Stream<List<QueenWithHive>> watchQueensWithHiveByApiary(Apiary? apiary) => _database.watchQueensWithHiveByApiary(apiary);
  
  Stream<List<Queen>> watchAvailableQueens() => _database.watchAvailableQueens();

  Future insertQueen(Queen queen) async {
    await _database.insertQueen(queen);

    await _database.insertHistoryLog(
      HistoryLog(
        referenceId: queen.id,
        logType: LogType.queen,
        actionType: ActionType.create,
      ),
    );
  } 

  Future deleteQueen(Queen queen) async {
    await _database.deleteQueen(queen);

    await _database.insertHistoryLog(
      HistoryLog(
        referenceId: queen.id,
        logType: LogType.queen,
        actionType: ActionType.delete,
      ),
    );
  } 

  Future updateQueen(Queen queen) async {
    await _database.updateQueen(queen);

    await _database.insertHistoryLog(
      HistoryLog(
        referenceId: queen.id,
        logType: LogType.queen,
        actionType: ActionType.update,
      ),
    );

  } 
  
  Stream<Queen> watchQueen(String queenId) => _database.watchQueen(queenId);

  Future<Queen?> getQueenForHive(Hive hive) => _database.getQueenForHive(hive);

  Future<Queen> getQueen(String queenId) => _database.getQueen(queenId);

}
