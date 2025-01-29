part of 'favorite_cats_bloc.dart';

class FavoriteCatsState extends Equatable {
  final List<Cat> favCats;

  final bool? isLoading;

  const FavoriteCatsState({
    this.favCats = const [],
    this.isLoading,
  });

  FavoriteCatsState copyWith({
    List<Cat>? favCats,
    bool? isLoading,
  }) {
    return FavoriteCatsState(
      favCats: favCats ?? this.favCats,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [
        favCats,
        isLoading,
      ];
}
