import 'package:dio/dio.dart';
import 'package:manga_finder/src/data/core/api_constants.dart';
import 'package:manga_finder/src/data/core/dio_exceptions.dart';

class DioClient {
  late Dio _dio;

  DioClient() {
    BaseOptions options = BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 20 * 1000,
      receiveTimeout: 20 * 1000,
    );

    _dio = Dio(options);
  }

  Future<dynamic> get({required int page, required String path}) async {
    try {
      final response = await _dio.get(
        '${ApiConstants.baseUrl}/$path/manga',
        queryParameters: {
          'page': page,
          'sfw': true,
        },
      );
      return response;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<dynamic> getDetails({required int id}) async {
    try {
      final response = await _dio.get('${ApiConstants.baseUrl}/manga/$id');
      return response;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<dynamic> getPictures({required int id}) async {
    try {
      final response =
          await _dio.get('${ApiConstants.baseUrl}/manga/$id/pictures');
      return response;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<dynamic> getCharacters({required int id}) async {
    try {
      final response =
          await _dio.get('${ApiConstants.baseUrl}/manga/$id/characters');
      return response;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<dynamic> search({required String query}) async {
    try {
      final response =
          await _dio.get('${ApiConstants.baseUrl}/manga', queryParameters: {
        'q': query,
        'order_by': 'title',
        'sort': 'asc',
        'sfw': 'true',
      });
      return response;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
}
