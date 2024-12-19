part of 'apiary_details_cubit.dart';

abstract class ApiaryDetailsState extends Equatable {
  const ApiaryDetailsState();

  @override
  List<Object?> get props => [];
}

class ApiaryDetailsInitial extends ApiaryDetailsState {}

class ApiaryDetailsLoading extends ApiaryDetailsState {}

class ApiaryDetailsSuccess extends ApiaryDetailsState {
  final Apiary apiary;
  final List<Hive> hives;

  const ApiaryDetailsSuccess({required this.apiary, required this.hives});

  @override
  List<Object?> get props => [apiary, hives];
}

class ApiaryDetailsError extends ApiaryDetailsState {
  final String message;

  const ApiaryDetailsError({required this.message});

  @override
  List<Object?> get props => [message];
}