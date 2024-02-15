import 'package:examen_final_garcia/provider/provider.dart';
import 'package:examen_final_garcia/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Middleware to check if the user is logged in or not
/// returns the HomeScreen if the user is logged in
/// returns the LoginScreen if the user is not logged in
class AuthMiddleware extends StatelessWidget {
  const AuthMiddleware({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUserProvider = Provider.of<CurrentUserProvider>(context);
    if (currentUserProvider.currentUser == null) {
      return LoginScreen(authProvider: authMethod);
    }
    return HomeScreen();
  }
}
