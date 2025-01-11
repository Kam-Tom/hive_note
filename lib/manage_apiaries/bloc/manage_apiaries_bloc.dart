import 'dart:async';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:repositories/repositories.dart';

part 'manage_apiaries_event.dart';
part 'manage_apiaries_state.dart';

class ManageApiariesBloc
    extends Bloc<ManageApiariesEvent, ManageApiariesState> {
  ManageApiariesBloc({
    required ApiaryRepository apiaryRepository,
    required PreferencesRepository preferenceRepository,
  })  : _apiaryRepository = apiaryRepository,
        _preferenceRepository = preferenceRepository,
        super(const ManageApiariesState()) {
    on<ManageApiariesSubscriptionRequest>(_onSubscriptionRequest);
    on<ManageApiariesRetryRequest>(_onRetryRequest);
    on<RearrangeApiaries>(_onRearangeApiaries);
    on<InsertApiary>(_onInsertApiary);
    on<DeleteApiary>(_onDeleteApiary);
  }

  final ApiaryRepository _apiaryRepository;
  final PreferencesRepository _preferenceRepository;

  Future<void> _onSubscriptionRequest(
    ManageApiariesSubscriptionRequest event,
    Emitter<ManageApiariesState> emit,
  ) async {
    emit(state.copyWith(status: ManageApiariesStatus.loading));

    await emit.forEach<List<ApiaryWithHiveCount>>(
      _apiaryRepository.watchApiariesWithHiveCount(onlyActive: false),
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
      ManageApiariesRetryRequest event, Emitter<ManageApiariesState> emit) async {
    add(const ManageApiariesSubscriptionRequest());
  }

  Future<void> _onInsertApiary(
      InsertApiary event, Emitter<ManageApiariesState> emit) async {
    final defaultName = await _preferenceRepository.getApiaryDefaultName();
    final defaultColorString = await _preferenceRepository.getApiaryDefaultColor();
    
    // Convert hex string to Color
    final defaultColor = Color(int.parse(defaultColorString.replaceAll('#', '0x')));
    
    final newApiary = Apiary(
      name: "$defaultName ${state.apiaries.length + 1}",
      color: defaultColor,
      createdAt: event.createdAt,
      order: state.apiaries.length,
      isActive: event.isActive,
    );
    await _apiaryRepository.insertApiary(newApiary);
  }

  Future<void> _onDeleteApiary(
      DeleteApiary event, Emitter<ManageApiariesState> emit) async {
    if (event.apiary.hiveCount > 0) {
      emit(state.copyWith(status: ManageApiariesStatus.failure));
      return;
    }
    var tmpApiaries = List<ApiaryWithHiveCount>.from(state.apiaries);

    tmpApiaries.removeWhere((a) => a.apiary.id == event.apiary.apiary.id);
    for (int i = 0; i < tmpApiaries.length; i++) {
      final updatedApiary = tmpApiaries[i].apiary.copyWith(order: i);
      tmpApiaries[i] = tmpApiaries[i].copyWith(apiary: updatedApiary);
    }

    emit(state.copyWith(
        apiaries: tmpApiaries, status: ManageApiariesStatus.pending));
    await _apiaryRepository.deleteApiary(event.apiary.apiary);
    await _apiaryRepository
        .updateApiaries(tmpApiaries.map((a) => a.apiary).toList());
  }

  Future<void> _onRearangeApiaries(
      RearrangeApiaries event, Emitter<ManageApiariesState> emit) async {
    final tmpApiaries = List<ApiaryWithHiveCount>.from(state.apiaries);

    tmpApiaries.removeAt(event.apiary1.apiary.order);
    tmpApiaries.insert(event.apiary2.apiary.order, event.apiary1);

    for (int i = 0; i < tmpApiaries.length; i++) {
      final updateApiary = tmpApiaries[i].apiary.copyWith(order: i);
      tmpApiaries[i] = tmpApiaries[i].copyWith(apiary: updateApiary);
    }

    emit(state.copyWith(
        apiaries: tmpApiaries, status: ManageApiariesStatus.pending));

    await _apiaryRepository
        .updateApiaries(tmpApiaries.map((e) => e.apiary).toList());
  }
}
