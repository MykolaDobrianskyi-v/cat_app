import 'package:equatable/equatable.dart';

class Cat extends Equatable {
  final String id;
  final String url;

  const Cat({
    required this.id,
    required this.url,
  });

  @override
  List<Object?> get props => [id, url];
}
