part of 'cat_list_bloc.dart';

sealed class CatListEvent extends Equatable {
  const CatListEvent();

  @override
  List<Object?> get props => [];
}

class OnInit extends CatListEvent {}

class OnLoadMore extends CatListEvent {}

class OnAddToFavorite extends CatListEvent {
  final Cat cat;

  const OnAddToFavorite({
    required this.cat,
  });

  @override
  List<Object?> get props => [cat];
}

class OnUpdatedFavoriteCats extends CatListEvent {
  final List<Cat> cats;

  const OnUpdatedFavoriteCats({required this.cats});

  @override
  List<Object> get props => [cats];
}
