part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
  @override
  List<Object?> get props => [];
}

class OnLoginWithGoogle extends LoginEvent {
  const OnLoginWithGoogle();

  @override
  List<Object?> get props => [];
}

class OnLoginWithFacebook extends LoginEvent {
  const OnLoginWithFacebook();

  @override
  List<Object?> get props => [];
}

class OnSignOut extends LoginEvent {}
