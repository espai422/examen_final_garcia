import 'package:examen_final_garcia/models/models.dart';
import 'package:examen_final_garcia/screens/auth/auth_middleware.dart';
import 'package:examen_final_garcia/screens/screens.dart';
import 'package:flutter/material.dart';

/// Routes for the app
final Map<String, WidgetBuilder> routes = {
  '/': (context) => AuthMiddleware(),
  '/home-screen': (context) => HomeScreen(),
  '/maps-screen': (context) => MapsScreen(),
};
