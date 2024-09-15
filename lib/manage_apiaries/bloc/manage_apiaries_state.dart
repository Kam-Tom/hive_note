part of 'manage_apiaries_bloc.dart';

enum ManageApiariesStatus { loading, pending, success, failure }

final class ManageApiariesState extends Equatable {
  const ManageApiariesState({
    this.apiaries = const [],
    this.status = ManageApiariesStatus.loading,
  });

  final List<Apiary> apiaries;
  final ManageApiariesStatus status;

  @override
  List<Object?> get props => [apiaries, status];

  ManageApiariesState copyWith({
    ManageApiariesStatus? status,
    List<Apiary>? apiaries,
    Apiary? lastDeletedApiary,
  }) {
    return ManageApiariesState(
      apiaries: apiaries ?? this.apiaries,
      status: status ?? this.status,
    );
  }
}
