import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String image;
  final String username;
  final String email;

  const User({
    required this.id,
    required this.image,
    required this.username,
    required this.email,
  });

  @override
  List<Object?> get props => [image, username, email, id];
}
