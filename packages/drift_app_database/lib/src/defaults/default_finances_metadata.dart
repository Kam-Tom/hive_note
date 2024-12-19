import 'package:app_database/app_database.dart';

extension DefaultFinancesMetadata on EntryMetadata {
  static List<EntryMetadata> get financesDefaults => [
    EntryMetadata(
      label: 'transaction_type',
      hint: 'transaction_type_hint',
      valueType: EntryType.text,
      raportType: RaportType.finances,
      order: 0,
      id: 'transaction_type',
    ),
    EntryMetadata(
      label: 'transaction_amount',
      hint: 'transaction_amount_hint',
      valueType: EntryType.number,
      raportType: RaportType.finances,
      order: 1,
      id: 'transaction_amount',
    ),
    EntryMetadata(
      label: 'transaction_cost',
      hint: 'transaction_cost_hint',
      valueType: EntryType.number,
      raportType: RaportType.finances,
      order: 2,
      id: 'transaction_cost',
    ),
    EntryMetadata(
      label: 'transaction_item',
      hint: 'transaction_item_hint',
      valueType: EntryType.text,
      raportType: RaportType.finances,
      order: 3,
      id: 'transaction_item',
    ),
    EntryMetadata(
      label: 'transaction_note',
      hint: 'transaction_note_hint',
      valueType: EntryType.text,
      raportType: RaportType.finances,
      order: 4,
      id: 'transaction_note',
    ),
  ];
}