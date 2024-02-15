/// Create an API provider, given a base url have a function to
/// fetch data from the api, it has a path of the url as a parameter and
/// has a generic type wihch is the type of the response of the api
import 'dart:convert';

import 'package:examen_final_garcia/models/quicktype_model.dart';
import 'package:http/http.dart' as http;

class ApiProvider {
  final String baseUrl;

  ApiProvider(this.baseUrl);

  /// Fetch data from the api and automatically map it to a quicktype model
  /// This function is generic and can be used with any quicktype model but it
  /// does't work with arrays
  Future<T> fetchObject<T extends QuickTypeModel>(
      String path, T Function(String json) converter) async {
    final response = await http.get(Uri.parse(baseUrl + path));
    return converter(response.body);
  }

  /// Fetch data from the api and automatically map it to a qiucktype model
  /// list, this function is generic and can be used with any quicktype model
  Future<List<T>> fetchList<T extends QuickTypeModel>(
      String path, T Function(String json) converter) async {
    final response = await http.get(Uri.parse(baseUrl + path));
    final List<dynamic> list = json.decode(response.body);
    return list.map((e) => converter(json.encode(e))).toList();
  }

  /// Use this function in case of the response is not mappeable in quicktype
  /// or has the firebase format
  Future<dynamic> fetchJsonData(String path) async {
    final response = await http.get(Uri.parse(baseUrl + path));
    return json.decode(response.body);
  }

  Future<void> postData(String path, Map<String, dynamic> data) async {
    await http.post(Uri.parse(baseUrl + path), body: json.encode(data));
  }
}
