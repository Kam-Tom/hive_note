import 'package:app_database/app_database.dart';

class QueenRepository {
  final AppDatabase _database;
  const QueenRepository(AppDatabase database) : _database = database;

  Stream<List<QueenWithHive>> watchQueensWithHiveByApiary(Apiary? apiary) => _database.watchQueensWithHiveByApiary(apiary);

  Future insertQueen(Queen queen) => _database.insertQueen(queen);

  Future deleteQueen(Queen queen) => _database.deleteQueen(queen);

}
