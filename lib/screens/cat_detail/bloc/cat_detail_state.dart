part of 'cat_detail_bloc.dart';

class CatDetailState extends Equatable {
  final Cat cat;
  final bool? isLoading;

  const CatDetailState({required this.cat, this.isLoading});

  CatDetailState copyWith({
    Cat? cat,
    bool? isLoading,
  }) {
    return CatDetailState(
      cat: cat ?? this.cat,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [cat, isLoading];
}
