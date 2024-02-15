import 'package:examen_final_garcia/models/arbre.dart';
import 'package:examen_final_garcia/screens/crud_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  /// In this case the home screen is just a generic screen that uses the FirebaseCRUDScreen
  /// to show the list of items and the CRUD operations of the model Arbre
  @override
  Widget build(BuildContext context) {
    // final mapsProvider = Provider.of<MapsMarks>(context, listen: true);
    return FirebaseCRUDScreen<Arbre>(fromMap: Arbre.fromMap);
  }
}
