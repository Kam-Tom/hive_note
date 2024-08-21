import 'package:db_api/src/interfaces/interfaces.dart';

abstract class DbApi implements
  NumericEntryDbApi, 
  HiveDbApi, 
  RaportDbApi,
  QueenDbApi,
  BooleanEntryDbApi,
  TextEntryDbApi,
  ApiaryDbApi,
  HistoryLogDbApi {

  Future<void> init();
  Future<void> close();
  
}
