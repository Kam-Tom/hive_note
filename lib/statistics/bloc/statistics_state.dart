part of 'statistics_bloc.dart';

class StatisticsState extends Equatable {
  const StatisticsState({
    this.startDate,
    this.endDate,
    this.status = Status.initial,
    this.errorMessage,
    this.apiaries = const [],
    this.hives = const [],
    this.selectedApiaries = const [],
    this.selectedHives = const [],
    this.graphData,
  });

  final List<Apiary> apiaries;
  final List<Hive> hives;
  final List<Apiary> selectedApiaries;
  final List<Hive> selectedHives;
  final DateTime? startDate;
  final DateTime? endDate;
  final Status status;
  final String? errorMessage;
  final Map<String, double>? graphData; // Updated type from Map<String, int>? to Map<String, double>?

  @override
  List<Object?> get props => [startDate, endDate, status, errorMessage, apiaries, hives, selectedApiaries, selectedHives, graphData];

  copyWith({
    DateTime? startDate,
    DateTime? endDate,
    Status? status,
    String? errorMessage,
    List<Apiary>? apiaries,
    List<Hive>? hives,
    List<Apiary>? selectedApiaries,
    List<Hive>? selectedHives,
    Map<String, double>? graphData, // Updated parameter type
  }) =>
      StatisticsState(
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        apiaries: apiaries ?? this.apiaries,
        hives: hives ?? this.hives,
        selectedApiaries: selectedApiaries ?? this.selectedApiaries,
        selectedHives: selectedHives ?? this.selectedHives,
        graphData: graphData ?? this.graphData, // Updated assignment
      );
}

class EmptyStatisticsState extends StatisticsState {
  const EmptyStatisticsState() : super();
}

class FeedingStatisticsState extends StatisticsState {
  const FeedingStatisticsState({
    required this.feedingTypes,
    this.selectedFeedingTypes = const [],
    super.startDate,
    super.endDate,
    super.errorMessage,
    super.status,
    super.apiaries,
    super.hives,
    super.selectedApiaries,
    super.selectedHives,
    super.graphData,
  });


  final List<String> feedingTypes;
  final List<String> selectedFeedingTypes;

  @override
  List<Object?> get props => [
        ...super.props,
        apiaries,
        hives,
        selectedApiaries,
        selectedHives,
        feedingTypes,
        selectedFeedingTypes,
      ];

  @override
  FeedingStatisticsState copyWith({
    List<Apiary>? apiaries,
    List<Hive>? hives,
    List<Apiary>? selectedApiaries,
    List<Hive>? selectedHives,
    List<String>? feedingTypes,
    List<String>? selectedFeedingTypes,
    DateTime? startDate,
    DateTime? endDate,
    String? errorMessage,
    Status? status,
    Map<String, double>? graphData, // Updated parameter type
  }) =>
      FeedingStatisticsState(
        apiaries: apiaries ?? this.apiaries,
        hives: hives ?? this.hives,
        selectedApiaries: selectedApiaries ?? this.selectedApiaries,
        selectedHives: selectedHives ?? this.selectedHives,
        feedingTypes: feedingTypes ?? this.feedingTypes,
        selectedFeedingTypes: selectedFeedingTypes ?? this.selectedFeedingTypes,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        errorMessage: errorMessage ?? this.errorMessage,
        status: status ?? this.status,
        graphData: graphData ?? this.graphData, // Updated assignment
      );
}

// Add similar state classes for other types...
class FinancesStatisticsState extends StatisticsState {
  const FinancesStatisticsState({
    required this.transactionItems,
    this.selectedTransactionItems = const [],
    this.detailedGraphData = const {}, // Add this field
    super.startDate,
    super.endDate,
    super.errorMessage,
    super.status,
    super.apiaries,
    super.hives,
    super.selectedApiaries,
    super.selectedHives,
    super.graphData,
  });

  final List<String> transactionItems;
  final List<String> selectedTransactionItems;
  final Map<String, Map<String, double>> detailedGraphData; // Add this field

  @override
  List<Object?> get props => [
        ...super.props,
        transactionItems,
        selectedTransactionItems,
        detailedGraphData, // Add this field
      ];

  @override
  FinancesStatisticsState copyWith({
    List<Apiary>? apiaries,
    List<Hive>? hives,
    List<Apiary>? selectedApiaries,
    List<Hive>? selectedHives,
    List<String>? transactionItems,
    List<String>? selectedTransactionItems,
    DateTime? startDate,
    DateTime? endDate,
    String? errorMessage,
    Status? status,
    Map<String, double>? graphData,
    Map<String, Map<String, double>>? detailedGraphData, // Add this parameter
  }) =>
      FinancesStatisticsState(
        apiaries: apiaries ?? this.apiaries,
        hives: hives ?? this.hives,
        selectedApiaries: selectedApiaries ?? this.selectedApiaries,
        selectedHives: selectedHives ?? this.selectedHives,
        transactionItems: transactionItems ?? this.transactionItems,
        selectedTransactionItems: selectedTransactionItems ?? this.selectedTransactionItems,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        errorMessage: errorMessage ?? this.errorMessage,
        status: status ?? this.status,
        graphData: graphData ?? this.graphData,
        detailedGraphData: detailedGraphData ?? this.detailedGraphData, // Add this assignment
      );
}


class HarvestStatisticsState extends StatisticsState {
  const HarvestStatisticsState({
    required this.harvestTypes,
    required this.jarTypes,
    this.selectedHarvestTypes = const [],
    this.selectedJarTypes = const [],
    this.detailedGraphData = const {}, // Add this field
    super.startDate,
    super.endDate,
    super.errorMessage,
    super.status,
    super.apiaries,
    super.hives,
    super.selectedApiaries,
    super.selectedHives,
    super.graphData,
  });

  final List<String> harvestTypes;
  final List<String> selectedHarvestTypes;
  final List<String> jarTypes;
  final List<String> selectedJarTypes;
  final Map<String, Map<String, double>> detailedGraphData; // Add this field

  @override
  List<Object?> get props => [
        ...super.props,
        harvestTypes,
        jarTypes,
        selectedJarTypes,
        selectedHarvestTypes,
        detailedGraphData, // Add this field
      ];

  @override
  HarvestStatisticsState copyWith({
    List<Apiary>? apiaries,
    List<Hive>? hives,
    List<Apiary>? selectedApiaries,
    List<Hive>? selectedHives,
    List<String>? harvestTypes,
    List<String>? jarTypes,
    List<String>? selectedHarvestTypes,
    List<String>? selectedJarTypes,
    DateTime? startDate,
    DateTime? endDate,
    String? errorMessage,
    Status? status,
    Map<String, double>? graphData,
    Map<String, Map<String, double>>? detailedGraphData, // Add this parameter
  }) =>
      HarvestStatisticsState(
        apiaries: apiaries ?? this.apiaries,
        hives: hives ?? this.hives,
        selectedApiaries: selectedApiaries ?? this.selectedApiaries,
        selectedHives: selectedHives ?? this.selectedHives,
        harvestTypes: harvestTypes ?? this.harvestTypes,
        selectedHarvestTypes: selectedHarvestTypes ?? this.selectedHarvestTypes,
        selectedJarTypes: selectedJarTypes ?? this.selectedJarTypes,
        jarTypes: jarTypes ?? this.jarTypes,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        errorMessage: errorMessage ?? this.errorMessage,
        status: status ?? this.status,
        graphData: graphData ?? this.graphData,
        detailedGraphData: detailedGraphData ?? this.detailedGraphData, // Add this assignment
      );
}
