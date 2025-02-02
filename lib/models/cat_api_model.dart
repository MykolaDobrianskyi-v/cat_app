import 'package:equatable/equatable.dart';

class CatApiModel extends Equatable {
  final String id;
  final String url;

  const CatApiModel({
    required this.id,
    required this.url,
  });

  CatApiModel.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          url: json['url'],
        );

  @override
  List<Object?> get props => [id, url];
}
