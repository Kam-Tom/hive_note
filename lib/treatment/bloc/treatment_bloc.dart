import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_note/shared/bloc/helpers/initial_state.dart';
import 'package:hive_note/shared/bloc/helpers/status.dart';
import 'package:repositories/repositories.dart';

part 'treatment_event.dart';
part 'treatment_state.dart';

class TreatmentBloc extends Bloc<TreatmentEvent, TreatmentState> {
  final ApiaryRepository _apiaryRepository;
  final HiveRepository _hiveRepository;
  final RaportRepository _raportRepository;
  final EntryMetadataRepository _entryMetadataRepository;

  TreatmentBloc({
    required ApiaryRepository apiaryRepository,
    required HiveRepository hiveRepository,
    required RaportRepository raportRepository,
    required EntryMetadataRepository entryMetadataRepository,
  })  : _apiaryRepository = apiaryRepository,
        _hiveRepository = hiveRepository,
        _raportRepository = raportRepository,
        _entryMetadataRepository = entryMetadataRepository,
        super(const TreatmentState()) {
    on<LoadApiaries>(_onLoadApiaries);
    on<SelectApiaries>(_onSelectApiaries);
    on<SelectHives>(_onSelectHives);
    on<CreateTreatmentRaport>(_onCreateTreatmentRaport);
  }

  Future<void> _onLoadApiaries(LoadApiaries event, Emitter<TreatmentState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final apiaries = await _apiaryRepository.getApiaries();
      final hives = await _hiveRepository.getHivesByApiary(null);
      
      final allEntries = await _entryMetadataRepository.getEntryMetadatas(RaportType.treatment);
      final hints = await _raportRepository.getHints(RaportType.treatment);

      emit(state.copyWith(
        apiaries: apiaries,
        hives: hives,
        entries: allEntries,
        hints: hints,
        status: Status.success,
      ));
    } catch (e) {
      emit(state.copyWith(status: Status.failure));
    }
  }

  FutureOr<void> _onSelectHives(SelectHives event, Emitter<TreatmentState> emit) {
    emit(state.copyWith(selectedHives: event.hives));
  }

  Future<void> _onSelectApiaries(SelectApiaries event, Emitter<TreatmentState> emit) async {
    try {
      List<Hive> allHives = [];
      List<Hive> selectedHives = [];
      if (event.apiaries.isEmpty) {
        allHives = await _hiveRepository.getHivesByApiary(null);
        selectedHives = [];
      } else {
        for (var apiary in event.apiaries) {
          final hives = await _hiveRepository.getHivesByApiary(apiary);
          allHives.addAll(hives);
          if(state.selectedApiaries.contains(apiary)) {
            selectedHives.addAll(state.selectedHives.where((hive) => hives.contains(hive)).toList());
          }
          else {
            selectedHives.addAll(hives);
          }
        }
      }
      
      emit(state.copyWith(
        selectedApiaries: event.apiaries,
        hives: allHives,
        selectedHives: selectedHives,
      ));
    } catch (e) {
      emit(state.copyWith(status: Status.failure));
    }
  }

  Future<void> _onCreateTreatmentRaport(CreateTreatmentRaport event, Emitter<TreatmentState> emit) async {
    if(state.selectedApiaries.isEmpty && state.selectedHives.isEmpty) {
      return;
    }

    final selectedHives = state.selectedHives;

    for (final hive in selectedHives) {
      final raport = Raport(
        raportType: RaportType.treatment,
        createdAt: DateTime.now(),
        hiveId: hive.id,
        apiaryId: hive.apiaryId,
      );
      final List<Entry> entries = [];
      entries.add(Entry(
        entryMetadataId: 'treatment_medicine',
        raportId: raport.id,
        value: event.entries['treatment_medicine'] ?? 'medicine',
      ));
      entries.add(Entry(
        entryMetadataId: 'treatment_dosage',
        raportId: raport.id,
        value: event.entries['treatment_dosage'] ?? '0',
      ));
      entries.add(Entry(
        entryMetadataId: 'treatment_notes',
        raportId: raport.id,
        value: event.entries['treatment_notes'] ?? ' ',
      ));

      await _raportRepository.insertRaport(raport, entries);
    }
  }
}
