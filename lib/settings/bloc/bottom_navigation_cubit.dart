import 'package:bloc/bloc.dart';

class BottomNavigationCubit extends Cubit<int> {
  BottomNavigationCubit({int initialIndex = 0}) : super(initialIndex);

  void changeTab(int index) {
    emit(index);
  }
}