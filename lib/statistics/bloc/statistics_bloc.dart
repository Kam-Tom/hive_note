import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_note/shared/bloc/helpers/status.dart';
import 'package:repositories/repositories.dart';

part 'statistics_event.dart';
part 'statistics_state.dart';

class StatisticsBloc extends Bloc<StatisticsEvent, StatisticsState> {
  StatisticsBloc({
    required RaportRepository raportRepository,
    required EntryMetadataRepository entryMetadataRepository,
    required ApiaryRepository apiaryRepository,
    required HiveRepository hiveRepository,
    required TodoRepository todoRepository,
  })  : _raportRepository = raportRepository,
        // _entryMetadataRepository = entryMetadataRepository,
        _apiaryRepository = apiaryRepository,
        _hiveRepository = hiveRepository,
        // _todoRepository = todoRepository,
        super(const EmptyStatisticsState()) {
    on<LoadFeedingData>(_onLoadFeedingData);
    on<LoadHarvestData>(_onLoadHarvestData);
    on<LoadFinancesData>(_onLoadFinancesData);
    on<LoadData>(_onLoadData);
    on<SelectApiaries>(_onSelectApiaries);
    on<SelectHives>(_onSelectHives);
    on<SelectFeedingTypes>(_onSelectFeedingTypes);
    on<ShowFeedingGraph>(_onShowFeedingGraph);
    on<SelectJarTypes>(_onSelectJarTypes);
    on<ShowHarvestGraph>(_onShowHarvestGraph);
    on<ShowFinancesGraph>(_onShowFinancesGraph);
    on<ChangeDateRange>(_onChangeDateRange);
    on<SelectTransactionItems>(_onSelectTransactionItems);
    on<SelectHarvestTypes>(_onSelectHarvestTypes);
  }

  final RaportRepository _raportRepository;
  // final EntryMetadataRepository _entryMetadataRepository;
  final ApiaryRepository _apiaryRepository;
  final HiveRepository _hiveRepository;
  // final TodoRepository _todoRepository;

  Future<void> _onLoadFeedingData(
    LoadFeedingData event,
    Emitter<StatisticsState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final hints = await _raportRepository.getHints(RaportType.feeding);
      final feedingTypes = hints['feed_type'] ?? [];

      emit(FeedingStatisticsState(
        apiaries: state.apiaries,
        hives: state.hives,
        startDate: state.startDate,
        endDate: state.endDate,
        selectedApiaries: state.apiaries,
        selectedHives: state.hives,
        feedingTypes: feedingTypes,
        selectedFeedingTypes: feedingTypes,
        status: Status.success,
      ));
    } catch (e) {
      emit(state.copyWith(status: Status.failure));
    }
  }
  Future<void> _onLoadHarvestData(
    LoadHarvestData event,
    Emitter<StatisticsState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final hints = await _raportRepository.getHints(RaportType.harvest);
      final harvestTypes = hints['honey_type'] ?? [];
      final jarTypes = ['jar_0.7l','jar_1.0l','jar_1.5l','jar_2.0l','custom_liters'];

      emit(HarvestStatisticsState(
        apiaries: state.apiaries,
        hives: state.hives,
        selectedApiaries: state.apiaries,
        selectedHives: state.hives,
        harvestTypes: harvestTypes,
        startDate: state.startDate,
        endDate: state.endDate,
        jarTypes: jarTypes,
        selectedHarvestTypes: harvestTypes,
        selectedJarTypes: jarTypes,
        status: Status.success,
      ));
    } catch (e) {
      emit(state.copyWith(status: Status.failure));
    }
  }

  FutureOr<void> _onLoadFinancesData(LoadFinancesData event, Emitter<StatisticsState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final hints = await _raportRepository.getHints(RaportType.finances);
      final transactionItems = hints['transaction_item'] ?? [];

      emit(FinancesStatisticsState(
        apiaries: state.apiaries,
        hives: state.hives,
        selectedApiaries: state.apiaries,
        selectedHives: state.hives,
        startDate: state.startDate,
        endDate: state.endDate,
        transactionItems: transactionItems,
        selectedTransactionItems: transactionItems,
        status: Status.success,
      ));
    } catch (e) {
      emit(state.copyWith(status: Status.failure));
    }
  }
  FutureOr<void> _onSelectApiaries(SelectApiaries event, Emitter<StatisticsState> emit) async {
    emit(state.copyWith(selectedApiaries: event.apiaries));
      List<Hive> allHives = [];
      List<Hive> selectedHives = [];
      if (event.apiaries.isEmpty) {
        // Get hives without apiaries
        allHives = await _hiveRepository.getHivesByApiary(null);
        selectedHives = [];
      } else {
        // Get hives for selected apiaries
        for (var apiary in event.apiaries) {
          final hives = await _hiveRepository.getHivesByApiary(apiary);
          allHives.addAll(hives);
          if(state.selectedApiaries.contains(apiary)) {
            selectedHives.addAll(state.selectedHives.where((hive) => hives.contains(hive)).toList());
          }
          else {
            selectedHives.addAll(hives);
          }
        }
      }
    emit(state.copyWith(selectedApiaries: event.apiaries,hives: allHives, selectedHives: selectedHives));
  }

  FutureOr<void> _onSelectHives(SelectHives event, Emitter<StatisticsState> emit) async {
    emit(state.copyWith(selectedHives: event.hives));
  }

  FutureOr<void> _onLoadData(LoadData event, Emitter<StatisticsState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final apiaries = await _apiaryRepository.getApiaries();
      final List<Hive> allHives = [];
      for(final apiary in apiaries) {
        final hives = await _hiveRepository.getHivesByApiary(apiary);
        allHives.addAll(hives);
      }
      emit(state.copyWith(
        apiaries: apiaries,
        hives: allHives,
        status: Status.success,
      ));
    } catch (e) {
      emit(state.copyWith(status: Status.failure));
    }
  }

  FutureOr<void> _onSelectFeedingTypes(
    SelectFeedingTypes event,
    Emitter<StatisticsState> emit,
  ) {
    if (state is FeedingStatisticsState) {
      final updatedState = (state as FeedingStatisticsState).copyWith(
        selectedFeedingTypes: event.feedingTypes,
      );
      emit(updatedState);
    }
  }

  FutureOr<void> _onShowFeedingGraph(
    ShowFeedingGraph event,
    Emitter<StatisticsState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final data = await _raportRepository.getData(
        RaportType.feeding,
        state.startDate?.subtract(const Duration(days: 1)),
        state.endDate?.add(const Duration(days: 1)),
        event.filters,
        state.selectedHives,
        state.selectedApiaries,
      );
      
      final Map<String, double> preparedGraphData = {};

      for (final raport in data.keys) {
        final entries = data[raport]!;

        String? feedType;
        double? feedQuantity;

        for (final entry in entries) {
          if (entry.entryMetadataId == 'feed_type') {
            feedType = entry.value;
          } else if (entry.entryMetadataId == 'feed_quantity') {
            feedQuantity = double.tryParse(entry.value) ?? 0.0;
          }
        }

        if (feedType != null && feedQuantity != null && feedQuantity > 0 &&
        event.filters['feed_type']!.contains(feedType)) { // Exclude zero values
          preparedGraphData[feedType] = (preparedGraphData[feedType] ?? 0) + feedQuantity;
        }
      }

      emit(state.copyWith(
        graphData: preparedGraphData,
        status: Status.success,
      ));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, errorMessage: e.toString()));
    }
  }

  FutureOr<void> _onSelectJarTypes(
    SelectJarTypes event,
    Emitter<StatisticsState> emit,
  ) {
    if (state is HarvestStatisticsState) {
      final updatedState = (state as HarvestStatisticsState).copyWith(
        selectedJarTypes: event.jarTypes,
      );
      emit(updatedState);
    }
  }

  FutureOr<void> _onShowHarvestGraph(
    ShowHarvestGraph event,
    Emitter<StatisticsState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final data = await _raportRepository.getData(
        RaportType.harvest,
        state.startDate?.subtract(const Duration(days: 1)),
        state.endDate?.add(const Duration(days: 1)),
        event.filters,
        state.selectedHives,
        state.selectedApiaries,
      );
      
      // Structure to hold detailed harvest data per honey type
      final Map<String, Map<String, double>> detailedHarvestData = {};

      for (final raport in data.keys) {
        final entries = data[raport]!;
        String? honeyType;
        Map<String, double> amounts = {};

        // First find honey type
        for (final entry in entries) {
          if (entry.entryMetadataId == 'honey_type') {
            honeyType = entry.value;
            break;
          }
        }

        if (honeyType == null) continue;
        if (!event.filters['honey_type']!.contains(honeyType)) {
          continue;
        }

        // Then process all jar types and custom amounts
        for (final entry in entries) {
          if (entry.entryMetadataId.startsWith('jar_')) {
            // Extract jar volume from the ID (e.g., 'jar_0.7l' -> 0.7)
            final jarVolume = double.tryParse(
              entry.entryMetadataId.substring(4, entry.entryMetadataId.length - 1)
            ) ?? 0.0;
            final jarCount = double.tryParse(entry.value) ?? 0.0;
            amounts[entry.entryMetadataId] = jarCount * jarVolume;
          } else if (entry.entryMetadataId == 'custom_liters') {
            amounts['custom_liters'] = double.tryParse(entry.value) ?? 0.0;
          }
        }

        // Initialize or update the honey type data
        if (!detailedHarvestData.containsKey(honeyType)) {
          detailedHarvestData[honeyType] = {};
        }
        
        // Sum up the amounts for each jar type
        for (var type in amounts.keys) {
          if(!event.filters['jar_type']!.contains(type)) {
            continue;
          }
          detailedHarvestData[honeyType]![type] = 
            (detailedHarvestData[honeyType]![type] ?? 0.0) + amounts[type]!;
        }
      }

      // Convert detailed data to the format needed for the graph
      final Map<String, double> totalsByHoneyType = {};
      final Map<String, Map<String, double>> breakdownByHoneyType = {};

      for (var honeyType in detailedHarvestData.keys) {
        double total = 0.0;
        breakdownByHoneyType[honeyType] = {};
        
        for (var jarType in detailedHarvestData[honeyType]!.keys) {
          final amount = detailedHarvestData[honeyType]![jarType] ?? 0.0;
          total += amount;
          breakdownByHoneyType[honeyType]![jarType] = amount;
        }
        
        totalsByHoneyType[honeyType] = total;
      }

      emit((state as HarvestStatisticsState).copyWith(
        graphData: totalsByHoneyType,
        detailedGraphData: breakdownByHoneyType,
        status: Status.success,
      ));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, errorMessage: e.toString()));
    }
  }

  FutureOr<void> _onShowFinancesGraph(
    ShowFinancesGraph event,
    Emitter<StatisticsState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final data = await _raportRepository.getData(
        RaportType.finances,
        state.startDate?.subtract(const Duration(days: 1)),
        state.endDate?.add(const Duration(days: 1)),
        event.filters,
        null,
        null,
      );

      
      final Map<String, Map<String, double>> detailedData = {};
      final Map<String, double> totalData = {};

      for (final raport in data.keys) {
        final entries = data[raport]!;
        String? transactionItem;
        String? transactionType;
        double? transactionCost;

        for (final entry in entries) {
          switch (entry.entryMetadataId) {
            case 'transaction_item':
              transactionItem = entry.value;
              break;
            case 'transaction_type':
              transactionType = entry.value;
              break;
            case 'transaction_cost':
              transactionCost = double.tryParse(entry.value) ?? 0.0;
              break;
          }
        }

        if (transactionItem != null && transactionType != null && transactionCost != null
        && event.filters['transaction_item']!.contains(transactionItem)) {
          if (transactionCost != 0) { // Only include if cost is not zero
            detailedData[transactionItem] ??= {};
            detailedData[transactionItem]![transactionType] = 
              (detailedData[transactionItem]![transactionType] ?? 0.0) + transactionCost;
            
            totalData[transactionItem] = (totalData[transactionItem] ?? 0.0) + 
              (transactionType == 'Buy' ? transactionCost : -transactionCost);
          }
        }
      }

      // Remove items with no transaction types left
      detailedData.removeWhere((item, typeMap) => typeMap.isEmpty);

      // Remove totalData entries with zero value
      totalData.removeWhere((item, value) => value == 0);

      emit((state as FinancesStatisticsState).copyWith(
        detailedGraphData: detailedData,
        graphData: totalData,
        status: Status.success,
      ));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, errorMessage: e.toString()));
    }
  }

  FutureOr<void> _onChangeDateRange(
    ChangeDateRange event,
    Emitter<StatisticsState> emit,
  ) {
    emit(state.copyWith(
      startDate: event.startDate,
      endDate: event.endDate,
    ));
  }


  FutureOr<void> _onSelectTransactionItems(SelectTransactionItems event, Emitter<StatisticsState> emit) {
    if (state is FinancesStatisticsState) {
      final updatedState = (state as FinancesStatisticsState).copyWith(
        selectedTransactionItems: event.transactionItems,
      );
      emit(updatedState);
    }
  }

  FutureOr<void> _onSelectHarvestTypes(SelectHarvestTypes event, Emitter<StatisticsState> emit) {
    if(state is HarvestStatisticsState) {
      final updatedState = (state as HarvestStatisticsState).copyWith(
        selectedHarvestTypes: event.harvestTypes,
      );
      emit(updatedState);
    }
  }
}
