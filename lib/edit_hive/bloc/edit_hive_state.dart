part of 'edit_hive_bloc.dart';

class EditHiveState extends InitialState {
  final Hive? hive;
  final Queen? queen;
  final List<Queen> availableQueens;
  final String? insertedQueenId;
  final Map<String, bool> isEditing;

  const EditHiveState({
    this.hive,
    this.queen,
    this.availableQueens = const [],
    this.insertedQueenId,
    this.isEditing = const {},
    super.status,
    super.errorMessage,
  });

  @override
  EditHiveState copyWith({
    Status? status,
    Hive? hive,
    Queen? queen,
    List<Queen>? availableQueens,
    String? insertedQueenId,
    Map<String, bool>? isEditing,
    String? errorMessage,
  }) {
    return EditHiveState(
      hive: hive ?? this.hive,
      queen: queen ?? this.queen,
      availableQueens: availableQueens ?? this.availableQueens,
      insertedQueenId: insertedQueenId ?? this.insertedQueenId,
      isEditing: isEditing ?? this.isEditing,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [hive, queen, availableQueens, isEditing, ...super.props];
}