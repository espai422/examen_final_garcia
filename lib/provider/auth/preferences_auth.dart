import 'package:examen_final_garcia/models/profile_user.dart';
import 'package:examen_final_garcia/provider/auth/auth.dart';
import 'package:examen_final_garcia/provider/databases/preferences.dart';

/// Auth provider that uses the preferences create a login and register system
/// this is the simplest way to provide a login system, it's not secure and
/// should not be used in a real app.
class PreferencesAuth extends BaseAuth {
  /// Login with email and password
  @override
  Future<ProfileUser> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      return getUsers().firstWhere(
          (user) => user.email == email && user.password == password);
    } catch (e) {
      throw Exception('User not found');
    }
  }

  /// Register a new user with email and password
  @override
  Future<ProfileUser> registerWithEmailAndPassowrd(
      String email, String password, String userName) async {
    final prefs = Preferences.prefs;
    final otherUsers = getUsers();

    // check if the user already exists
    if (otherUsers.any((user) => user.email == email)) {
      throw Exception('User already exists');
    }

    // save the new user to the preferences
    final newUser = ProfileUser(
      email: email,
      password: password,
      username: userName,
    );
    prefs.setStringList(
        'users',
        [
          ...otherUsers,
          newUser,
        ].map((e) => e.toJson()).toList());

    return newUser;
  }

  /// Get the list of users from the preferences
  List<ProfileUser> getUsers() {
    final prefs = Preferences.prefs;
    final users = prefs.getStringList('users');
    if (users != null) {
      return users.map((user) => ProfileUser.fromJson(user)).toList();
    }
    return [];
  }
}
