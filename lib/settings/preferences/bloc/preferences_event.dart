part of 'preferences_bloc.dart';

abstract class PreferencesEvent {}

class ReportTypeChanged extends PreferencesEvent {
  final int reportType;

  ReportTypeChanged(this.reportType);
}

class LanguageChanged extends PreferencesEvent {
  final String language;

  LanguageChanged(this.language);
}

class NotificationToggled extends PreferencesEvent {
  final bool enabled;

  NotificationToggled(this.enabled);
}

class QueenDefaultBreedChanged extends PreferencesEvent {
  final String breed;

  QueenDefaultBreedChanged(this.breed);
}

class QueenDefaultOriginChanged extends PreferencesEvent {
  final String origin;

  QueenDefaultOriginChanged(this.origin);
}

class HiveDefaultNameChanged extends PreferencesEvent {
  final String name;

  HiveDefaultNameChanged(this.name);
}

class ApiaryDefaultNameChanged extends PreferencesEvent {
  final String name;

  ApiaryDefaultNameChanged(this.name);
}

class ApiaryDefaultColorChanged extends PreferencesEvent {
  final String color;

  ApiaryDefaultColorChanged(this.color);
}

class ToggleEditing extends PreferencesEvent {
  final String field;

  ToggleEditing(this.field);
}

