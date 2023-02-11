import 'dart:convert';

import '../models/user.dart';
import './preferences.dart';

class UserPrefs {
  static void setUser(User user) {
    String decodedUser = jsonEncode(user.toJson());
    Preferences.preferences!.setString(
      Preferences.USER_CODE,
      decodedUser,
    );
  }

  static User? getUser() {
    String? user = Preferences.preferences!.getString(Preferences.USER_CODE);
    if (user != null) {
      return User.fromPrefJson(jsonDecode(user));
    }
    return null;
  }

  static removeUser() {
    Preferences.preferences!.remove(Preferences.USER_CODE);
  }
}
