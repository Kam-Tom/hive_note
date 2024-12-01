import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repositories/repositories.dart';

class EntryTypeCubit extends Cubit<EntryType> {
  EntryTypeCubit() : super(EntryType.text);

  void setType(EntryType type) => emit(type);
}