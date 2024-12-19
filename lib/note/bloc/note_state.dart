part of 'note_bloc.dart';

final class NoteState extends InitialState {
  final EntryMetadata? entry;

  const NoteState({this.entry, super.status, super.errorMessage});

  @override
  List<Object?> get props => [entry, status, errorMessage];

  @override
  NoteState copyWith({
    EntryMetadata? entry,
    Status? status,
    String? errorMessage,
  }) {
    return NoteState(
      entry: entry ?? this.entry,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
