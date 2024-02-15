import 'package:examen_final_garcia/models/models.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

/// Realtime Database instance
FirebaseDatabase rtdb = FirebaseDatabase.instance;

/// this class is aimed to Firebase List of Objects where T is the model of each object
/// it has the basic CRUD operations given a path and a model. is generic so
/// it can be used with any model that extends FirebaseModel we need to pass the
/// fromMap function to convert the map to the model due to limitation with
/// relfection in the flutter sdk because it's removes for performance reasons.
abstract class BaseCRUD<T extends BaseModel> {
  Future<void> create(T model);
  Future<void> update(T model);
  Future<void> delete(T model);
  Future<List<T>> read();
  final T Function(Map<String, dynamic>) fromMap;

  BaseCRUD({required this.fromMap});

  Future<void> createFromMap(Map<String, dynamic> map) async {
    T model = fromMap(map);
    await create(model);
  }

  Future<void> updateFromMap(Map<String, dynamic> map, String id) async {
    T model = fromMap(map);
    model.id = id;
    await update(model);
  }
}

class RTDBCRUDSDK<T extends BaseModel> extends BaseCRUD<T> {
  final String path; // example /models
  final DatabaseReference ref;
  final bool onlyOneItem;

  RTDBCRUDSDK(
      {required this.path, required super.fromMap, this.onlyOneItem = false})
      : ref = rtdb.ref(path);

  /// Create new object in firebase based on the model
  @override
  Future<void> create(T model) async {
    if (onlyOneItem) {
      await ref.set(model.toMap());
      return;
    }

    await ref.push().set(model.toMap());
  }

  /// update an object in firebase based on the model
  @override
  Future<void> update(T model) async {
    if (model.id == null) {
      throw Exception('Can not update in firebase withoud the object id.');
    }

    if (onlyOneItem) {
      await ref.set(model.toMap());
      return;
    }

    await ref.child(model.id!).update(model.toMap());
  }

  /// Delete the provided model from firebase
  @override
  Future<void> delete(T model) async {
    if (model.id == null) {
      throw Exception('Can not delete in firebase withoud the object id.');
    }

    if (onlyOneItem) {
      await ref.remove();
      return;
    }

    await ref.child(model.id!).remove();
  }

  /// Returns a list of objects placed in the path
  @override
  Future<List<T>> read() async {
    final snapshot = await ref.get();
    final data = snapshot.value;
    if (data == null) {
      return [];
    }

    final dataToParse = _castMap(data as Map);

    if (onlyOneItem) {
      return [fromMap(dataToParse)..id = snapshot.key];
    }

    List<T> list = [];
    dataToParse.forEach((key, value) {
      final val = fromMap(value);
      val.id = key;
      list.add(val);
    });

    return list;
  }

  /// Recursive function to cast the map to the correct type Map<String, dynamic>
  /// withoud this we can't map a Map<Object?, Object?> to a Map<String, dynamic>
  /// which is the type of the model.toMap() method that quicktype generates.
  Map<String, dynamic> _castMap(Map<Object?, Object?> map) {
    print('map: $map');
    final newMap = <String, dynamic>{};
    map.forEach((key, value) {
      // make here type conversions
      if (value.runtimeType.toString() == '_Map<Object?, Object?>') {
        value = _castMap(value as Map);
      }

      newMap[key.toString()] = value;
    });

    return newMap;
  }
}

class RTDBCRUDhttp<T extends BaseModel> extends BaseCRUD<T> {
  final String baseUrl =
      'https://examenflutter-41e66-default-rtdb.europe-west1.firebasedatabase.app/'; // example: https://your-project-id.firebaseio.com/
  final String path; // example: /models
  final bool onlyOneItem;

  RTDBCRUDhttp(
      {required this.path, required super.fromMap, this.onlyOneItem = false});

  @override
  Future<void> create(T model) async {
    final url = Uri.parse(baseUrl + path + '.json');
    final response = await http.post(url, body: json.encode(model.toMap()));
    if (response.statusCode != 200) {
      throw Exception('Failed to create object');
    }
  }

  @override
  Future<void> update(T model) async {
    if (model.id == null) {
      throw Exception('Cannot update object without id');
    }
    final url = Uri.parse(baseUrl + path + '/' + model.id! + '.json');
    final response = await http.put(url, body: json.encode(model.toMap()));
    if (response.statusCode != 200) {
      throw Exception('Failed to update object');
    }
  }

  @override
  Future<void> delete(T model) async {
    if (model.id == null) {
      throw Exception('Cannot delete object without id');
    }
    final url = Uri.parse(baseUrl + path + '/' + model.id! + '.json');
    final response = await http.delete(url);
    if (response.statusCode != 200) {
      throw Exception('Failed to delete object');
    }
  }

  @override
  Future<List<T>> read() async {
    final url = Uri.parse(baseUrl + path + '.json');
    final response = await http.get(url);
    if (response.statusCode != 200) {
      throw Exception('Failed to load objects');
    }
    final data = json.decode(response.body) as Map<String, dynamic>;
    return data.entries.map((e) {
      final model = fromMap(e.value);
      model.id = e.key;
      return model;
    }).toList();
  }
}
