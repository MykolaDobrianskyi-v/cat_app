part of 'favorite_cats_bloc.dart';

sealed class FavoriteCatsEvent extends Equatable {
  const FavoriteCatsEvent();

  @override
  List<Object> get props => [];
}

class OnAddToFavorite extends FavoriteCatsEvent {
  final List<Cat> cats;

  const OnAddToFavorite({required this.cats});

  @override
  List<Object> get props => [cats];
}

class OnInit extends FavoriteCatsEvent {}
