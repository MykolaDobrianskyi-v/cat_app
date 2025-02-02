import 'package:dio/dio.dart';

abstract class ApiClient {
  final Dio _dio;

  ApiClient({
    required Dio dio,
  }) : _dio = dio;

  Future<Response<T>> get<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
  }) =>
      _dio.get<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );

  Future<Response<T>> post<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  }) =>
      _dio.post<T>(path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress,
          onSendProgress: onSendProgress);
}

class CatApiClient extends ApiClient {
  CatApiClient({required super.dio}) {
    _dio.options = BaseOptions(
      baseUrl: const String.fromEnvironment('catApiUrl'),
      headers: {'x-api-key': const String.fromEnvironment('catApiKey')},
      responseType: ResponseType.json,
    );
  }
}

class CatFactsClient extends ApiClient {
  CatFactsClient({required super.dio}) {
    _dio.options = BaseOptions(
      baseUrl: const String.fromEnvironment('catFactUrl'),
      responseType: ResponseType.json,
    );
  }
}
