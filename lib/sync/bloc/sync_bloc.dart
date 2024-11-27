import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_note/sync/bloc/sync_event.dart';
import 'package:hive_note/sync/bloc/sync_state.dart';

class SyncBloc extends Bloc<SyncEvent, SyncState> {

  SyncBloc() : super(const SyncState()) {

    on<ToggleVoiceControl>(_onToggleVoiceControl);
  }

  void _onToggleVoiceControl(ToggleVoiceControl event, Emitter<SyncState> emit) {
    emit(state.copyWith(syncEnabled: () => event.isEnabled));
  }
}