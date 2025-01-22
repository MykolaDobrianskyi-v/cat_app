import 'package:bloc/bloc.dart';
import 'package:cat_app/repositories/login_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final FirebaseAuth auth;
  final LoginRepository _loginRepository;
  LoginBloc({required this.auth, required LoginRepository loginRepository})
      : _loginRepository = loginRepository,
        super(LoginState()) {
    on<LoginEvent>((event, emit) {});
    on<OnLoginWithGoogle>(_signInWithGoogle);
    on<OnLoginWithFacebook>(_signInWithFacebook);
  }

  Future<void> _signInWithGoogle(
      OnLoginWithGoogle event, Emitter<LoginState> emit) async {
    _loginRepository.signInWithGoogle();
  }

  Future<void> _signInWithFacebook(
      OnLoginWithFacebook event, Emitter<LoginState> emit) async {
    _loginRepository.signInWithFacebook();
  }
}
