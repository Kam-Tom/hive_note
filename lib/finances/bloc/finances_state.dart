part of 'finances_bloc.dart';

class FinancesState extends InitialState {
  final List<EntryMetadata> entries;
  final String transactionType;
  final double amount;
  final double cost;
  final bool isPerUnit;
  final Map<String, List<String>> hints;

  const FinancesState({
    this.entries = const [],
    this.transactionType = 'Buy',
    this.amount = 0,
    this.cost = 0,
    this.isPerUnit = false,
    this.hints = const {},
    super.status,
    super.errorMessage,
  });

  @override
  FinancesState copyWith({
    List<EntryMetadata>? entries,
    String? transactionType,
    double? amount,
    double? cost,
    bool? isPerUnit,
    Map<String, List<String>>? hints,
    Status? status,
    String? errorMessage,
  }) {
    return FinancesState(
      entries: entries ?? this.entries,
      transactionType: transactionType ?? this.transactionType,
      amount: amount ?? this.amount,
      cost: cost ?? this.cost,
      hints: hints ?? this.hints,
      isPerUnit: isPerUnit ?? this.isPerUnit,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [...super.props, entries, transactionType, hints, amount, cost, isPerUnit];
}
