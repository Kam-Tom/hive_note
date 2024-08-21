import 'package:db_api/db_api.dart';

abstract class NumericEntryDbApi {
  
  Future<NumericEntry> getNumericEntry(String id);
  Future<List<NumericEntry>> getNumericEntries();
  Stream<List<NumericEntry>> watchNumericEntries();
  Future<void> insertNumericEntry(NumericEntry numericEntry);
  Future<void> updateNumericEntry(NumericEntry numericEntry);
  Future<void> deleteNumericEntry(NumericEntry numericEntry);
}