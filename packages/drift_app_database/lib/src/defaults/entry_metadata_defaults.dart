import 'package:app_database/app_database.dart';
import 'package:drift_app_database/src/defaults/default_finances_metadata.dart';
import 'package:drift_app_database/src/defaults/default_treatment_metadata.dart';
import 'package:drift_app_database/src/defaults/feeding_metadata_defaults.dart';
import 'package:drift_app_database/src/defaults/other_note_metadata_defaults.dart';
import 'harvest_metadata_defaults.dart';

extension DefaultEntryMetadata on EntryMetadata {
  static List<EntryMetadata> get defaults => [
    EntryMetadata(
      label: 'colony_strength',
      hint: 'colony_strength_hint',
      valueType: EntryType.slider0to5,
      raportType: RaportType.simple,
      order: 0,
    ),
    EntryMetadata(
      label: 'queen_seen',
      hint: 'queen_seen_hint',
      valueType: EntryType.checkbox,
      raportType: RaportType.simple,
      order: 1,
    ),
    EntryMetadata(
      label: 'honey_frames',
      hint: 'honey_frames_hint',
      valueType: EntryType.number,
      raportType: RaportType.simple,
      order: 2,
    ),

  ]
  ..addAll(DefaultHarvestMetadata.harvestDefaults)
  ..addAll(DefaultFeedingMetadata.feedingDefaults)
  ..addAll(DefaultFinancesMetadata.financesDefaults)
  ..addAll(DefaultOtherNoteMetadata.otherNoteDefaults)
  ..addAll(DefaultTreatmentMetadata.treatmentDefaults);
}