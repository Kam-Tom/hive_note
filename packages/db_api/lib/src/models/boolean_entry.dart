import 'package:db_api/db_api.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

@immutable
class BooleanEntry extends Equatable {
  final String id;
  final String raportId;
  final String entryMetadataId;
  final bool value;

  BooleanEntry({
    String? id,
    required this.raportId,
    required this.entryMetadataId,
    required this.value,
  }) : id = id ?? Uuid().v4();

  BooleanEntry copyWith({
    bool? value,
  }) {
    return BooleanEntry(
      id: this.id,
      raportId: this.raportId,
      entryMetadataId: this.entryMetadataId,
      value: value ?? this.value,
    );
  }

  @override
  List<Object?> get props => [id, raportId, entryMetadataId, value];
}