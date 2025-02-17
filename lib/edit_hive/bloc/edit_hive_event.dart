part of 'edit_hive_bloc.dart';

sealed class EditHiveEvent extends Equatable {
  const EditHiveEvent();
}

final class LoadHive extends EditHiveEvent {
  const LoadHive({required this.hiveId});
  final String hiveId;

  @override
  List<Object?> get props => [hiveId];
}

final class UpdateHiveQueen extends EditHiveEvent {
  const UpdateHiveQueen({required this.queenId});
  final String? queenId;

  @override
  List<Object?> get props => [queenId];
}

final class CreateNewQueen extends EditHiveEvent {
  const CreateNewQueen();

  @override
  List<Object?> get props => [];
}

final class LoadQueens extends EditHiveEvent {
  const LoadQueens();

  @override
  List<Object?> get props => [];
}

final class SelectApiary extends EditHiveEvent {
  const SelectApiary({required this.apiary});

  final Apiary? apiary;

  @override
  List<Object?> get props => [apiary];
}

class UpdateHiveDetails extends EditHiveEvent {
  const UpdateHiveDetails({
    this.name,
    this.type,
  });

  final String? name;
  final String? type;

  @override
  List<Object?> get props => [name, type];
}

final class ToggleEditing extends EditHiveEvent {
  const ToggleEditing(this.field);

  final String field;

  @override
  List<Object?> get props => [field];
}