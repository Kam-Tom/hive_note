import 'package:app_database/app_database.dart';

class RaportRepository {
  final AppDatabase _database;
  const RaportRepository(AppDatabase database) : _database = database;

  Future<void> insertRaport(Raport raport, List<Entry> entries) => _database.insertRaport(raport, entries);
  Future<void> updateRaport(Raport raport, List<Entry> entries) => _database.updateRaport(raport, entries);
  Future<void> deleteRaport(Raport raport) => _database.deleteRaport(raport);

}
