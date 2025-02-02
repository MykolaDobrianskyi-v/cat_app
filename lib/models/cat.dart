import 'package:equatable/equatable.dart';

class Cat extends Equatable {
  final String id;
  final String url;
  final bool isFavorite;
  final String fact;

  const Cat({
    required this.id,
    required this.url,
    required this.isFavorite,
    required this.fact,
  });
  Cat copyWith({String? id, String? url, bool? isFavorite, String? fact}) {
    return Cat(
      id: id ?? this.id,
      url: url ?? this.url,
      isFavorite: isFavorite ?? this.isFavorite,
      fact: fact ?? this.fact,
    );
  }

  @override
  List<Object?> get props => [id, url, isFavorite, fact];
}
