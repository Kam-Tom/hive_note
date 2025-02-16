import 'package:user_pref/user_pref.dart';

class PreferencesRepository {
  final UserPref _userPref;

  PreferencesRepository(this._userPref);

  Future<String> getLanguage() => _userPref.getLanguage();
  Future<void> saveLanguage(String language) => _userPref.saveLanguage(language);

  Future<String> getQueenDefaultBreed() => _userPref.getQueenDefaultBreed();
  Future<void> saveQueenDefaultBreed(String breed) => _userPref.saveQueenDefaultBreed(breed);

  Future<String> getQueenDefaultOrigin() => _userPref.getQueenDefaultOrigin();
  Future<void> saveQueenDefaultOrigin(String origin) => _userPref.saveQueenDefaultOrigin(origin);

  Future<String> getHiveDefaultName() => _userPref.getHiveDefaultName();
  Future<void> saveHiveDefaultName(String name) => _userPref.saveHiveDefaultName(name);

  Future<String> getHiveDefaultType() => _userPref.getHiveDefaultType();
  Future<void> saveHiveDefaultType(String type) => _userPref.saveHiveDefaultType(type);

  Future<String> getApiaryDefaultName() => _userPref.getApiaryDefaultName();
  Future<void> saveApiaryDefaultName(String name) => _userPref.saveApiaryDefaultName(name);

  Future<String> getApiaryDefaultColor() => _userPref.getApiaryDefaultColor();
  Future<void> saveApiaryDefaultColor(String color) => _userPref.saveApiaryDefaultColor(color);

  Future<int?> getReportType() => _userPref.getReportType();
  Future<void> saveReportType(int reportType) => _userPref.saveReportType(reportType);

  Future<bool> isFirstLaunch() => _userPref.isFirstLaunch();
  Future<void> setFirstLaunchComplete() => _userPref.setFirstLaunchComplete();

  Future<void> setDefaultsForLanguage(String language, {bool overwrite = false}) => _userPref.setDefaultsForLanguage(language, overwrite: overwrite);

}
