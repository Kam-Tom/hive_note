import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_note/shared/bloc/helpers/status.dart';
import 'package:repositories/repositories.dart';

part 'manage_hives_event.dart';
part 'manage_hives_state.dart';

class ManageHivesBloc extends Bloc<ManageHivesEvent, ManageHivesState> {
  ManageHivesBloc({
    required HiveRepository hiveRepository,
    required PreferencesRepository preferencesRepository,
  })  : _hiveRepository = hiveRepository,
        _preferencesRepository = preferencesRepository,
        super(const ManageHivesState()) {
    on<Subscribe>(_onSubscribe, transformer: restartable());
    on<SelectApiary>(_onSelectApiary);
    on<RearrangeHives>(_onRearrangeHives);
    on<DeleteHive>(_onDeleteHive);
    on<InsertHive>(_onInsertHive);
  }

  final HiveRepository _hiveRepository;
  final PreferencesRepository _preferencesRepository;

  Future<void> _onSubscribe(
    Subscribe event,
    Emitter<ManageHivesState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));

    await emit.forEach(
      _hiveRepository.watchHivesWithQueenByApiary(state.selectedApiary),
      onData: (hives) => state.copyWith(
        hives: hives,
        status: Status.success,
      ),
      onError: (e, s) => state.copyWith(status: Status.failure),
    );
  }

  FutureOr<void> _onSelectApiary(
      SelectApiary event, Emitter<ManageHivesState> emit) {
    emit(state.copyWith(selectedApiary: () => event.apiary));

    add(const Subscribe());
  }

  FutureOr<void> _onRearrangeHives(
      RearrangeHives event, Emitter<ManageHivesState> emit) async {
    var tmpHives = List<HiveWithQueen>.from(state.hives);

    tmpHives.removeAt(event.hive1.hive.order);
    tmpHives.insert(event.hive2.hive.order, event.hive1);

    for (int i = 0; i < tmpHives.length; i++) {
      final updatedHive = tmpHives[i].hive.copyWith(order: i);
      tmpHives[i] = tmpHives[i].copyWith(hive: updatedHive);
    }

    emit(state.copyWith(hives: tmpHives, status: Status.updating));

    await _hiveRepository.updateHives(tmpHives.map((h) => h.hive).toList());
  }

  FutureOr<void> _onDeleteHive(
      DeleteHive event, Emitter<ManageHivesState> emit) async {
    var tmpHives = List<HiveWithQueen>.from(state.hives);

    tmpHives.removeWhere((h) => h.hive.id == event.hive.hive.id);
    for (int i = 0; i < tmpHives.length; i++) {
      final updatedHive = tmpHives[i].hive.copyWith(order: i);
      tmpHives[i] = tmpHives[i].copyWith(hive: updatedHive);
    }

    emit(state.copyWith(status: Status.updating, hives: tmpHives));
    await _hiveRepository.deleteHive(event.hive.hive);
    if(tmpHives.isNotEmpty) {
      await _hiveRepository.updateHives(tmpHives.map((h) => h.hive).toList());
    }
  }

  FutureOr<void> _onInsertHive(
      InsertHive event, Emitter<ManageHivesState> emit) async {
    var tmpHives = List<HiveWithQueen>.from(state.hives);
    final defaultName = '${await _preferencesRepository.getHiveDefaultName()} ${tmpHives.length+1}';
    final defaultType = await _preferencesRepository.getHiveDefaultType();
    final newHive = Hive(
      name: defaultName,
      type: defaultType,
      apiaryId: state.selectedApiary?.id,
      order: tmpHives.length,
      createdAt: DateTime.now(),
    );
    tmpHives.add(HiveWithQueen(hive: newHive));
    emit(state.copyWith(status: Status.updating, hives: tmpHives));
    await _hiveRepository.insertHive(newHive);
  }
}
