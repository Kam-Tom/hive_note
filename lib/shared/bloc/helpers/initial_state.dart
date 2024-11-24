import 'package:equatable/equatable.dart';
import 'package:hive_note/shared/bloc/helpers/status.dart';

class InitialState extends Equatable {
  final Status status;
  final String? errorMessage;

  const InitialState({
    this.status = Status.initial,
    this.errorMessage,
  });

  InitialState copyWith({
    Status? status,
    String? errorMessage,
  }) {
    return InitialState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, errorMessage];
}