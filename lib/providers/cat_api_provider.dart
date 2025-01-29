import 'package:cat_app/client/dio_client.dart';

import 'package:cat_app/models/cat_model.dart';

class CatApiProvider {
  final ApiClient _dio;

  CatApiProvider({
    required ApiClient dio,
  }) : _dio = dio;

  Future<List<CatModel>> fetchCatApi({int page = 0}) async {
    final response = await _dio.get(
      '/images/search',
      queryParameters: {
        'limit': 10,
        'has_breeds': true,
        'page': page,
      },
    );

    if (response.statusCode == 200) {
      final data = List<Map<String, dynamic>>.from(response.data);

      return data.map((json) {
        return CatModel.fromJson(json);
      }).toList();
    } else {
      throw Exception('Failed to load cats: ${response.statusCode}');
    }
  }
}
