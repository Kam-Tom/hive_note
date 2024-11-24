import 'package:app_database/app_database.dart';

class QueenRepository {
  final AppDatabase _database;
  const QueenRepository(AppDatabase database) : _database = database;

  Stream<List<QueenWithHive>> watchQueensWithHiveByApiary(Apiary? apiary) => _database.watchQueensWithHiveByApiary(apiary);
  
  Stream<List<Queen>> watchAvailableQueens() => _database.watchAvailableQueens();

  Future insertQueen(Queen queen) => _database.insertQueen(queen);

  Future deleteQueen(Queen queen) => _database.deleteQueen(queen);

  Future updateQueen(Queen queen) => _database.updateQueen(queen);
  
  Stream<Queen> watchQueen(String queenId) => _database.watchQueen(queenId);

}
