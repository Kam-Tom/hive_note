part of 'feeding_bloc.dart';

class FeedingState extends InitialState {
  final List<Apiary> apiaries;
  final List<Hive> hives;
  final List<EntryMetadata> entries;
  final List<Apiary> selectedApiaries;
  final List<Hive> selectedHives;
  final Map<String,List<String>> hints;

  const FeedingState({
    this.apiaries = const [],
    this.hives = const [],
    this.entries = const [],
    this.selectedApiaries = const [],
    this.selectedHives = const [],
    this.hints = const {},
    super.status,
    super.errorMessage,
  });

  @override
  FeedingState copyWith({
    List<Apiary>? apiaries,
    List<Hive>? hives,
    List<EntryMetadata>? entries,
    List<Apiary>? selectedApiaries,
    List<Hive>? selectedHives,
    Map<String,List<String>>? hints,
    Status? status,
    String? errorMessage,
  }) {
    return FeedingState(
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
