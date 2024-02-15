import 'package:examen_final_garcia/models/firebase_model.dart';
import 'package:examen_final_garcia/provider/databases/db_provider.dart';
import 'package:examen_final_garcia/provider/databases/rtdb.dart';
import 'package:uuid/uuid.dart';

// A provider for SQLite operations.
///
/// This class provides methods for creating, reading, updating, and deleting
/// items in SQLite. It uses a generic type `T` that extends `SqliteModel`.
class SqliteCRUD<T extends BaseModel> extends BaseCRUD<T> {
  /// Creates a new SqliteCRUD with the given database and fromMap function.
  SqliteCRUD({required super.fromMap});

  /// Creates a new item in the SQLite database.
  final db = DBProvider.db;

  /// Creates an item in the SQLite database.
  @override
  Future<void> create(T model) async {
    await db.create<T>(model);
  }

  /// Deletes an item from the SQLite database.
  @override
  Future<void> delete(T model) async {
    await db.delete(model);
  }

  /// Reads all items from the SQLite database and returns them as a list.
  @override
  Future<List<T>> read() async {
    var data = await db.read<T>();

    return data.map((item) => fromMap(item)..id = item['id']).toList();
  }

  /// Updates an item in the SQLite database.
  @override
  Future<void> update(T model) async {
    db.update(model);
  }
}
