part of 'note_bloc.dart';

sealed class NoteEvent extends Equatable {
  const NoteEvent();

  @override
  List<Object> get props => [];
}

final class LoadNoteData extends NoteEvent {
  const LoadNoteData();
}

final class CreateNoteEntry extends NoteEvent {
  final Map<String, String?> entry;
  const CreateNoteEntry({required this.entry});
  
  @override
  List<Object> get props => [entry];
}
