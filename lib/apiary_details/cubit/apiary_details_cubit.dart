import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:repositories/repositories.dart';

part 'apiary_details_state.dart';

class ApiaryDetailsCubit extends Cubit<ApiaryDetailsState> {
  ApiaryDetailsCubit({required ApiaryRepository apiaryRepository,
  required HiveRepository hiveRepository}) :
  _apiaryRepository = apiaryRepository,
  _hiveRepository = hiveRepository, super(ApiaryDetailsInitial());

  final ApiaryRepository _apiaryRepository;
  final HiveRepository _hiveRepository;

  Future<void> loadApiaryDetails(String apiaryId) async {
    emit(ApiaryDetailsLoading());
    try {
      final apiary = await _apiaryRepository.getApiary(apiaryId);
      final hives = await _hiveRepository.getHivesByApiary(apiary);
      emit(ApiaryDetailsSuccess(apiary: apiary, hives: hives));
    } catch (e) {
      emit(ApiaryDetailsError(message: e.toString()));
    }
  }
}
