part of 'manage_hives_bloc.dart';

sealed class ManageHivesEvent extends Equatable {
  const ManageHivesEvent();

  @override
  List<Object?> get props => [];
}

final class Subscribe extends ManageHivesEvent {
  const Subscribe();
}

final class SelectApiary extends ManageHivesEvent {
  const SelectApiary({required this.apiary});

  final Apiary? apiary;

  @override
  List<Object?> get props => [apiary];
}

final class RearrangeHives extends ManageHivesEvent {
  const RearrangeHives({required this.hive1, required this.hive2});

  final HiveWithQueen hive1;
  final HiveWithQueen hive2;

  @override
  List<Object> get props => [hive1, hive2];
}

final class DeleteHive extends ManageHivesEvent {
  const DeleteHive({required this.hive});

  final HiveWithQueen hive;

  @override
  List<Object> get props => [hive];
}

final class InsertHive extends ManageHivesEvent {
  const InsertHive({required this.hive});

  final Hive hive;

  @override
  List<Object> get props => [hive];
}