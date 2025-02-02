import 'package:cat_app/models/cat.dart';
import 'package:equatable/equatable.dart';

class CatModel extends Equatable {
  final String id;
  final String url;
  final bool isFavorite;
  final String fact;

  const CatModel({
    required this.id,
    required this.url,
    required this.isFavorite,
    required this.fact,
  });

  CatModel.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          url: json['url'],
          isFavorite: json['isFavorite'] == 1,
          fact: json['fact'],
        );

  Map<String, dynamic> toJson() => {
        'id': id,
        'url': url,
        'isFavorite': isFavorite ? 1 : 0,
        'fact': fact,
      };
  Cat toCat() => Cat(
        id: id,
        url: url,
        isFavorite: isFavorite,
        fact: fact,
      );
  @override
  List<Object?> get props => [id, url, isFavorite, fact];
}
