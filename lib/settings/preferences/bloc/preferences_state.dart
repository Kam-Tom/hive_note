part of 'preferences_bloc.dart';

class PreferencesState extends InitialState {
  final String language;
  final bool notificationsEnabled;
  final String queenDefaultBreed;
  final String queenDefaultOrigin;
  final String hiveDefaultName;
  final String apiaryDefaultName;
  final String apiaryDefaultColor;
  final Map<String, bool> isEditing;

  const PreferencesState({
    this.language = 'en',
    this.notificationsEnabled = false,
    this.queenDefaultBreed = '',
    this.queenDefaultOrigin = '',
    this.hiveDefaultName = '',
    this.apiaryDefaultName = '',
    this.apiaryDefaultColor = '',
    this.isEditing = const {},
    super.status,
    super.errorMessage,
  });

  @override
  PreferencesState copyWith({
    String? language,
    bool? notificationsEnabled,
    String? queenDefaultBreed,
    String? queenDefaultOrigin,
    String? hiveDefaultName,
    String? apiaryDefaultName,
    String? apiaryDefaultColor,
    Map<String, bool>? isEditing,
    Status? status,
    String? errorMessage,
  }) {
    return PreferencesState(
      language: language ?? this.language,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      queenDefaultBreed: queenDefaultBreed ?? this.queenDefaultBreed,
      queenDefaultOrigin: queenDefaultOrigin ?? this.queenDefaultOrigin,
      hiveDefaultName: hiveDefaultName ?? this.hiveDefaultName,
      apiaryDefaultName: apiaryDefaultName ?? this.apiaryDefaultName,
      apiaryDefaultColor: apiaryDefaultColor ?? this.apiaryDefaultColor,
      isEditing: isEditing ?? this.isEditing,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    language,
    notificationsEnabled,
    queenDefaultBreed,
    queenDefaultOrigin,
    hiveDefaultName,
    apiaryDefaultName,
    apiaryDefaultColor,
    isEditing,
    ...super.props,
  ];
}


