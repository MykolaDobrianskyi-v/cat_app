part of 'cat_detail_bloc.dart';

sealed class CatDetailEvent extends Equatable {
  const CatDetailEvent();

  @override
  List<Object> get props => [];
}

class OnUpdatedCatDetail extends CatDetailEvent {
  final Cat cat;

  const OnUpdatedCatDetail({required this.cat});
  @override
  List<Object> get props => [cat];
}
