import 'package:examen_final_garcia/models/arbre.dart';
import 'package:examen_final_garcia/models/models.dart';
import 'package:examen_final_garcia/screens/auth/auth_middleware.dart';
import 'package:examen_final_garcia/screens/screens.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

/// Routes for the app
final Map<String, WidgetBuilder> routes = {
  '/': (context) => AuthMiddleware(),
  '/home-screen': (context) => HomeScreen(),
  '/maps-screen': (context) => MapsScreen(),
  '/arbre-screen': (context) =>
      FirebaseCRUDScreen<Arbre>(fromMap: Arbre.fromMap),
};
