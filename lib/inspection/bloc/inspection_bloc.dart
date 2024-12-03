import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_note/shared/bloc/helpers/initial_state.dart';
import 'package:hive_note/shared/bloc/helpers/status.dart';
import 'package:repositories/repositories.dart';

part 'inspection_event.dart';
part 'inspection_state.dart';

class InspectionBloc extends Bloc<InspectionEvent, InspectionState> {
  final RaportRepository _raportRepository;
  final ApiaryRepository _apiaryRepository;
  final HiveRepository _hiveRepository;
  final EntryMetadataRepository _entryMetadataRepository;

  InspectionBloc({required RaportRepository raportRepository,
  required ApiaryRepository apiaryRepository,
  required HiveRepository hiveRepository,
  required EntryMetadataRepository entryMetadataRepository}) : 
  _hiveRepository = hiveRepository,
  _apiaryRepository = apiaryRepository,
  _raportRepository = raportRepository,
  _entryMetadataRepository = entryMetadataRepository,
  super(const InspectionState())
  {
    on<LoadApiary>(_onLoadApiary);
    on<CreateRaport>(_onCreateRaport);
    on<SelectHive>(_onSelectHive);
  }

  FutureOr<void> _onLoadApiary(LoadApiary event, Emitter<InspectionState> emit) async {
    emit(state.copyWith(status: Status.loading));

    final Apiary apiary = await _apiaryRepository.getApiary(event.apiaryId);
    final List<HiveWithQueen> hives = await _hiveRepository.getHivesWithQueenByApiary(apiary);

    final List<HiveInspection> hiveInspections = hives
        .map((hive) => HiveInspection(
              hive: hive.hive,
              queen: hive.queen,
              inspected: false,
            ))
        .toList();

    HiveInspection? selectedHiveInspection;
    if (hiveInspections.isNotEmpty) {
      selectedHiveInspection = hiveInspections[0];
    }

    final List<EntryMetadata> entryMetadatas = await _entryMetadataRepository.getEntryMetadatas(RaportType.simple);

    emit(state.copyWith(
      apiary: apiary,
      hiveInspections: hiveInspections,
      entryMetadatas: entryMetadatas,
      selectedHiveInspection: selectedHiveInspection,
      status: Status.success,
    ));
  }


  FutureOr<void> _onCreateRaport(CreateRaport event, Emitter<InspectionState> emit) async {
    final currentInspection = state.selectedHiveInspection!;
    final raport = Raport(
      id: currentInspection.raport?.id,
      apiaryId: state.apiary!.id,
      hiveId: currentInspection.hive.id,
      createdAt: DateTime.now(),
    );

    final List<Entry> entries = [];

    for (final entry in event.entries.keys) 
    {
      entries.add(Entry(
        entryMetadataId: entry,
        raportId: raport.id,
        value: event.entries[entry]!,
      ));
    }

    if(currentInspection.inspected)
    {
      await _raportRepository.updateRaport(raport, entries);
    }
    else
    {
      await _raportRepository.insertRaport(raport, entries);
    }

    // Update current hive inspection status
    final updatedHiveInspections = List<HiveInspection>.from(state.hiveInspections);
    final currentIndex = state.hiveInspections.indexOf(currentInspection);
    updatedHiveInspections[currentIndex] = currentInspection.copyWith(
      inspected: true,
      raport: raport,
      entries: entries
    );

    // Move to next hive
    final nextIndex = currentIndex + 1;
    final nextHiveInspection = nextIndex < updatedHiveInspections.length 
        ? updatedHiveInspections[nextIndex] 
        : updatedHiveInspections.last;

    emit(state.copyWith(
      hiveInspections: updatedHiveInspections,
      currentHiveIndex: nextIndex,
      selectedHiveInspection: nextHiveInspection,
    ));
  }

  FutureOr<void> _onSelectHive(SelectHive event, Emitter<InspectionState> emit) {
    emit(state.copyWith(
      selectedHiveInspection: event.hiveInspection,

    ));
  }


}
