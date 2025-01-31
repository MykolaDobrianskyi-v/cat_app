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

class OnCatChanged extends CatListEvent {
  final Cat cat;

  const OnCatChanged({required this.cat});

  @override
  List<Object> get props => [cat];
}

class OnToggleFavorite extends CatListEvent {
  final Cat cat;

  const OnToggleFavorite({required this.cat});

  @override
  List<Object> get props => [cat];
}
