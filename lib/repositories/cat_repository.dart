import 'dart:async';

import 'package:cat_app/extensions/iterable_extension.dart';
import 'package:cat_app/helper/network_helper.dart';
import 'package:cat_app/models/cat.dart';
import 'package:cat_app/models/cat_db_model.dart';
import 'package:cat_app/models/cat_model.dart';

import 'package:cat_app/providers/cat_api_provider.dart';
import 'package:cat_app/providers/cat_database_provider.dart';
import 'package:cat_app/providers/cat_facts_provider.dart';
import 'package:cat_app/repositories/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CatRepository {
  final CatApiProvider _catApiProvider;
  final CatDatabaseProvider _catDatabaseProvider;
  final FirebaseAuth _auth;
  final CatFactsProvider _catFactsProvider;
  final NetworkHelper _networkHelper;
  final UserRepository _userRepository;

  CatRepository({
    required CatApiProvider catApiProvider,
    required FirebaseAuth auth,
    required CatDatabaseProvider catDatabaseProvider,
    required CatFactsProvider catFactsProvider,
    required NetworkHelper networkHelper,
    required UserRepository userRepository,
  })  : _catApiProvider = catApiProvider,
        _catDatabaseProvider = catDatabaseProvider,
        _auth = auth,
        _catFactsProvider = catFactsProvider,
        _networkHelper = networkHelper,
        _userRepository = userRepository;

  final StreamController<Cat> _favCatsStreamController =
      StreamController.broadcast();

  Stream<Cat> get favCatsStream => _favCatsStreamController.stream;

  void catModel() {}

  Future<List<Cat>> fetchCatApi({int page = 0, int limit = 10}) async {
    final List<CatModel> cats = [];
    //final isOnline = await _networkHelper.hasInternet();

    // if (!isOnline) {
    //   final dbCats = await _catDatabaseProvider.fetchCat();
    //   if (dbCats.isNotEmpty) {
    //     return dbCats.map((cat) => cat.toCat()).toList();
    //   } else {
    //     return [];
    //   }
    // }
    final List<CatModel> favCats = [];
    try {
      final favCats =
          await _catDatabaseProvider.fetchFavoriteCats(_auth.currentUser!.uid);
      final apiCats =
          await _catApiProvider.fetchCatApi(page: page, limit: limit);
      final facts =
          await _catFactsProvider.fetchCatFacts(page: page, limit: limit);

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
    } catch (e) {
      final favCats =
          await _catDatabaseProvider.fetchFavoriteCats(_auth.currentUser!.uid);
      final dbCats = await _catDatabaseProvider.fetchCat();
      for (int i = 0; i < limit; i++) {
        final favCat = favCats.findBy(
          (cat) => cat.id == dbCats[i].id,
        );
        final isFavorite = favCat?.isFavorite ?? false;

        final catModel = CatModel(
          id: dbCats[i].id,
          url: dbCats[i].url,
          fact: dbCats[i].fact,
          isFavorite: isFavorite,
        );
        cats.add(catModel);
      }
      final parsedCats = cats.map((element) {
        return Cat(
          id: element.id,
          url: element.url,
          isFavorite: element.isFavorite,
          fact: element.fact,
        );
      }).toList();
      return parsedCats;
    }
    final parsedCats = cats.map((element) {
      return Cat(
        id: element.id,
        url: element.url,
        isFavorite: element.isFavorite,
        fact: element.fact,
      );
    });
    final parsedDbCats = cats
        .map((cat) => CatDbModel(id: cat.id, url: cat.url, fact: cat.fact))
        .toList();

    await _catDatabaseProvider.insertAllCats(parsedDbCats);
    return parsedCats.toList();
  }

  Future<List<Cat>> fetchFavoriteCats() async {
    if (_auth.currentUser?.uid == null) {
      return [];
    }
    final favCats =
        await _catDatabaseProvider.fetchFavoriteCats(_auth.currentUser!.uid);
    final asyncFavCats = favCats.map((catModel) async {
      return catModel.toCat();
    });
    return await Future.wait(asyncFavCats);
  }

  Future<void> toggleFavorite(Cat cat) async {
    print('CAT : ${cat}');

    if (_auth.currentUser?.uid == null) {
      return;
    }

    final bool exists =
        await _catDatabaseProvider.isFavorite(_auth.currentUser!.uid, cat.id);

    if (exists) {
      await _catDatabaseProvider.removeFromFavorites(
          _auth.currentUser!.uid, cat.id);
    } else {
      await _catDatabaseProvider.addToFavorite(_auth.currentUser!.uid, cat);
    }
    _favCatsStreamController.add(cat.copyWith(isFavorite: !cat.isFavorite));
  }
}
