import 'package:cat_app/models/cat.dart';
import 'package:equatable/equatable.dart';

class CatDbModel extends Equatable {
  final String id;
  final String url;
  final String fact;

  const CatDbModel({
    required this.id,
    required this.url,
    required this.fact,
  });

  CatDbModel.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          url: json['url'],
          fact: json['fact'],
        );
  Map<String, dynamic> toJson() => {
        'id': id,
        'url': url,
        'fact': fact,
      };
  Cat toCat(bool isFavorite) => Cat(
        id: id,
        url: url,
        isFavorite: isFavorite,
        fact: fact,
      );
  @override
  List<Object?> get props => [id, url, fact];
}
