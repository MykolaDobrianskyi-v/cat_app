part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class OnInit extends ProfileEvent {
  final UserModel? user;

  const OnInit({this.user});
  @override
  List<Object?> get props => [user];
}
