part of 'treatment_bloc.dart';

class TreatmentState extends InitialState {
  final List<Apiary> apiaries;
  final List<Hive> hives;
  final Map<String, List<String>> hints;

  final List<EntryMetadata> entries;
  final List<Apiary> selectedApiaries;
  final List<Hive> selectedHives;

  const TreatmentState({
    this.hints = const {},
    this.apiaries = const [],
    this.hives = const [],
    this.entries = const [],
    this.selectedApiaries = const [],
    this.selectedHives = const [],
    super.status,
    super.errorMessage,
  });

  @override
  TreatmentState copyWith({
    List<Apiary>? apiaries,
    List<Hive>? hives,
    List<EntryMetadata>? entries,
    List<Apiary>? selectedApiaries,
    List<Hive>? selectedHives,
    Map<String, List<String>>? hints,
    Status? status,
    String? errorMessage,
  }) {
    return TreatmentState(
      apiaries: apiaries ?? this.apiaries,
      hives: hives ?? this.hives,
      entries: entries ?? this.entries,
      selectedApiaries: selectedApiaries ?? this.selectedApiaries,
      selectedHives: selectedHives ?? this.selectedHives,
      hints: hints ?? this.hints,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        ...super.props,
        apiaries,
        hives,
        entries,
        selectedApiaries,
        selectedHives,
        hints,
      ];
}
