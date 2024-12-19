import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_note/shared/bloc/helpers/status.dart';
import 'package:repositories/repositories.dart';
import 'package:flutter/material.dart';

part 'edit_apiary_event.dart';
part 'edit_apiary_state.dart';

class EditApiaryBloc extends Bloc<EditApiaryEvent, EditApiaryState> {
  EditApiaryBloc({
    required ApiaryRepository apiaryRepository,
    required HiveRepository hiveRepository,
    required PreferencesRepository preferencesRepository,
  })  : _apiaryRepository = apiaryRepository,
        _hiveRepository = hiveRepository,
        _preferencesRepository = preferencesRepository,
        super(const EditApiaryState()) {
    on<LoadApiary>(_onLoadApiary);
    on<UpdateApiaryName>(_onUpdateApiaryName);
    on<UpdateApiaryColor>(_onUpdateApiaryColor);
    on<UpdateApiaryIsActive>(_onUpdateApiaryIsActive);
    on<AddHive>(_onAddHive);
    on<RearrangeHives>(_onRearrangeHives);
    on<UpdateApiaryCreatedAt>(_onUpdateApiaryCreatedAt);
    on<ToggleEditing>(_onToggleEditing);
  }

  final ApiaryRepository _apiaryRepository;
  final HiveRepository _hiveRepository;
  final PreferencesRepository _preferencesRepository;

  Future<void> _onLoadApiary(LoadApiary event, Emitter<EditApiaryState> emit) async {
    emit(state.copyWith(status: Status.loading));

    await emit.forEach(
      _apiaryRepository.watchApiaryWithHives(event.apiaryId),
      onData: (ApiaryWithHives apiaryWithHives) {
        final apiary = apiaryWithHives.apiary;
        final hives = apiaryWithHives.hives;

        return EditApiaryState(
          apiary: apiary,
          hives: hives,
          status: Status.success,
        );
      },
      onError: (_, __) => state.copyWith(status: Status.failure),
    );

  }

  Future<void> _onUpdateApiaryName(
      UpdateApiaryName event, Emitter<EditApiaryState> emit) async {
    try {
      emit(state.copyWith(apiary: state.apiary!.copyWith(name: event.name)));
      await _apiaryRepository.updateApiary(
        state.apiary!.copyWith(name: event.name),
      );
    } catch (_) {
      emit(state.copyWith(status: Status.failure));
    }
  }

  Future<void> _onUpdateApiaryColor(
      UpdateApiaryColor event, Emitter<EditApiaryState> emit) async {
    try {
      emit(state.copyWith(apiary: state.apiary!.copyWith(color: event.color)));
      await _apiaryRepository.updateApiary(
        state.apiary!.copyWith(color: event.color),
      );
    } catch (_) {
      emit(state.copyWith(status: Status.failure));
    }
  }

  Future<void> _onUpdateApiaryIsActive(
      UpdateApiaryIsActive event, Emitter<EditApiaryState> emit) async {
    try {
      emit(state.copyWith(apiary: state.apiary!.copyWith(isActive: event.isActive)));
      await _apiaryRepository.updateApiary(
        state.apiary!.copyWith(isActive: event.isActive),
      );
    } catch (_) {
      emit(state.copyWith(status: Status.failure));
    }
  }

  Future<void> _onAddHive(AddHive event, Emitter<EditApiaryState> emit) async {
    try {
      final defaultName = await _preferencesRepository.getHiveDefaultName();
      final defaultType = await _preferencesRepository.getHiveDefaultType();
      final newHive = Hive(
        apiaryId: state.apiary!.id,
        name: '$defaultName ${state.hives.length + 1}',
        type: defaultType,
        order: state.hives.length,
        createdAt: DateTime.now(),
      );
      await _hiveRepository.insertHive(newHive);
    } catch (_) {
      emit(state.copyWith(status: Status.failure));
    }
  }

  Future<void> _onRearrangeHives(
      RearrangeHives event, Emitter<EditApiaryState> emit) async {
    try {
      final hives = [...state.hives];
      final item = hives.removeAt(event.oldIndex);
      hives.insert(event.newIndex, item);

      final updatedHives = hives
          .asMap()
          .entries
          .map((e) => e.value.copyWith(order: e.key))
          .toList();

      emit(state.copyWith(hives: updatedHives));
      await _hiveRepository.updateHives(updatedHives);
    } catch (_) {
      emit(state.copyWith(status: Status.failure));
    }
  }

  Future<void> _onUpdateApiaryCreatedAt(
    UpdateApiaryCreatedAt event, 
    Emitter<EditApiaryState> emit,
  ) async {
    try {
      emit(state.copyWith(apiary: state.apiary!.copyWith(createdAt: event.createdAt)));
      await _apiaryRepository.updateApiary(
        state.apiary!.copyWith(createdAt: event.createdAt),
      );
    } catch (_) {
      emit(state.copyWith(status: Status.failure));
    }
  }

  void _onToggleEditing(ToggleEditing event, Emitter<EditApiaryState> emit) {
    final newEditingState = Map<String, bool>.from(state.isEditing);
    newEditingState[event.field] = !(newEditingState[event.field] ?? false);
    emit(state.copyWith(isEditing: newEditingState));
  }

}
