import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cat_app/models/cat.dart';
import 'package:cat_app/repositories/cat_repository.dart';
import 'package:equatable/equatable.dart';

part 'cat_detail_event.dart';
part 'cat_detail_state.dart';

class CatDetailBloc extends Bloc<CatDetailEvent, CatDetailState> {
  final CatRepository _catRepository;
  CatDetailBloc({required CatRepository catRepository, required Cat cat})
      : _catRepository = catRepository,
        super(CatDetailState(cat: cat)) {
    on<CatDetailEvent>((event, emit) {});
    on<OnUpdatedCatDetail>(_onUpdatedCatDetail);
    _init();
  }

  void _onUpdatedCatDetail(
      OnUpdatedCatDetail event, Emitter<CatDetailState> emit) {
    if (event.cat.id == state.cat.id) {
      emit(state.copyWith(cat: event.cat));
    }
  }

  late final StreamSubscription streamSubscription;

  void _init() {
    streamSubscription = _catRepository.favCatsStream.listen((cat) {
      add(OnUpdatedCatDetail(cat: cat));
    });
  }

  @override
  Future<void> close() async {
    await streamSubscription.cancel();
    return super.close();
  }
}
