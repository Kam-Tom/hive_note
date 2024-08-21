import 'package:db_api/db_api.dart';

abstract class RaportDbApi {

  Future<Raport> getRaport(String id);
  Future<List<Raport>> getRaports();
  Stream<List<Raport>> watchRaports();
  Future<void> insertRaport(Raport raport);
  Future<void> updateRaport(Raport raport);
  Future<void> deleteRaport(Raport raport);
}