import 'package:db_api/db_api.dart';

abstract class QueenDbApi {
  
  Future<Queen> getQueen(String id);
  Future<List<Queen>> getQueens();
  Stream<List<Queen>> watchQueens();
  Future<void> insertQueen(Queen queen);
  Future<void> updateQueen(Queen queen);
  Future<void> deleteQueen(Queen queen);
}