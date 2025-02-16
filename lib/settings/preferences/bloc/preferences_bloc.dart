import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_note/shared/bloc/helpers/initial_state.dart';
import 'package:hive_note/shared/bloc/helpers/status.dart';
import 'package:repositories/repositories.dart';

part 'preferences_event.dart';
part 'preferences_state.dart';

class PreferencesBloc extends Bloc<PreferencesEvent, PreferencesState> {
  final PreferencesRepository _preferencesRepository;

  PreferencesBloc({required PreferencesRepository preferencesRepository}) : 
    _preferencesRepository = preferencesRepository, 
    super(const PreferencesState()) {
    
    on<LoadPreferences>((event, emit) async {
      emit(state.copyWith(status: Status.loading));
      try {
        final isFirstLaunch = await _preferencesRepository.isFirstLaunch();
        String? language = await _preferencesRepository.getLanguage();

        if (isFirstLaunch) {
          // Get system locale and save it as default
          final deviceLocale = event.deviceLocale ?? const Locale('en');
          language = deviceLocale.languageCode;
          await _preferencesRepository.saveLanguage(language);
          await _preferencesRepository.setDefaultsForLanguage(language);  // Only set defaults on first launch
          await _preferencesRepository.setFirstLaunchComplete();
        }

        // Load other preferences
        final queenBreed = await _preferencesRepository.getQueenDefaultBreed();
        final queenOrigin = await _preferencesRepository.getQueenDefaultOrigin();
        final hiveName = await _preferencesRepository.getHiveDefaultName();
        final hiveType = await _preferencesRepository.getHiveDefaultType();
        final apiaryName = await _preferencesRepository.getApiaryDefaultName();
        final apiaryColor = await _preferencesRepository.getApiaryDefaultColor();
        final reportType = await _preferencesRepository.getReportType();

        emit(state.copyWith(
          language: language,
          queenDefaultBreed: queenBreed,
          queenDefaultOrigin: queenOrigin,
          hiveDefaultName: hiveName,
          hiveDefaultType: hiveType,
          apiaryDefaultName: apiaryName,
          apiaryDefaultColor: apiaryColor,
          reportType: reportType,
          status: Status.success,
        ));
      } catch (e) {
        emit(state.copyWith(
          status: Status.failure,
          errorMessage: e.toString(),
        ));
      }
    });

    on<LanguageChanged>((event, emit) async {
      await _preferencesRepository.saveLanguage(event.language);  // Remove setDefaultsForLanguage here
      await _preferencesRepository.setDefaultsForLanguage(event.language, overwrite: true); // Set defaults on language change
      emit(state.copyWith(language: event.language,
        queenDefaultBreed: await _preferencesRepository.getQueenDefaultBreed(),
        queenDefaultOrigin: await _preferencesRepository.getQueenDefaultOrigin(),
        hiveDefaultName: await _preferencesRepository.getHiveDefaultName(),
        hiveDefaultType:  await _preferencesRepository.getHiveDefaultType(),
        apiaryDefaultName: await _preferencesRepository.getApiaryDefaultName(),
        apiaryDefaultColor: await _preferencesRepository.getApiaryDefaultColor(),
        reportType: await _preferencesRepository.getReportType(),
      ));
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

    on<HiveDefaultTypeChanged>((event, emit) async {
      await _preferencesRepository.saveHiveDefaultType(event.type);
      emit(state.copyWith(hiveDefaultType: event.type));
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

  }
}