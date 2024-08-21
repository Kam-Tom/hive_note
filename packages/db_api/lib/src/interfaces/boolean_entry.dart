import 'package:db_api/db_api.dart';

abstract class BooleanEntryDbApi {
  
  Future<BooleanEntry> getBooleanEntry(String id);
  Future<List<BooleanEntry>> getBooleanEntries();
  Stream<List<BooleanEntry>> watchBooleanEntries();
  Future<void> insertBooleanEntry(BooleanEntry booleanEntry);
  Future<void> updateBooleanEntry(BooleanEntry booleanEntry);
  Future<void> deleteBooleanEntry(BooleanEntry booleanEntry);
}