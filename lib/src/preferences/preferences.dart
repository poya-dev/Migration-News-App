import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static SharedPreferences? preferences;
  static const String LANGUAGE_CODE = '__LanguageCode__';
  static const String USER_CODE = '__UserCode__';

  static init() async {
    Preferences.preferences = await SharedPreferences.getInstance();
  }
}
