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

final class UpdateApiary extends EditApiaryEvent {
  const UpdateApiary({required this.apiary});

  final Apiary apiary;

  @override
  List<Object> get props => [apiary];
}

final class RearangeHives extends EditApiaryEvent {
  const RearangeHives({required this.hive1,required this.hive2});

  final Hive hive1;
  final Hive hive2;

  @override
  List<Object> get props => [hive1,hive2];
}