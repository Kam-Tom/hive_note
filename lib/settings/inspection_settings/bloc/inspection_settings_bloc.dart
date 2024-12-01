import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_note/shared/bloc/helpers/initial_state.dart';
import 'package:hive_note/shared/bloc/helpers/status.dart';
import 'package:repositories/repositories.dart';

part 'inspection_settings_event.dart';
part 'inspection_settings_state.dart';

class InspectionSettingsBloc extends Bloc<InspectionSettingsEvent, InspectionSettingsState> {
  final EntryMetadataRepository _entryMetadataRepository;

  InspectionSettingsBloc({required EntryMetadataRepository entryMetadataRepository}) : 
    _entryMetadataRepository = entryMetadataRepository, super(const InspectionSettingsState()) {

    on<LoadEntries>(_onLoadEntries);
    on<CreateEntry>(_onCreateEntry);
    on<DeleteEntry>(_onDeleteEntry);
    on<ReorderEntries>(_onReorderEntries);
  }

  Future<void> _onLoadEntries(LoadEntries event, Emitter<InspectionSettingsState> emit) async {
    emit(state.copyWith(raportType: event.type, status: Status.loading));

    await emit.forEach(
      _entryMetadataRepository.watchEntryMetadatasOfRaportType(event.type),
      onData: (entries) => 
        state.copyWith(entries: entries, status: Status.success),
      onError: (_,__) => 
        state.copyWith(status: Status.failure),
    );

  }    
  Future<void> _onCreateEntry(CreateEntry event, Emitter<InspectionSettingsState> emit) async {
    final newEntries = List<EntryMetadata>.from(state.entries)..add(event.entry);
    emit(state.copyWith(entries: newEntries));

    await _entryMetadataRepository.insertEntryMetadata(event.entry);
  }  
  Future<void> _onDeleteEntry(DeleteEntry event, Emitter<InspectionSettingsState> emit) async {
    final newEntries = List<EntryMetadata>.from(state.entries)..remove(event.entry);
    emit(state.copyWith(entries: newEntries));

    await _entryMetadataRepository.deleteEntryMetadata(event.entry);
  }
  Future<void> _onReorderEntries(ReorderEntries event, Emitter<InspectionSettingsState> emit) async {
    final newEntries = List<EntryMetadata>.from(state.entries);
    final entry = newEntries.removeAt(event.oldIndex);
    newEntries.insert(event.newIndex > event.oldIndex ? event.newIndex - 1 : event.newIndex, entry);
    
    for (int i = 0; i < newEntries.length; i++) {
      newEntries[i] = newEntries[i].copyWith(order: i);
    }
    
    emit(state.copyWith(entries: newEntries));

    await _entryMetadataRepository.updateEntriesMetadata(newEntries);
  }
}