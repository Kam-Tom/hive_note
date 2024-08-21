import 'package:db_api/db_api.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

@immutable
class BooleanEntry extends Equatable {
  final String id;
  final Raport raport;
  final EntryMetadata entryMetadata;
  final bool value;

  BooleanEntry({
    String? id,
    required this.raport,
    required this.entryMetadata,
    required this.value,
  }) : id = id ?? Uuid().v4();

  BooleanEntry copyWith({
    Raport? raport,
    EntryMetadata? entryMetadata,
    bool? value,
  }) {
    return BooleanEntry(
      id: this.id,
      raport: raport ?? this.raport,
      entryMetadata: entryMetadata ?? this.entryMetadata,
      value: value ?? this.value,
    );
  }

  @override
  List<Object?> get props => [id, raport, entryMetadata, value];
}