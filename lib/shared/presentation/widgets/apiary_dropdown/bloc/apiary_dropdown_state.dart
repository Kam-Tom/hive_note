part of 'apiary_dropdown_bloc.dart';

final class ApiaryDropdownState extends Equatable {
  const ApiaryDropdownState({
    this.selectedApiary,
    this.apiaries = const [],
    this.status = Status.loading,
  });

  final Status status;
  final List<Apiary> apiaries;
  final Apiary? selectedApiary;

  ApiaryDropdownState copyWith({
    Status? status,
    List<Apiary>? apiaries,
    Apiary? selectedApiary,
  }) {
    return ApiaryDropdownState(
      status: status ?? this.status,
      apiaries: apiaries ?? this.apiaries,
      selectedApiary: selectedApiary ?? this.selectedApiary,
    );
  }

  @override
  List<Object?> get props => [status, apiaries, selectedApiary];
}
