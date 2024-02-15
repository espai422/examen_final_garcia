import 'package:examen_final_garcia/models/profile_user.dart';
import 'package:examen_final_garcia/provider/auth/auth.dart';
import 'package:examen_final_garcia/provider/databases/rtdb.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

/// Firebase implementation of [BaseAuth]
/// This class provides the implementation of the authentication methods using
/// Firebase Authentication.
class FireAuth extends BaseAuth {
  /// instance of firebase auth to perform authentication operations in Firebase
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Register with email and password
  @override
  Future<ProfileUser> registerWithEmailAndPassowrd(
      String email, String password, String userName) async {
    final user = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    await user.user?.updateDisplayName(userName);

    // also save user to the RTDB to use in the future if needed
    await saveUserToRTDB();

    return ProfileUser(email: email, username: userName, password: password);
  }

  /// Login with email and password
  @override
  Future<ProfileUser> loginWithEmailAndPassword(
      String email, String password) async {
    final user = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    return ProfileUser(
        email: user.user!.email!,
        username: user.user!.displayName!,
        password: password);
  }

  /// Call the super method to remove the last login from the preferences
  /// Also remove the current user from the provider
  @override
  Future<void> signOut(BuildContext context) async {
    super.signOut(context);
    await _auth.signOut();
  }

  /// Save the current firebase user to the Realtime Database
  /// This method is called after the user is created to save the user to the
  /// Realtime Database to use in the future if needed.
  Future<void> saveUserToRTDB() async {
    var ref = rtdb.ref('/users/${_auth.currentUser!.uid}');

    var snapshot = await ref.get();
    if (!snapshot.exists) {
      // User does not exist, update the data
      ref.set({
        'email': _auth.currentUser!.email,
        'displayName': _auth.currentUser!.displayName,
        'photoURL': _auth.currentUser!.photoURL,
      });
    }
  }
}
