import 'package:db_api/db_api.dart';

abstract class HiveDbApi {
  Future<Hive> getHive(String id);
  Future<List<Hive>> getHives();
  Stream<List<Hive>> watchHives();
  Future<void> insertHive(Hive hive);
  Future<void> updateHive(Hive hive);
  Future<void> deleteHive(Hive hive);
}