part of 'apiary_dropdown_bloc.dart';

sealed class ApiaryDropdownEvent extends Equatable {
  const ApiaryDropdownEvent();

  @override
  List<Object?> get props => [];
}

final class Subscribe extends ApiaryDropdownEvent {
  const Subscribe();
}

final class SelectApiary extends ApiaryDropdownEvent {
  const SelectApiary({this.apiary});

  final Apiary? apiary;

  @override
  List<Object?> get props => [apiary];
}
