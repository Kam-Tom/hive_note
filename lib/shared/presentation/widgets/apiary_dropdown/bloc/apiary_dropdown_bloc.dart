import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_note/shared/bloc/helpers/status.dart';
import 'package:repositories/repositories.dart';

part 'apiary_dropdown_event.dart';
part 'apiary_dropdown_state.dart';

class ApiaryDropdownBloc extends Bloc<ApiaryDropdownEvent, ApiaryDropdownState> {
  ApiaryDropdownBloc({required this.apiaryRepository, this.defaultApiaryId})
      : super(const ApiaryDropdownState()) {
    on<Subscribe>(_onSubscribe);
    on<SelectApiary>(_onSelectApiary);
  }

  final String? defaultApiaryId;
  final ApiaryRepository apiaryRepository;

  FutureOr<void> _onSubscribe(
      Subscribe event, Emitter<ApiaryDropdownState> emit) async {
    emit(state.copyWith(status: Status.loading));

    await emit.forEach<List<Apiary>>(apiaryRepository.watchApiaries(),
        onData: (apiaries) {
          if(state.selectedApiary == null && defaultApiaryId != null) {
            return state.copyWith(
              status: Status.success,
              apiaries: apiaries,
              selectedApiary: apiaries.firstWhere((element) => element.id == defaultApiaryId),
            );
          }
          return state.copyWith(
              status: Status.success,
              apiaries: apiaries,
              selectedApiary: state.selectedApiary,
            );
        },
        onError: (_, __) => state.copyWith(status: Status.failure));
  }

  FutureOr<void> _onSelectApiary(
      SelectApiary event, Emitter<ApiaryDropdownState> emit) {
    emit(state.copyWith(selectedApiary: event.apiary));
  }  
  
}
