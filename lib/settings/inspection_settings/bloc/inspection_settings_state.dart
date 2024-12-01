part of 'inspection_settings_bloc.dart';

class InspectionSettingsState extends InitialState {
  final RaportType raportType;
  final List<EntryMetadata> entries;

  const InspectionSettingsState({
    this.raportType = RaportType.simple,
    this.entries = const [],
    super.status,
    super.errorMessage,
  });

  @override
  InspectionSettingsState copyWith({
    RaportType? raportType,
    List<EntryMetadata>? entries,
    Status? status,
    String? errorMessage,
  }) {
    return InspectionSettingsState(
      raportType: raportType ?? this.raportType,
      entries: entries ?? this.entries,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [raportType, entries, ...super.props];
}