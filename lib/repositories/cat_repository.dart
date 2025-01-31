import 'dart:async';

import 'package:cat_app/models/cat.dart';
import 'package:cat_app/models/cat_model.dart';

import 'package:cat_app/providers/cat_api_provider.dart';
import 'package:cat_app/providers/cat_database_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CatRepository {
  final CatApiProvider _catApiProvider;
  final CatDatabaseProvider _catDatabaseProvider;
  final FirebaseAuth _auth;

  CatRepository(
      {required CatApiProvider catApiProvider,
      required FirebaseAuth auth,
      required CatDatabaseProvider catDatabaseProvider})
      : _catApiProvider = catApiProvider,
        _catDatabaseProvider = catDatabaseProvider,
        _auth = auth;

  final StreamController<Cat> _favCatsStreamController =
      StreamController.broadcast();

  Stream<Cat> get favCatsStream => _favCatsStreamController.stream;

  Future<List<Cat>> fetchCatApi({int page = 0}) async {
    final List<CatModel> cats;
    try {
      cats = await _catApiProvider.fetchCatApi(page: page);
    } catch (e) {
      final catModels = await _catDatabaseProvider.fetchCat();
      return catModels.map((cat) => cat.toCat()).toList();
    }
    final asyncCats = cats.map((element) async {
      return Cat(
        id: element.id,
        url: element.url,
        isFavorite: element.isFavorite,
      );
    });
    await _catDatabaseProvider.insertAllCats(cats);
    return await Future.wait(asyncCats);
  }

  Future<List<Cat>> fetchFavoriteCats() async {
    final favCats =
        await _catDatabaseProvider.fetchFavoriteCats(_auth.currentUser!.uid);
    final asyncFavCats = favCats.map((catModel) async {
      return catModel.toCat();
    });
    return await Future.wait(asyncFavCats);
  }

  Future<void> toggleFavorite(Cat cat) async {
    print('CAT : ${cat}');
    final String userId = _auth.currentUser!.uid;

    final bool exists = await _catDatabaseProvider.isFavorite(userId, cat.id);

    if (exists) {
      await _catDatabaseProvider.removeFromFavorites(userId, cat.id);
    } else {
      await _catDatabaseProvider.addToFavorite(userId, cat);
    }
    _favCatsStreamController.add(cat.copyWith(isFavorite: !cat.isFavorite));
  }
}
