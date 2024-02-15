import 'package:examen_final_garcia/models/profile_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Class to abstract the Shared preferences of the app
/// It's used to keep the last login and the last credentials used in the login
class Preferences {
  static late SharedPreferences _prefs;

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static SharedPreferences get prefs => _prefs;

  // Methods to keep the last login //

  /// Remove the last login from the preferences
  static void removeLastLogin() {
    _prefs.remove('last-login');
  }

  /// Save the last login to the preferences
  static void setLastLogin(ProfileUser user) {
    _prefs.setString('last-login', user.toJson());
  }

  /// Get the last User that logged in from the preferences to perform the
  /// automatic login
  static ProfileUser? getLastLogin() {
    final user = _prefs.getString('last-login');
    if (user != null) {
      return ProfileUser.fromJson(user);
    }

    return null;
  }

  // Methods to keep the last credentials //

  /// Remove the last credentials used in the login from the preferences
  static void removeKeppCredentials() {
    _prefs.remove('last-credentials');
  }

  /// Save the last credentials used in the login to the preferences
  static void setLastCredentials(ProfileUser user) {
    _prefs.setString('last-credentials', user.toJson());
  }

  /// Get the last User that logged in from the preferences to perform the
  /// automatic credentials set in the login form
  static ProfileUser? getLastCredentials() {
    final user = _prefs.getString('last-credentials');
    if (user != null) {
      return ProfileUser.fromJson(user);
    }

    return null;
  }
}
