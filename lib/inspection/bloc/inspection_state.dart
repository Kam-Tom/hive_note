part of 'inspection_bloc.dart';

final class InspectionState extends InitialState {
  final Apiary? apiary;
  final List<HiveInspection> hiveInspections;
  final HiveInspection? selectedHiveInspection;
  final List<EntryMetadata> entryMetadatas;

  const InspectionState({
    this.apiary,
    this.hiveInspections = const [],
    this.selectedHiveInspection,
    this.entryMetadatas = const [],
    super.status,
    super.errorMessage,
  });

  bool get isLastHive => 
    selectedHiveInspection != null ? selectedHiveInspection == hiveInspections.last : false;

  @override
  List<Object?> get props => [
        ...super.props,
        apiary,
        hiveInspections,
        selectedHiveInspection,
        entryMetadatas,
      ];

  @override
  InspectionState copyWith({
    Apiary? apiary,
    List<HiveInspection>? hiveInspections,
    HiveInspection? selectedHiveInspection,
    List<EntryMetadata>? entryMetadatas,
    int? currentHiveIndex,
    Status? status,
    String? errorMessage,
  }) {
    return InspectionState(
      apiary: apiary ?? this.apiary,
      hiveInspections: hiveInspections ?? this.hiveInspections,
      selectedHiveInspection: selectedHiveInspection ?? this.selectedHiveInspection,
      entryMetadatas: entryMetadatas ?? this.entryMetadatas,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class HiveInspection extends Equatable {
  final Hive hive;
  final Queen? queen;
  final bool inspected;
  final Raport? raport;
  final List<Entry> entries;

  const HiveInspection({
    required this.hive,
    this.queen,
    this.raport,
    this.entries = const [],
    required this.inspected,
  });

  HiveInspection copyWith({
    Hive? hive,
    Queen? Function()? queen,
    bool? inspected,
    Raport? raport,
    List<Entry>? entries,
  }) {
    return HiveInspection(
      hive: hive ?? this.hive,
      queen: queen != null ? queen() : this.queen,
      entries: entries ?? this.entries,
      raport: raport ?? this.raport,
      inspected: inspected ?? this.inspected,
    );
  }

  @override
  List<Object?> get props => [hive, queen, inspected, raport, entries];
}
