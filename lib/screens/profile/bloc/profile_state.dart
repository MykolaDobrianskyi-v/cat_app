part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  final UserModel? user;
  final bool isLoading;

  const ProfileState({this.user, this.isLoading = false});
  ProfileState copyWith({
    UserModel? user,
    bool? isLoading,
  }) {
    return ProfileState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [user, isLoading];
}
