import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const String _databaseName = 'cats.db';
  static const int _databaseVersion = 3;

  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  static Future<Database> initDatabase() async {
    final path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: (db, version) async {
        await _createTables(db);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        await _migrate(db, oldVersion, newVersion);
      },
    );
  }

  static Future<void> _createTables(Database db) async {
    await db.execute('''
      CREATE TABLE cats (
        id TEXT PRIMARY KEY,
        url TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE favorite (
        id TEXT PRIMARY KEY,
        userId TEXT NOT NULL,
        catId TEXT NOT NULL,
        url TEXT NOT NULL,
        FOREIGN KEY (id) REFERENCES cats(id) ON DELETE CASCADE
      )
    ''');
  }

  static Future<void> _migrate(
      Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 3) {
      await db.execute('''
        CREATE TABLE IF NOT EXISTS favorite (
          id TEXT PRIMARY KEY,
          userId TEXT NOT NULL,
          catId TEXT NOT NULL,
          url TEXT NOT NULL,
          FOREIGN KEY (id) REFERENCES cats(id) ON DELETE CASCADE
        )
      ''');
    }
  }
}
