part of 'dashboard_inspections_bloc.dart';

enum DashboardInspectionsStatus { empty, loading, success, failure }

final class DashboardInspectionsState extends Equatable {
  const DashboardInspectionsState({
    this.apiaries = const [],
    this.status = DashboardInspectionsStatus.empty,
  });

  final List<ApiaryWithHiveCount> apiaries;
  final DashboardInspectionsStatus status;

  @override
  List<Object> get props => [apiaries, status];

  DashboardInspectionsState copyWith({
    DashboardInspectionsStatus? status,
    List<ApiaryWithHiveCount>? apiaries,
  }) {
    return DashboardInspectionsState(
      apiaries: apiaries ?? this.apiaries,
      status: status ?? this.status,
    );
  }
}

