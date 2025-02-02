import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<HomeEvent>((event, emit) {});
    on<OnChangeTab>(_onChangeTab);
  }

  void _onChangeTab(OnChangeTab event, Emitter emit) {
    emit(HomeState(currentIndex: event.tabIndex));
  }
}
