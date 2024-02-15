import 'dart:convert';

/// This model is a base class for other models used in the Api provider
/// to map the responses
class QuickTypeModel {
  QuickTypeModel();

  factory QuickTypeModel.fromJson(String str) =>
      QuickTypeModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory QuickTypeModel.fromMap(Map<String, dynamic> json) => QuickTypeModel();

  Map<String, dynamic> toMap() => {};
}
