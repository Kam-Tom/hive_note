part of 'manage_queens_bloc.dart';

final class ManageQueensState extends Equatable {
  const ManageQueensState({
    this.queens = const [],
    this.status = Status.loading,
    this.selectedApiary,
  });

  final List<QueenWithHive> queens;
  final Status status;
  final Apiary? selectedApiary;
  

  @override
  List<Object?> get props => [queens, selectedApiary, status];

  ManageQueensState copyWith({
  List<QueenWithHive>? queens,
  Status? status,
  Apiary? Function()? selectedApiary, //This is a workaround to allow null values
  }) {
    return ManageQueensState(
      status: status ?? this.status,
      selectedApiary: selectedApiary != null ? selectedApiary() : this.selectedApiary,
      queens: queens ?? this.queens,
    );
  }
}
