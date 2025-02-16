abstract class UserPref {
  Future<String> getLanguage();
  Future<void> saveLanguage(String language);

  Future<String> getQueenDefaultBreed();
  Future<void> saveQueenDefaultBreed(String breed);

  Future<String> getQueenDefaultOrigin();
  Future<void> saveQueenDefaultOrigin(String origin);

  Future<String> getHiveDefaultName();
  Future<void> saveHiveDefaultName(String name);

  Future<String> getApiaryDefaultName();
  Future<void> saveApiaryDefaultName(String name);

  Future<String> getApiaryDefaultColor();
  Future<void> saveApiaryDefaultColor(String color);

  Future<int> getReportType();
  Future<void> saveReportType(int reportType);

  Future<bool> isFirstLaunch();
  Future<void> setFirstLaunchComplete();

  Future<void> setDefaultsForLanguage(String language, {bool overwrite = false});

  Future<String> getHiveDefaultType();

  Future<void> saveHiveDefaultType(String type);
}
