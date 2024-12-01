import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_note/shared/bloc/helpers/initial_state.dart';
import 'package:hive_note/shared/bloc/helpers/status.dart';
import 'package:repositories/repositories.dart';

part 'preferences_event.dart';
part 'preferences_state.dart';

class PreferencesBloc extends Bloc<PreferencesEvent, PreferencesState> {
  final PreferencesRepository _preferencesRepository;

  PreferencesBloc({required PreferencesRepository preferencesRepository}) : 
    _preferencesRepository = preferencesRepository, super(const PreferencesState()) {
    on<LanguageChanged>((event, emit) async {
      await _preferencesRepository.saveLanguage(event.language);
      emit(state.copyWith(language: event.language));
    });

    on<NotificationToggled>((event, emit) async {
      await _preferencesRepository.saveNotificationEnabled(event.enabled);
      emit(state.copyWith(notificationsEnabled: event.enabled));
    });

    on<QueenDefaultBreedChanged>((event, emit) async {
      await _preferencesRepository.saveQueenDefaultBreed(event.breed);
      emit(state.copyWith(queenDefaultBreed: event.breed));
    });

    on<QueenDefaultOriginChanged>((event, emit) async {
      await _preferencesRepository.saveQueenDefaultOrigin(event.origin);
      emit(state.copyWith(queenDefaultOrigin: event.origin));
    });

    on<HiveDefaultNameChanged>((event, emit) async {
      await _preferencesRepository.saveHiveDefaultName(event.name);
      emit(state.copyWith(hiveDefaultName: event.name));
    });

    on<ApiaryDefaultNameChanged>((event, emit) async {
      await _preferencesRepository.saveApiaryDefaultName(event.name);
      emit(state.copyWith(apiaryDefaultName: event.name));
    });

    on<ApiaryDefaultColorChanged>((event, emit) async {
      await _preferencesRepository.saveApiaryDefaultColor(event.color);
      emit(state.copyWith(apiaryDefaultColor: event.color));
    });

    on<ToggleEditing>((event, emit) {
      final newEditingState = Map<String, bool>.from(state.isEditing);
      newEditingState[event.field] = !(newEditingState[event.field] ?? false);
      emit(state.copyWith(isEditing: newEditingState));
    });

    on<ReportTypeChanged>((event, emit) async {
      await _preferencesRepository.saveReportType(event.reportType);
      emit(state.copyWith(reportType: event.reportType));
    });

    // Add more event handlers as needed
  }
}