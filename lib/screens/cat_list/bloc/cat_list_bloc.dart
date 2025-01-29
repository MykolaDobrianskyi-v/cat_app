import 'package:bloc/bloc.dart';
import 'package:cat_app/models/cat.dart';

import 'package:cat_app/repositories/cat_repository.dart';
import 'package:equatable/equatable.dart';

part 'cat_list_event.dart';
part 'cat_list_state.dart';

class CatListBloc extends Bloc<CatListEvent, CatListState> {
  final CatRepository _catRepository;

  CatListBloc({
    required CatRepository catRepository,
  })  : _catRepository = catRepository,
        super(const CatListState()) {
    on<CatListEvent>((event, emit) {});
    on<OnInit>(_onInit);
    on<OnLoadMore>(_onLoadMore);
    on<OnAddToFavorite>(_onAddToFavorite);
    on<OnUpdatedFavoriteCats>(_onUpdatedFavoriteCats);
    add(OnInit());
  }

  void _onInit(OnInit event, Emitter<CatListState> emit) async {
    emit(
      state.copyWith(
        isLoading: true,
      ),
    );
    final cats = await _catRepository.fetchCatApi();
    emit(state.copyWith(
      cats: cats,
      isLoading: false,
    ));
  }

  Future<void> _onLoadMore(OnLoadMore event, Emitter<CatListState> emit) async {
    if (state.isLoadingMore == false) return;

    emit(
      state.copyWith(
        cats: state.cats,
        isLoadingMore: true,
        page: state.page + 1,
      ),
    );

    final newCats = await _catRepository.fetchCatApi(page: state.page);

    emit(state.copyWith(cats: state.cats + newCats));
  }

  void _onAddToFavorite(OnAddToFavorite event, Emitter<CatListState> emit) {
    print('CATACACATATCATCAAT:    ${event.cat}');
    _catRepository.addToFavorite(event.cat);
  }

  void _onUpdatedFavoriteCats(
      OnUpdatedFavoriteCats event, Emitter<CatListState> emit) {
    emit(
      state.copyWith(favCats: event.cats),
    );
  }
}
