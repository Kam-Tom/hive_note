part of 'edit_queen_bloc.dart';

class EditQueenState extends InitialState {
  final Queen? queen;
  final Map<String, bool> isEditing;

  const EditQueenState({
    this.queen,
    this.isEditing = const {},
    super.status,
    super.errorMessage,
  });

  @override
  EditQueenState copyWith({
    Status? status,
    Queen? queen,
    Map<String, bool>? isEditing,
    String? errorMessage,
  }) {
    return EditQueenState(
      queen: queen ?? this.queen,
      isEditing: isEditing ?? this.isEditing,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [queen, isEditing, ...super.props];
}