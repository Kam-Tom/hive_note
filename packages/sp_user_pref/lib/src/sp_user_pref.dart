import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_pref/user_pref.dart';

class SpUserPref implements UserPref {
  final SharedPreferences _prefs;
  
  SpUserPref._(this._prefs);

  static Future<SpUserPref> create() async {
    final prefs = await SharedPreferences.getInstance();
    return SpUserPref._(prefs);
  }

  static const _keyLanguage = 'language';
  static const _keyQueenBreed = 'queen_breed';
  static const _keyQueenOrigin = 'queen_origin';
  static const _keyHiveName = 'hive_name';
  static const _keyHiveType = 'hive_type';
  static const _keyApiaryName = 'apiary_name';
  static const _keyApiaryColor = 'apiary_color';
  static const _keyReportType = 'report_type';
  static const _keyFirstLaunch = 'is_first_launch';

  @override
  Future<String> getLanguage() async {
    return _prefs.getString(_keyLanguage) ?? DefaultPreferences.language;
  }

  @override
  Future<void> saveLanguage(String language) async {
    await _prefs.setString(_keyLanguage, language);
  }

  @override
  Future<void> setDefaultsForLanguage(String language, {bool overwrite = false}) async {
    if (overwrite || !_prefs.containsKey(_keyQueenOrigin)) {
      await saveQueenDefaultOrigin(LanguageDefaults.getValue(language, 'queen_origin'));
    }
    
    if (overwrite || !_prefs.containsKey(_keyQueenBreed)) {
      await saveQueenDefaultBreed(LanguageDefaults.getValue(language, 'queen_breed'));
    }
    
    if (overwrite || !_prefs.containsKey(_keyHiveName)) {
      await saveHiveDefaultName(LanguageDefaults.getValue(language, 'hive_name'));
    }    
    
    if (overwrite || !_prefs.containsKey(_keyHiveType)) {
      await saveHiveDefaultType(LanguageDefaults.getValue(language, 'hive_type'));
    }
    
    if (overwrite || !_prefs.containsKey(_keyApiaryName)) {
      await saveApiaryDefaultName(LanguageDefaults.getValue(language, 'apiary_name'));
    }
  }

  @override
  Future<String> getQueenDefaultBreed() async => 
      _prefs.getString(_keyQueenBreed)!;

  @override
  Future<void> saveQueenDefaultBreed(String breed) async {
    await _prefs.setString(_keyQueenBreed, breed);
  }

  @override
  Future<String> getQueenDefaultOrigin() async => 
      _prefs.getString(_keyQueenOrigin)!;

  @override
  Future<void> saveQueenDefaultOrigin(String origin) async {
    await _prefs.setString(_keyQueenOrigin, origin);
  }

  @override
  Future<String> getHiveDefaultName() async => 
      _prefs.getString(_keyHiveName)!;

  @override
  Future<void> saveHiveDefaultName(String name) async {
    await _prefs.setString(_keyHiveName, name);
  }

  @override
  Future<String> getApiaryDefaultName() async => 
      _prefs.getString(_keyApiaryName)!;

  @override
  Future<void> saveApiaryDefaultName(String name) async {
    await _prefs.setString(_keyApiaryName, name);
  }

  @override
  Future<String> getApiaryDefaultColor() async => 
      _prefs.getString(_keyApiaryColor) ?? DefaultPreferences.apiaryColor;

  @override
  Future<void> saveApiaryDefaultColor(String color) async {
    await _prefs.setString(_keyApiaryColor, color);
  }

  @override
  Future<int> getReportType() async => 
      _prefs.getInt(_keyReportType) ?? DefaultPreferences.reportType;

  @override
  Future<void> saveReportType(int reportType) async {
    await _prefs.setInt(_keyReportType, reportType);
  }

  @override
  Future<bool> isFirstLaunch() async {
    return _prefs.getBool(_keyFirstLaunch) ?? true;
  }

  @override
  Future<void> setFirstLaunchComplete() async {
    await _prefs.setBool(_keyFirstLaunch, false);
  }
  
  @override
  Future<String> getHiveDefaultType() async =>
    _prefs.getString(_keyHiveType)!;
  
  @override
  Future<void> saveHiveDefaultType(String type) async {
    await _prefs.setString(_keyHiveType, type);
  }
}
