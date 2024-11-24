part of 'edit_queen_bloc.dart';

class EditQueenState extends InitialState {
  final Queen? queen;

  const EditQueenState({
    this.queen,
    super.status,
    super.errorMessage,
  });

  @override
  EditQueenState copyWith({
    Status? status,
    Queen? queen,
    String? errorMessage,
  }) {
    return EditQueenState(
      queen: queen ?? this.queen,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [queen, ...super.props];
}