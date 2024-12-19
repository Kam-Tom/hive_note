import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:repositories/repositories.dart';

part 'queen_details_state.dart';

class QueenDetailsCubit extends Cubit<QueenDetailsState> {
  QueenDetailsCubit({
    required QueenRepository queenRepository,
    required ApiaryRepository apiaryRepository,
    required HiveRepository hiveRepository,
  }) : _queenRepository = queenRepository,
       _apiaryRepository = apiaryRepository,
       _hiveRepository = hiveRepository,
       super(QueenDetailsInitial());

  final QueenRepository _queenRepository;
  final ApiaryRepository _apiaryRepository;
  final HiveRepository _hiveRepository;

  Future<void> loadQueenDetails(String queenId) async {
    emit(QueenDetailsLoading());
    try {
      final queen = await _queenRepository.getQueen(queenId);
      final hive = await _hiveRepository.getHiveForQueen(queen);
      final apiary = hive != null ? await _apiaryRepository.getApiaryForHive(hive) : null;
      
      emit(QueenDetailsSuccess(
        queen: queen,
        hive: hive,
        apiary: apiary,
      ));
    } catch (e) {
      emit(QueenDetailsError(e.toString()));
    }
  }
}
