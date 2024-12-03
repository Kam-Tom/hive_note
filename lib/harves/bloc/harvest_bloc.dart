import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_note/harves/presentation/harvest_view.dart';
import 'package:hive_note/shared/bloc/helpers/initial_state.dart';
import 'package:hive_note/shared/bloc/helpers/status.dart';
import 'package:repositories/repositories.dart';

part 'harvest_event.dart';
part 'harvest_state.dart';

class HarvestBloc extends Bloc<HarvestEvent, HarvestState> {
  final ApiaryRepository _apiaryRepository;
  final HiveRepository _hiveRepository;
  final RaportRepository _raportRepository;
  final EntryMetadataRepository _entryMetadataRepository;

  HarvestBloc({
    required ApiaryRepository apiaryRepository,
    required HiveRepository hiveRepository,
    required RaportRepository raportRepository,
    required EntryMetadataRepository entryMetadataRepository,
  }) : _apiaryRepository = apiaryRepository,
       _hiveRepository = hiveRepository,
        _raportRepository = raportRepository,
        _entryMetadataRepository = entryMetadataRepository,
       super(const HarvestState()) {
    
    on<LoadApiaries>(_onLoadApiaries);
    on<SelectApiaries>(_onSelectApiaries);
    on<SelectHives>(_onSelectHives);
    on<AddJarEntry>(_onAddJarEntry);
    on<CreateRaport>(_onCreateRaport);
  }

  Future<void> _onLoadApiaries(LoadApiaries event, Emitter<HarvestState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final apiaries = await _apiaryRepository.getApiaries();
      final hives = await _hiveRepository.getHivesByApiary(null);
      
      // Add default honey type entry
      final entries = [
        EntryMetadata(
          id: 'honey_type',
          label: 'honey_type',
          hint: 'honey_type_hint',
          valueType: EntryType.text,
          raportType: RaportType.harvest,
          order: 0,
        )
      ];
      
      emit(state.copyWith(
        apiaries: apiaries,
        hives: hives,
        entries: entries,
        status: Status.success,
      ));
    } catch (e) {
      emit(state.copyWith(status: Status.failure));
    }
  }
  FutureOr<void> _onSelectHives(SelectHives event, Emitter<HarvestState> emit) {
    emit(state.copyWith(selectedHives: event.hives));
  }
  Future<void> _onSelectApiaries(SelectApiaries event, Emitter<HarvestState> emit) async {
    try {
      List<Hive> allHives = [];
      
      if (event.apiaries.isEmpty) {
        // Get hives without apiaries
        allHives = await _hiveRepository.getHivesByApiary(null);
      } else {
        // Get hives for selected apiaries
        for (var apiary in event.apiaries) {
          final hives = await _hiveRepository.getHivesByApiary(apiary);
          allHives.addAll(hives);
        }
      }

      final selectedHives = state.selectedHives.where((hive) => allHives.contains(hive)).toList();
      
      emit(state.copyWith(
        selectedApiaries: event.apiaries,
        hives: allHives,
        selectedHives: selectedHives,
      ));
    } catch (e) {
      emit(state.copyWith(status: Status.failure));
    }
  }

  void _onAddJarEntry(AddJarEntry event, Emitter<HarvestState> emit) {
    final jarSize = event.jarSize;
    if (jarSize.size == -1) {
      _addCustomLitersEntry(emit);
    } else {
      _addJarSizeEntry(jarSize, emit);
    }
  }

  void _addCustomLitersEntry(Emitter<HarvestState> emit) {
    final existingEntry = state.entries.any((e) => e.id == 'custom_liters');
    if (!existingEntry) {
      final newEntries = [...state.entries];
      newEntries.add(EntryMetadata(
        order: state.entries.length,
        raportType: RaportType.harvest,
        id: 'custom_liters',
        label: 'Liters',
        hint: 'Amount in liters',
        valueType: EntryType.decimal,
      ));
      emit(state.copyWith(entries: newEntries));
    }
  }

  void _addJarSizeEntry(JarSize jarSize, Emitter<HarvestState> emit) {
    final existingEntry = state.entries.any((e) => e.id == 'jar_${jarSize.size}${jarSize.unit}');
    if (!existingEntry) {
      final newEntries = [...state.entries];
      newEntries.add(EntryMetadata(
        order: state.entries.length,
        raportType: RaportType.harvest,
        id: 'jar_${jarSize.size}${jarSize.unit}',
        label: '${jarSize.size}${jarSize.unit} jars',
        hint: 'Number of ${jarSize.size}${jarSize.unit} jars',
        valueType: EntryType.number,
      ));
      emit(state.copyWith(entries: newEntries));
    }
  }

FutureOr<void> _onCreateRaport(CreateRaport event, Emitter<HarvestState> emit) async {
  if(state.selectedApiaries.isEmpty && state.selectedHives.isEmpty) {
    return;
  }
  await _createRaportForApiaries(event);
  await _createRaportForHives(event);
}

Future<void> _createRaportForApiaries(CreateRaport event) async {
  final apiariesCount = state.selectedApiaries.length;

  for (int i = 0; i < apiariesCount; i++) {
    final apiary = state.selectedApiaries[i];
    final raport = Raport(
      createdAt: DateTime.now(),
      apiaryId: apiary.id,
    );
    final List<Entry> entries = [];

    for (final entry in state.entries) {
      dynamic value;

      if (entry.valueType != EntryType.text) {
        String entryValue = event.entries[entry.id] ?? '';
        int totalValue = int.parse(entryValue.isEmpty ? '0' : entryValue);
        int baseValue = totalValue ~/ apiariesCount;
        int remainder = totalValue % apiariesCount;
        value = baseValue + (i < remainder ? 1 : 0);
      } else {
        value = event.entries[entry.id];
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

Future<void> _createRaportForHives(CreateRaport event) async {

  final selectedHives = state.selectedHives;
  final hivesCount = selectedHives.length;

  for (int i = 0; i < hivesCount; i++) {
    final hive = selectedHives[i];
    final raport = Raport(
      createdAt: DateTime.now(),
      hiveId: hive.id, 
    );
    final List<Entry> entries = [];

    for (final entry in state.entries) {
      dynamic value;

      if (entry.valueType != EntryType.text) {
        int totalValue = int.parse(event.entries[entry.id]!);
        int baseValue = totalValue ~/ hivesCount;
        int remainder = totalValue % hivesCount;
        value = baseValue + (i < remainder ? 1 : 0);
      } else {
        value = event.entries[entry.id];
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
