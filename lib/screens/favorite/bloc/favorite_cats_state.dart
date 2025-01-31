part of 'favorite_cats_bloc.dart';

class FavoriteCatsState extends Equatable {
  final List<Cat> favCats;
  final bool isFavorite;

  final bool isLoading;

  const FavoriteCatsState({
    this.isFavorite = false,
    this.favCats = const [],
    this.isLoading = false,
  });

  FavoriteCatsState copyWith({
    bool? isFavorite,
    List<Cat>? favCats,
    bool? isLoading,
  }) {
    return FavoriteCatsState(
      favCats: favCats ?? this.favCats,
      isLoading: isLoading ?? this.isLoading,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  List<Object?> get props => [
        favCats,
        isLoading,
        isFavorite,
      ];
}
