import 'package:db_api/db_api.dart';

abstract class ApiaryDbApi {

  Future<Apiary> getApiary(String id);
  Future<List<Apiary>> getApiaries();
  Stream<List<Apiary>> watchApiaries();
  Future<void> insertApiary(Apiary apiary);
  Future<void> updateApiary(Apiary apiary);
  Future<void> deleteApiary(Apiary apiary);
}