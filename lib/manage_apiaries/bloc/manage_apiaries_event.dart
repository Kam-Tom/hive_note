part of 'manage_apiaries_bloc.dart';

sealed class ManageApiariesEvent extends Equatable {
  const ManageApiariesEvent();

  @override
  List<Object> get props => [];
}

final class ManageApiariesRetryRequest extends ManageApiariesEvent {
  const ManageApiariesRetryRequest();
}

final class ManageApiariesSubscriptionRequest extends ManageApiariesEvent {
  const ManageApiariesSubscriptionRequest();
}

final class InsertApiary extends ManageApiariesEvent {
  const InsertApiary({required this.createdAt, required this.color, required this.name, required this.isActive});

  final DateTime createdAt;
  final Color color;
  final String name;
  final bool isActive;

  @override
  List<Object> get props => [name, color, createdAt, isActive];
}

final class RearrangeApiaries extends ManageApiariesEvent {
  const RearrangeApiaries({required this.apiary1, required this.apiary2});

  final ApiaryWithHiveCount apiary1;
  final ApiaryWithHiveCount apiary2;

  @override
  List<Object> get props => [apiary1, apiary2];
}

final class DeleteApiary extends ManageApiariesEvent {
  const DeleteApiary({required this.apiary});

  final ApiaryWithHiveCount apiary;

  @override
  List<Object> get props => [apiary];
}
