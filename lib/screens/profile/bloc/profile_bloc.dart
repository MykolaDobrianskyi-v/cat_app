import 'package:bloc/bloc.dart';
import 'package:cat_app/models/user_model.dart';
import 'package:cat_app/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserRepository _userRepository;
  ProfileBloc({required UserRepository userRepository, UserModel? user})
      : _userRepository = userRepository,
        super(const ProfileState()) {
    on<ProfileEvent>((event, emit) {});
    on<OnInit>(_onInit);
    add(OnInit(user: user));
  }

  Future<void> _onInit(OnInit event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(isLoading: true));
    final user = await _userRepository.fetchUserProfile();
    emit(state.copyWith(
      user: user,
      isLoading: false,
    ));
  }
}
