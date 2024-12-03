part of 'inspection_bloc.dart';

sealed class InspectionEvent extends Equatable {
  const InspectionEvent();

  @override
  List<Object?> get props => [];
}
final class LoadApiary extends InspectionEvent {
  const LoadApiary({required this.apiaryId});
  final String apiaryId;

  @override
  List<Object?> get props => [apiaryId];
}

final class CreateRaport extends InspectionEvent {
  final Map<String, String?> entries;
  
  const CreateRaport({required this.entries}); 

  @override
  List<Object?> get props => [entries];
}

final class SelectHive extends InspectionEvent {
  const SelectHive({required this.hiveInspection});
  final HiveInspection hiveInspection;

  @override
  List<Object?> get props => [hiveInspection];
}
