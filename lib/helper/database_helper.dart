import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const String _databaseName = 'cats.db';
  static const int _databaseVersion = 5;

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
        url TEXT NOT NULL,
        fact TEXT NOT NULL,
        isFavorite INTEGER DEFAULT 0
      )
    ''');

    await db.execute('''
      CREATE TABLE favorite (
        id TEXT PRIMARY KEY,
        userId TEXT NOT NULL,
        catId TEXT NOT NULL,
        url TEXT NOT NULL,
        fact TEXT NOT NULL,
        isFavorite INTEGER DEFAULT 0,
        FOREIGN KEY (id) REFERENCES cats(id) ON DELETE CASCADE
      )
    ''');
    await db.execute('''
    CREATE TABLE profile (
      id TEXT PRIMARY KEY,
      image TEXT NOT NULL,
      username TEXT NOT NULL,
      email TEXT NOT NULL
      )
''');
  }

  static Future<void> _migrate(
      Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 5) {
      await db.execute('''
        CREATE TABLE IF NOT EXISTS favorite (
          id TEXT PRIMARY KEY,
          userId TEXT NOT NULL,
          catId TEXT NOT NULL,
          url TEXT NOT NULL,
          isFavorite INTEGER DEFAULT 0,
          fact TEXT NOT NULL,
          FOREIGN KEY (id) REFERENCES cats(id) ON DELETE CASCADE
        )
      ''');
    }
  }
}
