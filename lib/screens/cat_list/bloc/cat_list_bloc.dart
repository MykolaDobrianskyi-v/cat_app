import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cat_app/helper/network_helper.dart';
import 'package:cat_app/models/cat.dart';

import 'package:cat_app/repositories/cat_repository.dart';
import 'package:equatable/equatable.dart';

part 'cat_list_event.dart';
part 'cat_list_state.dart';

class CatListBloc extends Bloc<CatListEvent, CatListState> {
  final CatRepository _catRepository;
  final NetworkHelper _networkHelper;

  CatListBloc({
    required CatRepository catRepository,
    required NetworkHelper networkHelper,
  })  : _catRepository = catRepository,
        _networkHelper = networkHelper,
        super(const CatListState()) {
    on<CatListEvent>((event, emit) {});
    on<OnInit>(_onInit);
    on<OnLoadMore>(_onLoadMore);
    on<OnToggleFavorite>(_onToggleFavorite);
    on<OnCatChanged>(_onUpdatedFavoriteCats);
    add(OnInit());
    _init();
  }
  late final StreamSubscription _streamSubscription;

  @override
  Future<void> close() async {
    await _streamSubscription.cancel();
    return super.close();
  }

  void _init() {
    _streamSubscription = _catRepository.favCatsStream.listen((cats) {
      add(OnCatChanged(cat: cats));
    });
  }

  void _onInit(OnInit event, Emitter<CatListState> emit) async {
    emit(
      state.copyWith(
        isLoading: true,
      ),
    );
    final isOnline = await _networkHelper.hasInternet();
    final cats = await _catRepository.fetchCatApi();
    emit(state.copyWith(cats: cats, isLoading: false, isOffline: !isOnline));
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

  void _onToggleFavorite(
      OnToggleFavorite event, Emitter<CatListState> emit) async {
    await _catRepository.toggleFavorite(event.cat);
  }

  void _onUpdatedFavoriteCats(OnCatChanged event, Emitter<CatListState> emit) {
    final updatedCats = state.cats.map((cat) {
      if (cat.id == event.cat.id) {
        return event.cat;
      }
      return cat;
    }).toList();

    emit(state.copyWith(cats: updatedCats));
  }
}
