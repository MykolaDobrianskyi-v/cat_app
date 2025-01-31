import 'package:cat_app/models/cat.dart';
import 'package:equatable/equatable.dart';

class CatModel extends Equatable {
  final String id;
  final String url;
  final bool isFavorite;

  const CatModel({
    required this.id,
    required this.url,
    required this.isFavorite,
  });

  CatModel.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          url: json['url'],
          isFavorite: json['isFavorite'] == 1,
        );

  Map<String, dynamic> toJson() => {
        'id': id,
        'url': url,
        'isFavorite': isFavorite ? 1 : 0,
      };
  Cat toCat() => Cat(
        id: id,
        url: url,
        isFavorite: isFavorite,
      );
  @override
  List<Object?> get props => [id, url, isFavorite];
}
