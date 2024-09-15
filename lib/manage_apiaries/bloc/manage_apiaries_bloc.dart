import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:repositories/repositories.dart';

part 'manage_apiaries_event.dart';
part 'manage_apiaries_state.dart';

class ManageApiariesBloc
    extends Bloc<ManageApiariesEvent, ManageApiariesState> {
  ManageApiariesBloc({required ApiaryRepository apiaryRepository})
      : _apiaryRepository = apiaryRepository,
        super(const ManageApiariesState()) {
    on<ManageApiariesSubscriptionRequest>(_onSubscriptionRequest);
    on<ManageApiariesRetryRequest>(_onRetryRequest);
    on<RearrangeApiaries>(_onRearangeApiaries);
    on<InsertApiary>(_onInsertApiary);
    on<DeleteApiary>(_onDeleteApiary);
  }

  final ApiaryRepository _apiaryRepository;

  Future<void> _onSubscriptionRequest(
    ManageApiariesSubscriptionRequest event,
    Emitter<ManageApiariesState> emit,
  ) async {
    emit(state.copyWith(status: ManageApiariesStatus.loading));

    await emit.forEach<List<Apiary>>(
      _apiaryRepository.watchApiaries(),
      onData: (apiaries) => state.copyWith(
        status: ManageApiariesStatus.success,
        apiaries: apiaries,
      ),
      onError: (_, __) => state.copyWith(
        status: ManageApiariesStatus.failure,
      ),
    );
  }

  Future<void> _onRetryRequest(
      ManageApiariesRetryRequest event, Emitter<ManageApiariesState> emit) {
    throw UnimplementedError();
  }

  Future<void> _onInsertApiary(
      InsertApiary event, Emitter<ManageApiariesState> emit) async {
    await _apiaryRepository.insertApiary(event.apiary);
  }

  Future<void> _onDeleteApiary(
      DeleteApiary event, Emitter<ManageApiariesState> emit) async {
    if (event.apiary.hives.isNotEmpty) {
      emit(state.copyWith(status: ManageApiariesStatus.failure));
      return;
    }
    var tmpApiaries = List<Apiary>.from(state.apiaries);

    tmpApiaries.removeAt(event.apiary.order);
    for (int i = 0; i < tmpApiaries.length; i++) {
      tmpApiaries[i] = tmpApiaries[i].copyWith(order: i);
    }

    emit(state.copyWith(
        apiaries: tmpApiaries, status: ManageApiariesStatus.pending));
    await _apiaryRepository.updateApiaries(tmpApiaries);
    await _apiaryRepository.deleteApiary(event.apiary);
  }

  Future<void> _onRearangeApiaries(
      RearrangeApiaries event, Emitter<ManageApiariesState> emit) async {
    final List<Apiary> tmpApiaries = List<Apiary>.from(state.apiaries);

    tmpApiaries.removeAt(event.apiary1.order);
    tmpApiaries.insert(event.apiary2.order, event.apiary1);

    for (int i = 0; i < tmpApiaries.length; i++) {
      tmpApiaries[i] = tmpApiaries[i].copyWith(order: i);
    }

    emit(state.copyWith(
        apiaries: tmpApiaries, status: ManageApiariesStatus.pending));

    await _apiaryRepository.updateApiaries(tmpApiaries);
  }
}
