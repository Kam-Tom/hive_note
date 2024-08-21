import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

@immutable
class EntryMetadata extends Equatable {
  final String id;
  final String label;
  final String hint;
  final EntryType valueType;
  final RaportType raportType;

  EntryMetadata({
    String? id,
    required this.label,
    required this.hint,
    required this.valueType,
    required this.raportType,
  }) : id = id ?? Uuid().v4();

  EntryMetadata copyWith({
    String? label,
    String? hint,
    EntryType? valueType,
    RaportType? raportType,
  }) {
    return EntryMetadata(
      id: this.id,
      label: label ?? this.label,
      hint: hint ?? this.hint,
      valueType: valueType ?? this.valueType,
      raportType: raportType ?? this.raportType,
    );
  }

  @override
  List<Object?> get props => [id, label, hint, valueType, raportType];
}

enum EntryType {
  number,
  text,
  boolean,
}

enum RaportType {
  simple,
  advanced,
  custom,
}
