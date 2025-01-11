import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_note/harves/bloc/models/jar_size.dart';
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
      
      final allEntries = await _entryMetadataRepository.getEntryMetadatas(RaportType.harvest);
      final entries = allEntries.where((e) => e.id == 'honey_type').toList();
      final hints = await _raportRepository.getHints(RaportType.harvest);

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
  FutureOr<void> _onSelectHives(SelectHives event, Emitter<HarvestState> emit) {
    emit(state.copyWith(selectedHives: event.hives));
  }
  Future<void> _onSelectApiaries(SelectApiaries event, Emitter<HarvestState> emit) async {
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
  
  // Format text value by removing parentheses and their contents, and handling case
  String formatTextValue(String text) {
    // Remove parentheses and their contents
    final withoutParentheses = text.replaceAll(RegExp(r'\s*\([^)]*\)'), '');
    // Trim whitespace
    final trimmed = withoutParentheses.trim();
    // Convert to lowercase but preserve L after numbers
    final formatted = trimmed.replaceAllMapped(
      RegExp(r'(\d+(\.\d+)?)\s*L\b', caseSensitive: false),
      (match) => '${match[1]}L'
    ).toLowerCase();
    
    return formatted;
  }

  final selectedHives = state.selectedHives;
  final hivesCount = selectedHives.length;

  // Calculate total values first
  Map<String, dynamic> totalValues = {};
  for (final entry in state.entries) {
    if (entry.valueType == EntryType.number) {
      totalValues[entry.id] = int.parse(event.entries[entry.id] ?? '0');
    } else if (entry.valueType == EntryType.decimal) {
      totalValues[entry.id] = double.parse(event.entries[entry.id] ?? '0');
    }
  }

  int processedHives = 0;
  for (final hive in selectedHives) {
    final raport = Raport(
      raportType: RaportType.harvest,
      createdAt: DateTime.now(),
      hiveId: hive.id, 
      apiaryId: hive.apiaryId,
    );
    final List<Entry> entries = [];

    for (final entry in state.entries) {
      dynamic value;
      
      if (entry.valueType == EntryType.number || entry.valueType == EntryType.decimal) {
        final remainingHives = hivesCount - processedHives;
        final totalValue = totalValues[entry.id];
        
        if (remainingHives == 1) {
          // Last hive gets all remaining value
          value = totalValue;
        } else {
          // Distribute value evenly
          value = totalValue / (hivesCount - processedHives);
          if (entry.valueType == EntryType.number) {
            value = value.round();
          }
        }
        
        // Update remaining total for next iterations
        totalValues[entry.id] = totalValue - value;
      } else {
        // Format text values
        value = formatTextValue(event.entries[entry.id] ?? 'default');
      }

      entries.add(Entry(
        entryMetadataId: entry.id,
        raportId: raport.id,
        value: value.toString(),
      ));
    }

    await _raportRepository.insertRaport(raport, entries);
    processedHives++;
  }
}

}
