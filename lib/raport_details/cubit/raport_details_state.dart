part of 'raport_details_cubit.dart';

sealed class RaportDetailsState extends Equatable {
  const RaportDetailsState();

  @override
  List<Object?> get props => [];
}

final class RaportDetailsInitial extends RaportDetailsState {}

final class RaportDetailsLoading extends RaportDetailsState {}

final class RaportDetailsSuccess extends RaportDetailsState {
  final Raport raport;
  final List<Entry> entries;
  final List<EntryMetadata> metadatas;
  final Apiary? apiary;
  final Hive? hive;

  const RaportDetailsSuccess({
    required this.raport,
    required this.entries,
    required this.metadatas,
    this.apiary,
    this.hive,
  });

  @override
  List<Object?> get props => [raport, entries, metadatas, apiary, hive];
}

final class RaportDetailsError extends RaportDetailsState {
  final String message;

  const RaportDetailsError(this.message);

  @override
  List<Object?> get props => [message];
}
