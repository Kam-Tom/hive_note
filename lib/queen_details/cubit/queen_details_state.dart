part of 'queen_details_cubit.dart';

sealed class QueenDetailsState extends Equatable {
  const QueenDetailsState();

  @override
  List<Object?> get props => [];
}

final class QueenDetailsInitial extends QueenDetailsState {}

final class QueenDetailsLoading extends QueenDetailsState {}

final class QueenDetailsSuccess extends QueenDetailsState {
  final Queen queen;
  final Apiary? apiary;
  final Hive? hive;

  const QueenDetailsSuccess({
    required this.queen,
    this.apiary,
    this.hive,
  });

  @override
  List<Object?> get props => [queen, apiary, hive];
}

final class QueenDetailsError extends QueenDetailsState {
  final String message;

  const QueenDetailsError(this.message);

  @override
  List<Object?> get props => [message];
}
