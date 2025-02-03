part of 'cat_list_bloc.dart';

class CatListState extends Equatable {
  final bool isFavorite;
  final int page;
  final List<Cat> cats;
  final bool isOffline;

  final String? imageUrl;
  final bool? isLoading;
  final bool? isLoadingMore;
  const CatListState({
    this.isFavorite = false,
    this.imageUrl,
    this.isLoading,
    this.cats = const [],
    this.page = 0,
    this.isLoadingMore,
    this.isOffline = false,
  });

  CatListState copyWith({
    bool? isFavorite,
    String? imageUrl,
    bool? isLoading,
    List<Cat>? cats,
    int? page,
    bool? isLoadingMore,
    bool? isOffline,
  }) {
    return CatListState(
      imageUrl: imageUrl ?? this.imageUrl,
      isLoading: isLoading ?? this.isLoading,
      cats: cats ?? this.cats,
      page: page ?? this.page,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      isFavorite: isFavorite ?? this.isFavorite,
      isOffline: isOffline ?? this.isOffline,
    );
  }

  @override
  List<Object?> get props =>
      [imageUrl, isLoading, cats, page, isLoadingMore, isFavorite, isOffline];
}
