import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String? image;
  final String username;
  final String email;

  const UserModel({
    required this.id,
    required this.image,
    required this.username,
    required this.email,
  });

  UserModel.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          image: json['image'],
          username: json['username'],
          email: json['email'],
        );

  Map<String, dynamic> toJson() => {
        'id': id,
        'image': image,
        'username': username,
        'email': email,
      };

  @override
  List<Object?> get props => [
        id,
        image,
        username,
        email,
      ];
}
