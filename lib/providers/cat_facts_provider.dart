import 'package:cat_app/client/dio_client.dart';

class CatFactsProvider {
  final CatFactsClient _client;

  CatFactsProvider({required CatFactsClient client}) : _client = client;

  Future<List<String>> fetchCatFacts({int page = 0, required int limit}) async {
    final response = await _client
        .get('/facts', queryParameters: {'page': page, 'limit': limit});
    print('RESPONSE ${response.data}');

    return List<Map<String, dynamic>>.from(response.data['data'])
        .map(
          (json) => json['fact'] as String,
        )
        .toList();
  }
}
