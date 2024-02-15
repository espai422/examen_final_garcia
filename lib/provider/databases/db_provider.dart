import 'dart:io';
import 'package:examen_final_garcia/models/models.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

/// Database provider class for managing SQLite database operations.
class DBProvider {
  /// Singleton instance of the database provider.
  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  /// Getter for the database instance.
  Future<Database> get database async {
    _database ??= await initDB();
    return _database!;
  }

  /// Initialize the database.
  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'examen.db');

    return await openDatabase(path, version: 1, onOpen: (db) {
      for (var table in _autmatedTablesSQL.keys) {
        _createTable(table, db);
        print('Created table for $table');
      }
    }, onCreate: (Database db, int version) async {
      await db.execute(_profileUsersTableSQL);
      // Create here all necessary tables, for manually tables create with same
      // name as model so can use generic functions
    });
  }

  /// Register a new user method given a ProfileUser object
  Future<void> registerUser(ProfileUser user) async {
    final db = await database;
    await db.insert('ProfileUsers', user.toMap());
  }

  /// get user by email, if the user is not found, return null
  Future<ProfileUser?> getUserByEmail(String email) async {
    final db = await database;
    List<Map<String, dynamic>> users =
        await db.query('ProfileUsers', where: 'email = ?', whereArgs: [email]);
    if (users.isNotEmpty) {
      return ProfileUser.fromMap(users.first);
    }
    return null;
  }

  Future<void> create<T extends BaseModel>(T model) async {
    final db = await database;
    final map = model.toMap();
    map['id'] = Uuid().v4();
    await db.insert(T.toString(), map);
  }

  Future<void> update<T extends BaseModel>(T model) async {
    final db = await database;
    await db.update(T.toString(), model.toMap(),
        where: 'id = ?', whereArgs: [model.id]);
  }

  Future<void> delete<T extends BaseModel>(T model) async {
    final db = await database;
    await db.delete(T.toString(), where: 'id = ?', whereArgs: [model.id]);
  }

  Future<List<Map<String, dynamic>>> read<T extends BaseModel>() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(T.toString());
    return maps;
  }

  /// private function to create a table from a Type
  _createTable(Type T, Database db) async {
    final fields = _autmatedTablesSQL[T];
    if (fields != null) {
      var sql = """
        CREATE TABLE IF NOT EXISTS ${T.toString()} (
          id TEXT PRIMARY KEY,
          ${_createSQLFields(fields)}
        )""";
      await db.execute(sql);
    }
  }

  _createSQLFields(Map<String, dynamic> fields) {
    var sql = '';
    fields.forEach((key, value) {
      sql += '$key TEXT,';
    });
    return sql.substring(0, sql.length - 1);
  }
}

/// Create users table SQL statement
const _profileUsersTableSQL = '''
  CREATE TABLE ProfileUsers (
    email TEXT PRIMARY KEY,
    username TEXT NOT NULL,
    password TEXT NOT NULL
  );
''';

Map<Type, Map<String, dynamic>> _autmatedTablesSQL = {
  // Movie: Movie.fromMap({}).toMap(),
  // Persona: Persona.fromMap({}).toMap(),
};

/// function to create a table from a Type
