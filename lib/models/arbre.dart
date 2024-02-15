import 'dart:convert';

import 'package:examen_final_garcia/models/firebase_model.dart';

class Arbre extends BaseModel {
  String? nom;
  String? varietat;
  String? tipus;
  String? autocton;
  String? foto;
  String? detall;

  Arbre({
    super.id,
    this.nom,
    this.varietat,
    this.tipus,
    this.autocton,
    this.foto,
    this.detall,
  });

  factory Arbre.fromJson(String str) => Arbre.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Arbre.fromMap(Map<String, dynamic> json) => Arbre(
        nom: json["nom"],
        varietat: json["varietat"],
        tipus: json["tipus"],
        autocton: json["autocton"],
        foto: json["foto"],
        detall: json["detall"],
      );

  Map<String, dynamic> toMap() => {
        "nom": nom,
        "varietat": varietat,
        "tipus": tipus,
        "autocton": autocton,
        "foto": foto,
        "detall": detall,
      };
}
