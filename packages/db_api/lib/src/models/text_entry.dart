import 'package:db_api/db_api.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

@immutable
class TextEntry extends Equatable {
  final String id;
  final Raport raport;
  final EntryMetadata entryMetadata;
  final String value;

  TextEntry({
    String? id,
    required this.raport,
    required this.entryMetadata,
    required this.value,
  }) : id = id ?? Uuid().v4();

  TextEntry copyWith({
    Raport? raport,
    EntryMetadata? entryMetadata,
    String? value,
    }) {
    return TextEntry(
      id: this.id,
      raport: raport ?? this.raport,
      entryMetadata: entryMetadata ?? this.entryMetadata,
      value: value ?? this.value,
    );
    }

  @override
  List<Object?> get props => [id, raport, entryMetadata, value];
}