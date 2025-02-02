import 'dart:async';

import 'package:cat_app/extensions/iterable_extension.dart';
import 'package:cat_app/models/cat.dart';
import 'package:cat_app/models/cat_model.dart';

import 'package:cat_app/providers/cat_api_provider.dart';
import 'package:cat_app/providers/cat_database_provider.dart';
import 'package:cat_app/providers/cat_facts_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CatRepository {
  final CatApiProvider _catApiProvider;
  final CatDatabaseProvider _catDatabaseProvider;
  final FirebaseAuth _auth;
  final CatFactsProvider _catFactsProvider;

  CatRepository({
    required CatApiProvider catApiProvider,
    required FirebaseAuth auth,
    required CatDatabaseProvider catDatabaseProvider,
    required CatFactsProvider catFactsProvider,
  })  : _catApiProvider = catApiProvider,
        _catDatabaseProvider = catDatabaseProvider,
        _auth = auth,
        _catFactsProvider = catFactsProvider;

  final StreamController<Cat> _favCatsStreamController =
      StreamController.broadcast();

  Stream<Cat> get favCatsStream => _favCatsStreamController.stream;

  Future<List<Cat>> fetchCatApi({int page = 0, int limit = 10}) async {
    final List<CatModel> cats = [];

    try {
      final apiCats =
          await _catApiProvider.fetchCatApi(page: page, limit: limit);
      final facts =
          await _catFactsProvider.fetchCatFacts(page: page, limit: limit);
      final favCats =
          await _catDatabaseProvider.fetchFavoriteCats(_auth.currentUser!.uid);

      for (int i = 0; i < limit; i++) {
        final dbCat = favCats.findBy(
          (cat) => cat.id == apiCats[i].id,
        );
        final isFavorite = dbCat?.isFavorite ?? false;
        final catModel = CatModel(
          id: apiCats[i].id,
          url: apiCats[i].url,
          fact: facts[i],
          isFavorite: isFavorite,
        );
        cats.add(catModel);
      }
    } catch (e, st) {
      print(e);
      print(st);
      final dbCats = await _catDatabaseProvider.fetchCat();
      return dbCats.map((cat) => cat.toCat()).toList();
    }
    final parsedCats = cats.map((element) {
      return Cat(
        id: element.id,
        url: element.url,
        isFavorite: element.isFavorite,
        fact: element.fact,
      );
    });
    await _catDatabaseProvider.insertAllCats(cats);
    return parsedCats.toList();
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
