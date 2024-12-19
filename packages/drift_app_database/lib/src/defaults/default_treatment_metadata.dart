import 'package:app_database/app_database.dart';

extension DefaultTreatmentMetadata on EntryMetadata {
  static List<EntryMetadata> get treatmentDefaults => [
    EntryMetadata(
      label: 'treatment_medicine',
      hint: 'treatment_medicine_hint',
      valueType: EntryType.text,
      raportType: RaportType.treatment,
      order: 0,
      id: 'treatment_medicine',
    ),
    EntryMetadata(
      label: 'treatment_dosage',
      hint: 'treatment_dosage_hint',
      valueType: EntryType.decimal,
      raportType: RaportType.treatment,
      order: 1,
      id: 'treatment_dosage',
    ),
    EntryMetadata(
      label: 'treatment_notes',
      hint: 'treatment_notes_hint',
      valueType: EntryType.text,
      raportType: RaportType.treatment,
      order: 2,
      id: 'treatment_notes',
    ),
  ];
}
