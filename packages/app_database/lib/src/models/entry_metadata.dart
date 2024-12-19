import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

@immutable
class EntryMetadata extends Equatable {
  final String id;
  final String label;
  final String hint;
  final int order;
  final EntryType valueType;
  final RaportType raportType;

  EntryMetadata({
    String? id,
    required this.label,
    required this.hint,
    required this.order,
    required this.valueType,
    required this.raportType,
  }) : id = id ?? Uuid().v4();

  EntryMetadata copyWith({
    String? label,
    String? hint,
    EntryType? valueType,
    RaportType? raportType,
    int? order = 0,
  }) {
    return EntryMetadata(
      id: this.id,
      label: label ?? this.label,
      hint: hint ?? this.hint,
      valueType: valueType ?? this.valueType,
      raportType: raportType ?? this.raportType,
      order: order ?? this.order,
    );
  }

  @override
  List<Object?> get props => [id, label, hint, valueType, raportType, order];
}

enum EntryType {
  slider0to5,    // Slider with range 0-5
  slider0to3,    // Slider with range 0-3
  slider0to7,    // Slider with range 0-7
  slider0to11,   // Slider with range 0-11
  text,          // General text input
  number,        // Numeric text input (integers only)
  checkbox,      // Boolean input
  decimal,       // Decimal number input (e.g., 3.2, 4.7)
  intNeg,        // Integer input, including negatives (e.g., -5, 3)
  decNeg,        // Decimal input, including negatives (e.g., -3.5)
  toggle,        // On/off toggle switch
}

enum RaportType {
  simple,
  advanced,
  custom,
  harvest,
  finances,
  feeding,
  treatment,
  note,
}
