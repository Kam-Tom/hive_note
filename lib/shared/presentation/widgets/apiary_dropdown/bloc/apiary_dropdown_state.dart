part of 'apiary_dropdown_bloc.dart';

final class ApiaryDropdownState extends Equatable {
  const ApiaryDropdownState({
    this.selectedApiary,
    this.apiaries = const [],
    this.status = Status.loading,
    this.defaultApiaryId,
  });

  final Status status;
  final List<Apiary> apiaries;
  final Apiary? selectedApiary;
  final String? defaultApiaryId;

  ApiaryDropdownState copyWith({
    Status? status,
    List<Apiary>? apiaries,
    Apiary? selectedApiary,
    String? Function()? defaultApiaryId,
  }) {
    return ApiaryDropdownState(
      status: status ?? this.status,
      apiaries: apiaries ?? this.apiaries,
      selectedApiary: selectedApiary ?? this.selectedApiary,
      defaultApiaryId: defaultApiaryId != null ? defaultApiaryId() : this.defaultApiaryId,
    );
  }

  @override
  List<Object?> get props => [status, apiaries, selectedApiary];
}
