part of 'hive_details_cubit.dart';

sealed class HiveDetailsState extends Equatable {
  const HiveDetailsState();

  @override
  List<Object?> get props => [];
}

final class HiveDetailsInitial extends HiveDetailsState {}

final class HiveDetailsLoading extends HiveDetailsState {}

final class HiveDetailsSuccess extends HiveDetailsState {
  final Hive hive;
  final Apiary? apiary;
  final Queen? queen;

  const HiveDetailsSuccess({
    required this.hive,
    this.apiary,
    this.queen,
  });

  @override
  List<Object?> get props => [hive, apiary, queen];
}

final class HiveDetailsError extends HiveDetailsState {
  final String message;

  const HiveDetailsError(this.message);

  @override
  List<Object?> get props => [message];
}
