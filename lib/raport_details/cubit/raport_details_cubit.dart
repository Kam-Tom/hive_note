import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:repositories/repositories.dart';

part 'raport_details_state.dart';

class RaportDetailsCubit extends Cubit<RaportDetailsState> {
  RaportDetailsCubit({
    required RaportRepository raportRepository,
    required EntryMetadataRepository metadataRepository,
    required ApiaryRepository apiaryRepository,
    required HiveRepository hiveRepository,
  })  : _raportRepository = raportRepository,
        _metadataRepository = metadataRepository,
        _apiaryRepository = apiaryRepository,
        _hiveRepository = hiveRepository,
        super(RaportDetailsInitial());

  final RaportRepository _raportRepository;
  final EntryMetadataRepository _metadataRepository;
  final ApiaryRepository _apiaryRepository;
  final HiveRepository _hiveRepository;

  Future<void> loadRaportDetails(String raportId) async {
    emit(RaportDetailsLoading());
    try {
      final Raport raport = await _raportRepository.getRaport(raportId);
      final List<Entry> entries = await _raportRepository.getEntries(raport);
      final metadatas = await _metadataRepository.getEntryMetadatas(raport.raportType);
      
      Apiary? apiary;
      Hive? hive;

      if (raport.apiaryId != null) {
        apiary = await _apiaryRepository.getApiary(raport.apiaryId!);
      }
      if (raport.hiveId != null) {
        hive = await _hiveRepository.getHive(raport.hiveId!);
      }
      
      emit(RaportDetailsSuccess(
        raport: raport,
        entries: entries,
        metadatas: metadatas,
        apiary: apiary,
        hive: hive,
      ));
    } catch (e) {
      emit(RaportDetailsError(e.toString()));
    }
  }
}
