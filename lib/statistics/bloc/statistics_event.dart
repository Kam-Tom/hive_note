part of 'statistics_bloc.dart';

sealed class StatisticsEvent extends Equatable {
  const StatisticsEvent();

  @override
  List<Object?> get props => [];
}

final class LoadFeedingData extends StatisticsEvent {
  const LoadFeedingData();
}
final class LoadHarvestData extends StatisticsEvent {
  const LoadHarvestData();
}
final class LoadFinancesData extends StatisticsEvent {
  const LoadFinancesData();
}
final class LoadData extends StatisticsEvent {
  const LoadData();
}

final class SelectApiaries extends StatisticsEvent {
  final List<Apiary> apiaries;
  const SelectApiaries({required this.apiaries});

  @override
  List<Object?> get props => [apiaries];
}

final class SelectHives extends StatisticsEvent {
  final List<Hive> hives;
  const SelectHives({required this.hives});

  @override
  List<Object?> get props => [hives];
}

final class SelectFeedingTypes extends StatisticsEvent {
  final List<String> feedingTypes;
  const SelectFeedingTypes({required this.feedingTypes});

  @override
  List<Object?> get props => [feedingTypes];
}

final class ShowFeedingGraph extends StatisticsEvent {
  const ShowFeedingGraph({
    required this.filters,
  });

  final Map<String, List<String>> filters;
  @override
  List<Object?> get props => [filters];
}

final class SelectHarvestTypes extends StatisticsEvent {
  final List<String> harvestTypes;
  const SelectHarvestTypes({required this.harvestTypes});

  @override
  List<Object?> get props => [harvestTypes];
}

final class SelectJarTypes extends StatisticsEvent {
  final List<String> jarTypes;
  const SelectJarTypes({required this.jarTypes});

  @override
  List<Object?> get props => [jarTypes];
}

final class ShowHarvestGraph extends StatisticsEvent {
  final Map<String, List<String>> filters;
  final List<String> jarTypes;
  const ShowHarvestGraph({
    required this.filters, required this.jarTypes,
  });

  @override
  List<Object?> get props => [filters];
}

final class SelectTransactionItems extends StatisticsEvent {
  final List<String> transactionItems;
  const SelectTransactionItems({required this.transactionItems});

  @override
  List<Object?> get props => [transactionItems];
}

final class ShowFinancesGraph extends StatisticsEvent {
  final Map<String, List<String>> filters;
  const ShowFinancesGraph({
    required this.filters,
  });

  @override
  List<Object?> get props => [filters];
}

final class ChangeDateRange extends StatisticsEvent {
  final DateTime startDate;
  final DateTime endDate;
  
  const ChangeDateRange({
    required this.startDate,
    required this.endDate,
  });

  @override
  List<Object?> get props => [startDate, endDate];
}

