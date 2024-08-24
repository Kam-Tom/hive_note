import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

@immutable
class TextEntry extends Equatable {
  final String id;
  final String raportId;
  final String entryMetadataId;
  final String value;

  TextEntry({
    String? id,
    required this.raportId,
    required this.entryMetadataId,
    required this.value,
  }) : id = id ?? Uuid().v4();

  TextEntry copyWith({
    String? value,
    }) {
    return TextEntry(
      id: this.id,
      raportId: this.raportId,
      entryMetadataId: this.entryMetadataId,
      value: value ?? this.value,
    );
    }

  @override
  List<Object?> get props => [id, raportId, entryMetadataId, value];
}