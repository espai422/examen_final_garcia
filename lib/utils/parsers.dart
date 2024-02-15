import 'dart:convert';

class ModelParser<T> {
  final T Function(dynamic) converter;

  ModelParser(this.converter);

  T parseObject(json) {
    return converter(json);
  }

  List<T> parseListObject(json) {
    List<T> list = [];
    for (var item in json) {
      list.add(converter(item));
    }
    return list;
  }

  List<T> parseListObjectFromStr(String str) {
    final data = json.decode(str);
    return parseListObject(data);
  }
}
