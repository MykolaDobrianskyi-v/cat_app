import 'package:cat_app/models/cat.dart';
import 'package:cat_app/models/cat_model.dart';

import 'package:sqflite/sqflite.dart';

class CatDatabaseProvider {
  final Database _database;

  CatDatabaseProvider({
    required Database database,
  }) : _database = database;

  Future<List<CatModel>> fetchCat() async {
    final catsJson = await _database.query('cats');
    return catsJson.map((json) => CatModel.fromJson(json)).toList();
  }

  Future<void> insertCat(CatModel cat) async {
    await _database.insert(
      'cats',
      cat.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertAllCats(List<CatModel> cats) async {
    final asyncCats = cats.map((cat) => insertCat(cat));
    await Future.wait(asyncCats);
  }

  Future<void> addToFavorite(String userId, Cat cat) async {
    await _database.insert(
      'favorite',
      {
        'id': '${userId}_${cat.id}',
        'userId': userId,
        'catId': cat.id,
        'url': cat.url,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> removeFromFavorites(String userId, String catId) async {
    await _database.delete(
      'favorite',
      where: 'userId = ? AND catId = ?',
      whereArgs: [userId, catId],
    );
  }

  Future<List<CatModel>> fetchFavoriteCats(String userId) async {
    final favoriteCatJson = await _database.query(
      'favorite',
      where: 'userId = ?',
      whereArgs: [userId],
    );
    return favoriteCatJson
        .map(
          (json) => CatModel.fromJson(json),
        )
        .toList();
  }
}
