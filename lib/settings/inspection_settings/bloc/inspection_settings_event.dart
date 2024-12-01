part of 'inspection_settings_bloc.dart';

sealed class InspectionSettingsEvent extends Equatable {
  const InspectionSettingsEvent();

  @override
  List<Object?> get props => [];
}

final class LoadEntries extends InspectionSettingsEvent {
  final RaportType type;

  const LoadEntries({required this.type});

  @override
  List<Object?> get props => [type];
}

final class CreateEntry extends InspectionSettingsEvent {
  final EntryMetadata entry;

  const CreateEntry({required this.entry});

  @override
  List<Object?> get props => [entry];
}

final class DeleteEntry extends InspectionSettingsEvent {
  final EntryMetadata entry;

  const DeleteEntry({required this.entry});

  @override
  List<Object?> get props => [entry];
}

final class ReorderEntries extends InspectionSettingsEvent {
  final int oldIndex;
  final int newIndex;

  const ReorderEntries({required this.oldIndex, required this.newIndex});

  @override
  List<Object?> get props => [oldIndex, newIndex];
}
