import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:repositories/repositories.dart';

part 'dashboard_inspections_event.dart';
part 'dashboard_inspections_state.dart';

class DashboardInspectionsBloc
    extends Bloc<DashboardInspectionsEvent, DashboardInspectionsState> {
  DashboardInspectionsBloc({
    required ApiaryRepository apiaryRepository,
  })  : _apiaryRepository = apiaryRepository,
        super(const DashboardInspectionsState()) {
    on<DashboardApiariesSubscriptionRequest>(_onSubscriptionRequest);
    on<DashboardInspectionsRetryRequest>(_onRetryRequest);
  }

  final ApiaryRepository _apiaryRepository;

  Future<void> _onSubscriptionRequest(
    DashboardApiariesSubscriptionRequest event,
    Emitter<DashboardInspectionsState> emit,
  ) async {
    emit(state.copyWith(status: DashboardInspectionsStatus.loading));

    await emit.forEach<List<ApiaryWithHiveCount>>(
      _apiaryRepository.watchApiariesWithHiveCount(),
      onData: (apiaries) => state.copyWith(
        status: apiaries.isEmpty
            ? DashboardInspectionsStatus.empty
            : DashboardInspectionsStatus.success,
        apiaries: apiaries,
      ),
      onError: (_, __) => state.copyWith(
        status: DashboardInspectionsStatus.failure,
      ),
    );
  }

  FutureOr<void> _onRetryRequest(
    DashboardInspectionsRetryRequest event, 
    Emitter<DashboardInspectionsState> emit) {
      
    throw UnimplementedError();
  }
}
