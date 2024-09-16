import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:repositories/repositories.dart';

part 'edit_apiary_event.dart';
part 'edit_apiary_state.dart';

class EditApiaryBloc extends Bloc<EditApiaryEvent, EditApiaryState> {
  EditApiaryBloc({required ApiaryRepository apiaryRepository}) 
    : _apiaryRepository = apiaryRepository, super(const EditApiaryState(status: EditApiaryStatus.loading)) {
    on<LoadApiary>(_onLoadApiary);
    on<UpdateApiary>(_onUpdateApiary);
    on<RearangeHives>(_onRearangeHives);
  }

  final ApiaryRepository _apiaryRepository;

  Future<void> _onUpdateApiary(UpdateApiary event, Emitter<EditApiaryState> emit) async {
    await _apiaryRepository.updateApiary(event.apiary);
  }

  

  FutureOr<void> _onRearangeHives(
    RearangeHives event, Emitter<EditApiaryState> emit
    ) async {
    
    //final List<Hive> tmpHives = List<Hive>.from(state.apiary!.hives);
    // final start = event.hive1.order;
    // final end = event.hive2.order;
    // final direction = start < end ? 1 : -1;

    // for (int i = start + direction; i != end + direction; i += direction) {
    //   final apiary = tmpHives[i];
    //   final updatedApiary = apiary.copyWith(order: i - direction);
    //   tmpHives[i - direction] = updatedApiary;
    // }

    // tmpHives[end] = event.hive1.copyWith(order: end);
    // emit(state.copyWith(apiary: state.apiary!.copyWith(hives: tmpHives)));
    // await _apiaryRepository.updateHives(tmpHives);
  
  }

  FutureOr<void> _onLoadApiary(
    LoadApiary event, Emitter<EditApiaryState> emit) async {
    
    emit(state.copyWith(status: EditApiaryStatus.loading));

    // await emit.forEach<Apiary>(
    //   _apiaryRepository.watchApiary(event.apiaryId),
    //   onData: (apiary) => state.copyWith(
    //     apiary: apiary,
    //     status: EditApiaryStatus.success
    //   ),
    //   onError: (_, __) => state.copyWith(
    //     status: EditApiaryStatus.failure
    //   ),
    // );
  }
}
