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
    on<FavoriteCatsEvent>((event, emit) {});
    on<OnAddToFavorite>(_onAddToFavorite);
    on<OnInit>(_onInit);

    add(OnInit());
  }

  void _onAddToFavorite(
      OnAddToFavorite event, Emitter<FavoriteCatsState> emit) {
    emit(state.copyWith(favCats: event.cats));
  }

  void _onInit(OnInit event, Emitter<FavoriteCatsState> emit) async {
    emit(state.copyWith(isLoading: true));
    final cats = await _catRepository.fetchFavoriteCats();
    emit(state.copyWith(
      favCats: cats,
      isLoading: false,
    ));
  }
}
