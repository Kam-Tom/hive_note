part of 'harvest_bloc.dart';

sealed class HarvestEvent extends Equatable {
  const HarvestEvent();

  @override
  List<Object?> get props => [];
}

final class LoadApiaries extends HarvestEvent {
  const LoadApiaries();
}

final class SelectApiaries extends HarvestEvent {
  final List<Apiary> apiaries;
  const SelectApiaries(this.apiaries);
  
  @override
  List<Object?> get props => [apiaries];
}

final class SelectHives extends HarvestEvent {
  final List<Hive> hives;
  const SelectHives(this.hives);
  
  @override
  List<Object?> get props => [hives];
}

final class AddJarEntry extends HarvestEvent {
  final JarSize jarSize;
  const AddJarEntry(this.jarSize);
  
  @override
  List<Object?> get props => [jarSize];
}

final class CreateRaport extends HarvestEvent {
  final Map<String, String?> entries;
  
  const CreateRaport({required this.entries}); 

  @override
  List<Object?> get props => [entries];
}