part of 'edit_apiary_bloc.dart';

sealed class EditApiaryEvent extends Equatable {
  const EditApiaryEvent();

  @override
  List<Object> get props => [];
}

final class LoadApiary extends EditApiaryEvent {
  const LoadApiary({required this.apiaryId});
  final String apiaryId;

  @override
  List<Object> get props => [apiaryId];
}

final class UpdateApiaryName extends EditApiaryEvent {
  const UpdateApiaryName({
    required this.name,
  });

  final String name;

  @override
  List<Object> get props => [name];
}

final class AddHive extends EditApiaryEvent {
  const AddHive({required this.defaultType, required this.defaultPrefix});
  final String defaultType;
  final String defaultPrefix;

  @override
  List<Object> get props => [defaultType];
}

final class RearrangeHives extends EditApiaryEvent {
  const RearrangeHives({
    required this.oldIndex,
    required this.newIndex,
  });

  final int oldIndex;
  final int newIndex;

  @override
  List<Object> get props => [oldIndex, newIndex];
}

final class UpdateApiaryColor extends EditApiaryEvent {
  const UpdateApiaryColor({required this.color});
  final Color color;

  @override
  List<Object> get props => [color];
}

final class UpdateApiaryIsActive extends EditApiaryEvent {
  const UpdateApiaryIsActive({required this.isActive});
  final bool isActive;

  @override
  List<Object> get props => [isActive];
}

final class UpdateApiaryCreatedAt extends EditApiaryEvent {
  const UpdateApiaryCreatedAt({required this.createdAt});
  final DateTime createdAt;

  @override
  List<Object> get props => [createdAt];
}