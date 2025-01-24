part of 'home_bloc.dart';

class HomeState extends Equatable {
  final int currentIndex;

  const HomeState({
    this.currentIndex = 0,
  });

  @override
  List<Object> get props => [currentIndex];
}
