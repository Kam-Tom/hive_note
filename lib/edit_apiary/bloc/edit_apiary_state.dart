part of 'edit_apiary_bloc.dart';

class EditApiaryState extends Equatable {
  final Apiary? apiary;
  final List<Hive> hives;
  final Status status;
  final String? errorMessage;
  final Map<String, bool> isEditing;

  const EditApiaryState({
    this.apiary,
    this.hives = const [],
    this.status = Status.initial,
    this.errorMessage,
    this.isEditing = const {},
  });

  EditApiaryState copyWith({
    Apiary? apiary,
    List<Hive>? hives,
    Status? status,
    String? errorMessage,
    Map<String, bool>? isEditing,
  }) {
    return EditApiaryState(
      apiary: apiary ?? this.apiary,
      hives: hives ?? this.hives,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      isEditing: isEditing ?? this.isEditing,
    );
  }

  @override
  List<Object?> get props => [apiary, hives, status, errorMessage, isEditing];
}