import 'package:examen_final_garcia/models/arbre.dart';
import 'package:examen_final_garcia/provider/databases/crud_provider.dart';
import 'package:examen_final_garcia/provider/provider.dart';
import 'package:examen_final_garcia/screens/crud_screen.dart';
import 'package:examen_final_garcia/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser =
        Provider.of<CurrentUserProvider>(context, listen: false).currentUser;
    // final mapsProvider = Provider.of<MapsMarks>(context, listen: true);
    return FirebaseCRUDScreen<Arbre>(fromMap: Arbre.fromMap);
  }
}
