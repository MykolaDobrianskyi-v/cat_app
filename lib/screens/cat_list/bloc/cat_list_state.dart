part of 'cat_list_bloc.dart';

class CatListState extends Equatable {
  final Cat? cat;
  final String? userId;
  final int page;
  final List<Cat> cats;
  final List<Cat> favCats;
  final String? imageUrl;
  final bool? isLoading;
  final bool? isLoadingMore;
  const CatListState({
    this.cat,
    this.userId,
    this.imageUrl,
    this.isLoading,
    this.cats = const [],
    this.favCats = const [],
    this.page = 0,
    this.isLoadingMore,
  });

  CatListState copyWith({
    Cat? cat,
    String? userId,
    String? imageUrl,
    bool? isLoading,
    List<Cat>? cats,
    int? page,
    bool? isLoadingMore,
    List<Cat>? favCats,
  }) {
    return CatListState(
      cat: cat ?? this.cat,
      userId: userId ?? this.userId,
      imageUrl: imageUrl ?? this.imageUrl,
      isLoading: isLoading ?? this.isLoading,
      cats: cats ?? this.cats,
      page: page ?? this.page,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      favCats: favCats ?? this.favCats,
    );
  }

  @override
  List<Object?> get props =>
      [imageUrl, isLoading, cats, page, isLoadingMore, favCats, userId];
}
