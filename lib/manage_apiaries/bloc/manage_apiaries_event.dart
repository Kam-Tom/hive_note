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
  const InsertApiary({required this.apiary});

  final Apiary apiary;

  @override
  List<Object> get props => [apiary];
}

final class RearrangeApiaries extends ManageApiariesEvent {
  const RearrangeApiaries({required this.apiary1, required this.apiary2});

  final Apiary apiary1;
  final Apiary apiary2;

  @override
  List<Object> get props => [apiary1, apiary2];
}

final class UpdateApiary extends ManageApiariesEvent {
  const UpdateApiary({required this.apiary});

  final Apiary apiary;

  @override
  List<Object> get props => [apiary];
}

final class DeleteApiary extends ManageApiariesEvent {
  const DeleteApiary({required this.apiary});

  final Apiary apiary;

  @override
  List<Object> get props => [apiary];
}

final class ConfirmDeletion extends ManageApiariesEvent {
  const ConfirmDeletion({required this.apiary});

  final Apiary apiary;

  @override
  List<Object> get props => [apiary];
}
