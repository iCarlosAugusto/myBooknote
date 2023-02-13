import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class DB {
  static Database? _database;

  get database async {
    if (_database != null) return _database;

    return await _initDatabase();
  }

  _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'booknote.db'),
      version: 1,
      onCreate: _onCreate,
    );
  }

  _onCreate(db, versao) async {
    await db.execute(_subjects);
  }

  String get _subjects => '''
    CREATE TABLE subjects (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      professor TEXT,
      images TEXT
    )
  ''';
}