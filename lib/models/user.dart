import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String image;
  final String username;

  const User({
    required this.image,
    required this.username,
  });

  @override
  List<Object?> get props => [];
}
