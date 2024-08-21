import 'package:db_api/db_api.dart';

abstract class TextEntryDbApi {
  
  Future<TextEntry> getTextEntry(String id);
  Future<List<TextEntry>> getTextEntries();
  Stream<List<TextEntry>> watchTextEntries();
  Future<void> insertTextEntry(TextEntry textEntry);
  Future<void> updateTextEntry(TextEntry textEntry);
  Future<void> deleteTextEntry(TextEntry textEntry);
}