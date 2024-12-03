import 'package:app_database/app_database.dart';

extension DefaultHarvestMetadata on EntryMetadata {
  static List<EntryMetadata> get harvestDefaults => [
    EntryMetadata(
      label: 'honey_type',
      hint: 'honey_type_hint',
      valueType: EntryType.text,
      raportType: RaportType.harvest,
      order: 0,
      id: 'honey_type',
    ),
    EntryMetadata(
      label: 'jar_small',
      hint: 'jar_small_hint',
      valueType: EntryType.number,
      raportType: RaportType.harvest,
      order: 1,
      id: 'jar_0.7l',
    ),
    EntryMetadata(
      label: 'jar_standard',
      hint: 'jar_standard_hint',
      valueType: EntryType.number,
      raportType: RaportType.harvest,
      order: 2,
      id: 'jar_1.0l',
    ),
    EntryMetadata(
      label: 'jar_large',
      hint: 'jar_large_hint',
      valueType: EntryType.number,
      raportType: RaportType.harvest,
      order: 3,
      id: 'jar_1.5l',
    ),
    EntryMetadata(
      label: 'jar_xl',
      hint: 'jar_xl_hint',
      valueType: EntryType.number,
      raportType: RaportType.harvest,
      order: 4,
      id: 'jar_2.0l',
    ),
    EntryMetadata(
      label: 'custom_amount',
      hint: 'custom_amount_hint',
      valueType: EntryType.decimal,
      raportType: RaportType.harvest,
      order: 5,
      id: 'custom_liters',
    ),
  ];
}