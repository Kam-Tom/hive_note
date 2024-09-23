part of 'manage_hives_bloc.dart';

final class ManageHivesState extends Equatable {
  const ManageHivesState({
    this.hives = const [],
    this.status = Status.loading,
    this.selectedApiary,
  });

  final List<HiveWithQueen> hives;
  final Status status;
  final Apiary? selectedApiary;
  

  @override
  List<Object?> get props => [hives, selectedApiary, status];

  ManageHivesState copyWith({
  List<HiveWithQueen>? hives,
  Status? status,
  Apiary? selectedApiary,
  }) {
    return ManageHivesState(
      status: status ?? this.status,
      selectedApiary: selectedApiary ?? this.selectedApiary,
      hives: hives ?? this.hives,
    );
  }
}
