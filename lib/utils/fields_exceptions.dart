import 'package:examen_final_garcia/models/arbre.dart';
import 'package:examen_final_garcia/models/models.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:examen_final_garcia/models/arbre.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

enum FieldType { photo, url }

final Map<Type, Map<String, Widget Function(String)>> fieldsExceptions = {
  // Movie: {'desc': _netWorkImage},
  Arbre: {'foto': _netWorkImage, 'detall': _url, 'autocton': _boolean},
};

Widget _netWorkImage(String url) {
  return Image.network(url);
}

Widget _boolean(String value) {
  final isChecked = value == 'true';
  return Checkbox(
    value: isChecked,
    onChanged: null, // Disable checkbox interaction
  );
}

Widget _url(String url) {
  return ElevatedButton(
    onPressed: () {
      lauchURLAction(url);
    },
    child: Text('Open URL'),
  );
}

void lauchURLAction(String url) async {
  // Abrir el sitio web
  if (!await launch(url)) {
    throw 'Could not launch $url';
  }
}
