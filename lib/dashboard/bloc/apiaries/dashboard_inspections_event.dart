part of 'dashboard_inspections_bloc.dart';

sealed class DashboardInspectionsEvent extends Equatable {
  const DashboardInspectionsEvent();

  @override
  List<Object> get props => [];
}

final class DashboardInspectionsRetryRequest extends DashboardInspectionsEvent {
  const DashboardInspectionsRetryRequest();
}

final class DashboardApiariesSubscriptionRequest extends DashboardInspectionsEvent {
  const DashboardApiariesSubscriptionRequest();
}

