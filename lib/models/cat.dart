import 'package:equatable/equatable.dart';

class Cat extends Equatable {
  final String id;
  final String url;
  final bool isFavorite;

  const Cat({
    required this.id,
    required this.url,
    required this.isFavorite,
  });
  Cat copyWith({
    String? id,
    String? url,
    bool? isFavorite,
  }) {
    return Cat(
      id: id ?? this.id,
      url: url ?? this.url,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  List<Object?> get props => [id, url, isFavorite];
}
