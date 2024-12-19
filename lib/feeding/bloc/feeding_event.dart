part of 'feeding_bloc.dart';

sealed class FeedingEvent extends Equatable {
  const FeedingEvent();

  @override
  List<Object?> get props => [];
}

final class LoadApiaries extends FeedingEvent {
  const LoadApiaries();
}

final class SelectApiaries extends FeedingEvent {
  final List<Apiary> apiaries;
  const SelectApiaries(this.apiaries);

  @override
  List<Object?> get props => [apiaries];
}

final class SelectHives extends FeedingEvent {
  final List<Hive> hives;
  const SelectHives(this.hives);

  @override
  List<Object?> get props => [hives];
}

final class CreateFeedingRaport extends FeedingEvent {
  final Map<String, String?> entries;
  const CreateFeedingRaport({required this.entries});

  @override
  List<Object?> get props => [entries];
}
