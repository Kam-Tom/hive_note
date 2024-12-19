import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_note/shared/bloc/helpers/initial_state.dart';
import 'package:hive_note/shared/bloc/helpers/status.dart';
import 'package:repositories/repositories.dart';

part 'feeding_event.dart';
part 'feeding_state.dart';

class FeedingBloc extends Bloc<FeedingEvent, FeedingState> {
  final ApiaryRepository _apiaryRepository;
  final HiveRepository _hiveRepository;
  final RaportRepository _raportRepository;
  final EntryMetadataRepository _entryMetadataRepository;

  FeedingBloc({
    required ApiaryRepository apiaryRepository,
    required HiveRepository hiveRepository,
    required RaportRepository raportRepository,
    required EntryMetadataRepository entryMetadataRepository,
  })  : _apiaryRepository = apiaryRepository,
        _hiveRepository = hiveRepository,
        _raportRepository = raportRepository,
        _entryMetadataRepository = entryMetadataRepository,
        super(const FeedingState()) {
    on<LoadApiaries>(_onLoadApiaries);
    on<SelectApiaries>(_onSelectApiaries);
    on<SelectHives>(_onSelectHives);
    on<CreateFeedingRaport>(_onCreateFeedingRaport);
  }

  Future<void> _onLoadApiaries(
      LoadApiaries event, Emitter<FeedingState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final apiaries = await _apiaryRepository.getApiaries();
      final hives = await _hiveRepository.getHivesByApiary(null);

      // Load feeding entries from the repository
      final entries = await _entryMetadataRepository.getEntryMetadatas(RaportType.feeding);
      final hints = await _raportRepository.getHints(RaportType.feeding);
      emit(state.copyWith(
        apiaries: apiaries,
        hives: hives,
        entries: entries,
        hints: hints,
        status: Status.success,
      ));
    } catch (e) {
      emit(state.copyWith(status: Status.failure));
    }
  }

  Future<void> _onSelectApiaries(
      SelectApiaries event, Emitter<FeedingState> emit) async {
    try {
      List<Hive> allHives = [];
      List<Hive> selectedHives = [];
      if (event.apiaries.isEmpty) {
        // Get hives without apiaries
        allHives = await _hiveRepository.getHivesByApiary(null);
        selectedHives = [];
      } else {
        // Get hives for selected apiaries
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

  void _onSelectHives(SelectHives event, Emitter<FeedingState> emit) {
    emit(state.copyWith(selectedHives: event.hives));
  }

  Future<void> _onCreateFeedingRaport(
      CreateFeedingRaport event, Emitter<FeedingState> emit) async {
    if (state.selectedApiaries.isEmpty && state.selectedHives.isEmpty) {
      return;
    }

  final selectedHives = state.selectedHives;
    final hivesCount = selectedHives.length;

    for (int i = 0; i < hivesCount; i++) {
      final hive = selectedHives[i];
      final raport = Raport(
        raportType: RaportType.feeding,
        createdAt: DateTime.now(),
        hiveId: hive.id,
        apiaryId: hive.apiaryId,
      );
      final List<Entry> entries = [];

      for (final entry in state.entries) {
        dynamic value;

        if (entry.valueType != EntryType.text) {
          double totalValue = double.parse(event.entries[entry.id] ?? '0');
          double valPerHive = totalValue / hivesCount;
          value = valPerHive;
        } else {
          value = event.entries[entry.id] ?? 'default';
        }

        entries.add(Entry(
          entryMetadataId: entry.id,
          raportId: raport.id,
          value: value.toString(),
        ));
      }

      await _raportRepository.insertRaport(raport, entries);
    }
  }



}
