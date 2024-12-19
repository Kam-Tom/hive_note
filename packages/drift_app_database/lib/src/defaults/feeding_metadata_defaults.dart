import 'package:app_database/app_database.dart';

extension DefaultFeedingMetadata on EntryMetadata {
  static List<EntryMetadata> get feedingDefaults => [
    EntryMetadata(
      id: 'feed_type',
      label: 'feed_type_label',
      hint: 'feed_type_hint',
      valueType: EntryType.text,
      raportType: RaportType.feeding,
      order: 0,
    ),
    EntryMetadata(
      id: 'feed_quantity',
      label: 'feed_quantity_label',
      hint: 'feed_quantity_hint',
      valueType: EntryType.decimal,
      raportType: RaportType.feeding,
      order: 1,
    ),
  ];
}