import 'package:examen_final_garcia/models/models.dart';
import 'package:flutter/material.dart';

enum FieldType { photo, url }

final Map<Type, Map<String, Widget Function(String)>> fieldsExceptions = {
  // Movie: {'desc': _netWorkImage},
};

Widget _netWorkImage(String url) {
  return Image.network(url);
}
