import 'package:app_database/app_database.dart';
import 'harvest_metadata_defaults.dart';

extension DefaultEntryMetadata on EntryMetadata {
  static List<EntryMetadata> get defaults => [
    EntryMetadata(
      label: 'Colony Strength',
      hint: 'Rate from 0-5',
      valueType: EntryType.slider0to5,
      raportType: RaportType.simple,
      order: 0,
    ),
    EntryMetadata(
      label: 'Queen Seen',
      hint: 'Was queen spotted?',
      valueType: EntryType.checkbox,
      raportType: RaportType.simple,
      order: 1,
    ),
    EntryMetadata(
      label: 'Honey Frames',
      hint: 'Number of frames',
      valueType: EntryType.number,
      raportType: RaportType.simple,
      order: 2,
    ),
    // Add more default entries as needed
  ]..addAll(DefaultHarvestMetadata.harvestDefaults);
}