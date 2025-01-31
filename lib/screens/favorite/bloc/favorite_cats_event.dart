part of 'favorite_cats_bloc.dart';

sealed class FavoriteCatsEvent extends Equatable {
  const FavoriteCatsEvent();

  @override
  List<Object> get props => [];
}

class OnToggleFavorite extends FavoriteCatsEvent {
  final Cat cat;

  const OnToggleFavorite({required this.cat});

  @override
  List<Object> get props => [cat];
}

class OnInit extends FavoriteCatsEvent {}

class OnUpdatedFavoriteCat extends FavoriteCatsEvent {
  final Cat favCat;

  const OnUpdatedFavoriteCat({required this.favCat});

  @override
  List<Object> get props => [favCat];
}
