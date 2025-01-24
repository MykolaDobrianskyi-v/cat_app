part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class OnChangeTab extends HomeEvent {
  final int tabIndex;

  const OnChangeTab(this.tabIndex);

  @override
  List<Object> get props => [tabIndex];
}
