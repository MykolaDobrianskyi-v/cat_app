import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cat_app/models/cat.dart';
import 'package:cat_app/repositories/cat_repository.dart';
import 'package:equatable/equatable.dart';

part 'favorite_cats_event.dart';
part 'favorite_cats_state.dart';

class FavoriteCatsBloc extends Bloc<FavoriteCatsEvent, FavoriteCatsState> {
  final CatRepository _catRepository;

  FavoriteCatsBloc({
    required CatRepository catRepository,
  })  : _catRepository = catRepository,
        super(const FavoriteCatsState()) {
    on<OnToggleFavorite>(_onToggleFavorite);
    on<OnInit>(_onInit);
    on<OnUpdatedFavoriteCat>(_onUpdatedFavoriteCats);

    add(OnInit());
    _init();
  }

  late final StreamSubscription _streamSubscription;

  void _init() {
    _streamSubscription = _catRepository.favCatsStream.listen((favCat) {
      add(OnUpdatedFavoriteCat(favCat: favCat));
    });
  }

  @override
  Future<void> close() async {
    await _streamSubscription.cancel();
    return super.close();
  }

  void _onToggleFavorite(
      OnToggleFavorite event, Emitter<FavoriteCatsState> emit) async {
    await _catRepository.toggleFavorite(event.cat);
  }

  Future<void> _onInit(OnInit event, Emitter<FavoriteCatsState> emit) async {
    emit(state.copyWith(isLoading: true));
    final cats = await _catRepository.fetchFavoriteCats();

    emit(state.copyWith(
      favCats: cats,
      isLoading: false,
    ));
  }

  void _onUpdatedFavoriteCats(
      OnUpdatedFavoriteCat event, Emitter<FavoriteCatsState> emit) {
    print('STARTED! ${event.favCat}');
    List<Cat> updatedCats = [...state.favCats];
    if (event.favCat.isFavorite) {
      for (int index = 0; index < state.favCats.length; index++) {
        if (state.favCats[index].id == event.favCat.id) {
          print('IS LIKED');
          updatedCats[index] = event.favCat;
          return;
        }
      }
      updatedCats.add(event.favCat);
    } else {
      for (final cat in state.favCats) {
        if (cat.id == event.favCat.id) {
          updatedCats.removeWhere((cat) => cat.id == event.favCat.id);
          break;
        }
      }
    }
    print('UPADATED CATS:  ${updatedCats}');
    print('STATE CATS === ${state.favCats == updatedCats}');

    emit(state.copyWith(favCats: updatedCats));
  }
}
