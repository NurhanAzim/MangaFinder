import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:manga_finder/src/data/core/dio_client.dart';
import 'package:manga_finder/src/data/data_sources/remote_data_source.dart';
import 'package:manga_finder/src/data/models/manga_model.dart';
import 'package:mockito/mockito.dart';

class MockDioClient extends Mock implements DioClient {}

void main() {
  group('RemoteDataSourceImpl', () {
    late RemoteDataSourceImpl remoteDataSourceImpl;
    late MockDioClient mockDioClient;

    setUp(() {
      mockDioClient = MockDioClient();
      remoteDataSourceImpl = RemoteDataSourceImpl(mockDioClient);
    });

    group('Function getPopular', () {
      const page = 1;
      const path = 'top';
      final response = {
        'data': [
          {
            'mal_id': 1,
            'title': 'Manga 1',
            'image_url': 'https://cdn.myanimelist.net/images/manga/1.jpg',
            'type': 'Manga',
          },
          {
            'mal_id': 2,
            'title': 'Manga 2',
            'image_url': 'https://cdn.myanimelist.net/images/manga/2.jpg',
            'type': 'Manga',
          }
        ]
      };
      test(
          'when getPopular called and status code is 200, returns a list of MangaModel',
          () async {
        // Arrange

        when(mockDioClient.get(page: page, path: path)).thenAnswer((_) async {
          return Response(
              requestOptions: RequestOptions(path: path),
              data: {'data': []},
              statusCode: 200);
        });

        // Act
        final result = await remoteDataSourceImpl.getPopular(page: page);
        // Assert
        expect(result, isA<List<MangaModel>>());
        // verify(mockDioClient.get(page: page, path: path)).called(1);
      });

      test(
          'When getPopular is called and status code is 200, return 2 MangaModel instance',
          () async {
        when((mockDioClient.get(page: page, path: path))).thenAnswer(
            (realInvocation) async => Response(
                requestOptions: RequestOptions(path: path),
                statusCode: 200,
                data: response));
        final result = await remoteDataSourceImpl.getPopular(
          page: page,
        );
        expect(result.length, equals(2));
      });
    });
  });
}
