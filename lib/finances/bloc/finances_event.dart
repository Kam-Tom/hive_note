part of 'finances_bloc.dart';

sealed class FinancesEvent extends Equatable {
  const FinancesEvent();

  @override
  List<Object?> get props => [];
}

final class LoadData extends FinancesEvent {
  const LoadData();
}

final class SelectTransactionType extends FinancesEvent {
  final String transactionType;
  const SelectTransactionType(this.transactionType);
  
  @override
  List<Object?> get props => [transactionType];
}

final class UpdateAmount extends FinancesEvent {
  final double amount;
  const UpdateAmount(this.amount);
  
  @override
  List<Object?> get props => [amount];
}

final class UpdateCost extends FinancesEvent {
  final double cost;
  const UpdateCost(this.cost);
  
  @override
  List<Object?> get props => [cost];
}

final class CreateTransaction extends FinancesEvent {
  final Map<String, String?> entries;
  const CreateTransaction({required this.entries});
  
  @override
  List<Object?> get props => [entries];
}

final class ToggleCostType extends FinancesEvent {
  const ToggleCostType();
}
