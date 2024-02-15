import 'package:examen_final_garcia/models/profile_user.dart';
import 'package:examen_final_garcia/provider/auth/preferences_auth.dart';
import 'package:examen_final_garcia/provider/auth/current_user_provider.dart';
import 'package:examen_final_garcia/provider/auth/sqlite_auth.dart';
import 'package:examen_final_garcia/provider/databases/preferences.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

/// Base class for authentication methods, three more classes extend this class
/// to provide different authentication methods (Firebase, SharedPreferences,
/// SQLite to adapt the app to different possible exam statements.
/// if the exam does not specify the authentication method,
/// the Firebase method will be used to provide a more complete and secure
/// solution.
///
/// Other classes need to implement the methods `registerWithEmailAndPassowrd`
/// and `loginWithEmailAndPassword` to provide the authentication method.
/// all the extra functionality will be implemented in the login form, this is
/// just to provide the authentication system.
abstract class BaseAuth {
  Future<ProfileUser> registerWithEmailAndPassowrd(
      String email, String password, String userName);

  Future<ProfileUser> loginWithEmailAndPassword(String email, String password);

  /// Sign out the user and remove the last login from the preferences
  /// Also remove the current user from the provider and navigate to the login
  Future<void> signOut(BuildContext context) async {
    Preferences.removeLastLogin();
    Provider.of<CurrentUserProvider>(context, listen: false).currentUser = null;
    Navigator.pushReplacementNamed(context, '/');
  }
}

/// This is the authMehtod that will be used in the app, it's accessible from
/// the whole app.
final BaseAuth authMethod = SqliteAuth();
