part of 'edit_apiary_bloc.dart';

enum EditApiaryStatus { loading, success, failure, updated }

class EditApiaryState extends Equatable {
  const EditApiaryState({this.apiary, required this.status});

  final Apiary? apiary;
  final EditApiaryStatus status;

  @override
  List<Object?> get props => [apiary, status];

  EditApiaryState copyWith({
    EditApiaryStatus? status,
    Apiary? apiary,
  }) {
    return EditApiaryState(
      apiary: apiary ?? this.apiary,
      status: status ?? this.status,
    );
  }
}
