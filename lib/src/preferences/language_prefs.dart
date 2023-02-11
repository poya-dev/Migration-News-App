import 'dart:convert';

import '../blocs/locale/locale_event.dart' show Language;
import './preferences.dart';

class LanguagePrefs {
  static void setLocale(Language? language) {
    if (language == null) {
      language = Language.persian;
    }
    String lang = jsonEncode(language.toString());
    Preferences.preferences!.setString(
      Preferences.LANGUAGE_CODE,
      lang,
    );
  }

  static Language? getLocale() {
    String? language =
        Preferences.preferences!.getString(Preferences.LANGUAGE_CODE);
    if (language == null) {
      return null;
    }
    return getLangFromString(jsonDecode(language));
  }

  static Language? getLangFromString(String lang) {
    for (Language language in Language.values) {
      if (language.toString() == lang) {
        return language;
      }
    }
    return null;
  }

  static void removeLocale() {
    Preferences.preferences!.remove(Preferences.LANGUAGE_CODE);
  }
}
