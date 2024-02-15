import 'package:examen_final_garcia/models/arbre.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void lauchURLAction(BuildContext context, String url) async {
  // Abrir el sitio web
  if (!await launch(url)) {
    throw 'Could not launch $url';
  }
}
