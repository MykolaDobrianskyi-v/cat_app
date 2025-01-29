import 'package:cat_app/models/cat.dart';
import 'package:equatable/equatable.dart';

class CatModel extends Equatable {
  final String id;
  final String url;

  const CatModel({
    required this.id,
    required this.url,
  });

  CatModel.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          url: json['url'],
        );

  Map<String, dynamic> toJson() => {
        'id': id,
        'url': url,
      };
  Cat toCat() => Cat(id: id, url: url);
  @override
  List<Object?> get props => [id, url];
}
