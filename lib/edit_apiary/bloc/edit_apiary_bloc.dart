import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_note/shared/bloc/helpers/status.dart';
import 'package:repositories/repositories.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

part 'edit_apiary_event.dart';
part 'edit_apiary_state.dart';

class EditApiaryBloc extends Bloc<EditApiaryEvent, EditApiaryState> {
  EditApiaryBloc({
    required ApiaryRepository apiaryRepository,
    required HiveRepository hiveRepository,
  })  : _apiaryRepository = apiaryRepository,
        _hiveRepository = hiveRepository,
        super(const EditApiaryState()) {
    on<LoadApiary>(_onLoadApiary);
    on<UpdateApiaryName>(
      _onUpdateApiaryName,
      transformer: (events, mapper) => events
          .debounceTime(const Duration(milliseconds: 750))
          .switchMap(mapper),
    );
    on<UpdateApiaryColor>(_onUpdateApiaryColor);
    on<UpdateApiaryIsActive>(_onUpdateApiaryIsActive);
    on<AddHive>(_onAddHive);
    on<RearrangeHives>(_onRearrangeHives);
    on<UpdateApiaryCreatedAt>(_onUpdateApiaryCreatedAt);
  }

  final ApiaryRepository _apiaryRepository;
  final HiveRepository _hiveRepository;

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
      await _apiaryRepository.updateApiary(
        state.apiary!.copyWith(isActive: event.isActive),
      );
    } catch (_) {
      emit(state.copyWith(status: Status.failure));
    }
  }

  Future<void> _onAddHive(AddHive event, Emitter<EditApiaryState> emit) async {
    try {
      final newHive = Hive(
        apiaryId: state.apiary!.id,
        name: '${event.defaultPrefix} ${state.hives.length + 1}',
        type: event.defaultType,
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
      await _apiaryRepository.updateApiary(
        state.apiary!.copyWith(createdAt: event.createdAt),
      );
    } catch (_) {
      emit(state.copyWith(status: Status.failure));
    }
  }

  EventTransformer<E> debounceRestartableTransformer<E>(Duration duration) {
    return (events, mapper) {
      return events
          .debounceTime(duration)
          .switchMap(mapper);
    };
  }
}
