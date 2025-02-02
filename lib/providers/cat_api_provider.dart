import 'package:cat_app/client/dio_client.dart';
import 'package:cat_app/models/cat_api_model.dart';

class CatApiProvider {
  final CatApiClient _dio;

  CatApiProvider({
    required CatApiClient dio,
  }) : _dio = dio;

  Future<List<CatApiModel>> fetchCatApi(
      {int page = 0, required int limit}) async {
    final response = await _dio.get(
      '/images/search',
      queryParameters: {
        'limit': limit,
        'has_breeds': true,
        'page': page,
      },
    );

    if (response.statusCode == 200) {
      final data = List<Map<String, dynamic>>.from(response.data);

      return data.map((json) {
        return CatApiModel.fromJson(json);
      }).toList();
    } else {
      throw Exception('Failed to load cats: ${response.statusCode}');
    }
  }
}
