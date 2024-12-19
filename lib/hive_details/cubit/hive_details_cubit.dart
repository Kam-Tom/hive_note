import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:repositories/repositories.dart';

part 'hive_details_state.dart';

class HiveDetailsCubit extends Cubit<HiveDetailsState> {
  HiveDetailsCubit({
    required HiveRepository hiveRepository,
    required ApiaryRepository apiaryRepository,
    required QueenRepository queenRepository,
  }) : _hiveRepository = hiveRepository,
       _apiaryRepository = apiaryRepository,
       _queenRepository = queenRepository,
       super(HiveDetailsInitial());

  final HiveRepository _hiveRepository;
  final ApiaryRepository _apiaryRepository;
  final QueenRepository _queenRepository;

  Future<void> loadHiveDetails(String hiveId) async {
    emit(HiveDetailsLoading());
    try {
      final hive = await _hiveRepository.getHive(hiveId);
      final apiary = await _apiaryRepository.getApiaryForHive(hive);
      final queen = await _queenRepository.getQueenForHive(hive);
      
      emit(HiveDetailsSuccess(
        hive: hive,
        apiary: apiary,
        queen: queen,
      ));
    } catch (e) {
      emit(HiveDetailsError(e.toString()));
    }
  }
}
