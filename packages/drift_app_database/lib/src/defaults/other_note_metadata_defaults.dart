import 'package:app_database/app_database.dart';

extension DefaultOtherNoteMetadata on EntryMetadata {
  static List<EntryMetadata> get otherNoteDefaults => [
    EntryMetadata(
      label: 'other_note',
      hint: 'other_note_hint',
      valueType: EntryType.text,
      raportType: RaportType.note,
      order: 0,
      id: 'other_note',
    ),
  ];
}