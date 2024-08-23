import 'package:db_api/db_api.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

@immutable
class NumericEntry extends Equatable {
  final String id;
  final String raportId;
  final String entryMetadataId;
  final double value;

  NumericEntry({
    String? id,
    required this.raportId,
    required this.entryMetadataId,
    required this.value,
  }) : id = id ?? Uuid().v4();

  NumericEntry copyWith({
    double? value,
  }) {
    return NumericEntry(
      id: this.id,
      raportId: this.raportId,
      entryMetadataId: this.entryMetadataId,
      value: value ?? this.value,
    );
  }

  @override
  List<Object?> get props => [id, raportId, entryMetadataId, value];
}