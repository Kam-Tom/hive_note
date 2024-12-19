part of 'treatment_bloc.dart';

sealed class TreatmentEvent extends Equatable {
  const TreatmentEvent();

  @override
  List<Object?> get props => [];
}

final class LoadApiaries extends TreatmentEvent {
  const LoadApiaries();
}

final class SelectApiaries extends TreatmentEvent {
  final List<Apiary> apiaries;
  const SelectApiaries(this.apiaries);

  @override
  List<Object?> get props => [apiaries];
}

final class SelectHives extends TreatmentEvent {
  final List<Hive> hives;
  const SelectHives(this.hives);

  @override
  List<Object?> get props => [hives];
}

final class CreateTreatmentRaport extends TreatmentEvent {
  final Map<String, String?> entries;
  const CreateTreatmentRaport({required this.entries});

  @override
  List<Object?> get props => [entries];
}
