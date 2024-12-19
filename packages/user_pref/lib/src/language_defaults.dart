class LanguageDefaults {
  static const Map<String, Map<String, String>> defaults = {
    'en': {
      'queen_breed': 'Italian',
      'queen_origin': 'Unknown',
      'hive_name': 'Hive',
      'hive_type': 'Langstroth',
      'apiary_name': 'Apiary',
    },
    'pl': {
      'queen_breed': 'Augustowska',
      'queen_origin': 'Nieznane',
      'hive_name': 'Ul',
      'hive_type': 'Wielkopolski',
      'apiary_name': 'Pasieka',
    },
  };

  static String getValue(String language, String key) {
    return defaults[language]?[key] ?? defaults['en']![key]!;
  }
}
