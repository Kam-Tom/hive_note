import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_note/shared/bloc/helpers/initial_state.dart';
import 'package:hive_note/shared/bloc/helpers/status.dart';
import 'package:repositories/repositories.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  NoteBloc({
    required EntryMetadataRepository entryMetadataRepository,
    required RaportRepository raportRepository,
}) : 
      _entryMetadataRepository = entryMetadataRepository,
      _raportRepository = raportRepository,
    super(const NoteState()) {
    on<LoadNoteData>(_onLoadNoteData);
    on<CreateNoteEntry>(_onCreateNoteEntry);
  }

  final EntryMetadataRepository _entryMetadataRepository;
  final RaportRepository _raportRepository;

  Future<void> _onLoadNoteData(LoadNoteData event, Emitter<NoteState> emit) async {
    try {
      final entryMetadata = await _entryMetadataRepository.getEntryMetadatas(RaportType.note);
      emit(state.copyWith(
        entry: entryMetadata.first,
        status: Status.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: Status.failure,
        errorMessage: 'Error loading note data',
      ));
    }
  }

  Future<void> _onCreateNoteEntry(CreateNoteEntry event, Emitter<NoteState> emit) async {
    try {
      final raport = Raport(
        raportType: RaportType.note,
        createdAt: DateTime.now(),
      );

      final entry = Entry(
        entryMetadataId: 'other_note',
        raportId: raport.id,
        value: event.entry['other_note'] ?? '',
      );

      await _raportRepository.insertRaport(raport, [entry]);

    } catch (e) {
      emit(state.copyWith(
        status: Status.success,
      ));
    }
  }
}
