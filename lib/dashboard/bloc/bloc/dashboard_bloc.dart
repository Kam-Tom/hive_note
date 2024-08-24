import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:repositories/repositories.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final TodoRepository todoRepository;

  DashboardBloc({required this.todoRepository}) : super(DashboardInitial()) {
    print('sadasd');
    on<DashboardEvent>((event, emit) {
    });
  }
}
