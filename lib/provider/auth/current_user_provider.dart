import 'package:examen_final_garcia/models/profile_user.dart';
import 'package:examen_final_garcia/provider/databases/preferences.dart';
import 'package:flutter/material.dart';

/// Provider to keep the current user logged in
/// It is used to know if we need to display the login screen or the home screen
/// and to get user data from the whole app.
///
/// The initial value is the last user logged in if the user marked that he
/// wanted to keep the session open. if not it's null unitl the user logs in.
class CurrentUserProvider extends ChangeNotifier {
  ProfileUser? _currentUser = Preferences.getLastLogin();
  ProfileUser? get currentUser => _currentUser;

  set currentUser(ProfileUser? user) {
    _currentUser = user;
    notifyListeners();
  }
}
