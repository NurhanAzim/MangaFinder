import 'package:flutter_test/flutter_test.dart';
import 'package:manga_finder/src/data/models/genre_model.dart';
import 'package:manga_finder/src/data/models/manga_model.dart';

void main() {
  group('MangaModel', () {
    Map<String, dynamic> mangaModelAsJson = {
      'mal_id': 2,
      'genres': [
        {'malId': 1, 'type': 'manga', 'name': 'Action'}
      ],
      'titles': [
        {'title': 'ONE PIECE'}
      ],
      'images': {
        'jpg': {'image_url': 'mock url'}
      },
      'chapters': 1,
      'status': 'Publishing',
      'synopsis': 'mock synopsis',
      'authors': [
        {'name': 'Oda'}
      ],
    };

    MangaModel expectedMangaModel = MangaModel(
        malId: 2,
        title: 'ONE PIECE',
        imageUrl: 'mock url',
        status: 'Publishing',
        synopsis: 'mock synopsis',
        genres: [GenreModel(malId: 1, type: 'manga', name: 'Action')],
        authors: ['Oda'],
        chapters: 1);

    Map<String, dynamic> trendingMangaModelAsJson = {
      'entry': [
        {
          'mal_id': 2,
          'images': {
            'jpg': {'image_url': 'mock url'}
          },
          'title': 'ONE PIECE'
        }
      ]
    };

    test(
        'Test MangaModel fromJson',
        () =>
            expect(MangaModel.fromJson(mangaModelAsJson), expectedMangaModel));

    test(
        'Test MangaModel fromPopularJson',
        () => expect(
            MangaModel.fromPopularJson(mangaModelAsJson), expectedMangaModel));

    test(
        'Test MangaModel fromTrendingJson',
        () => expect(MangaModel.fromTrendingJson(trendingMangaModelAsJson),
            expectedMangaModel));

    test(
        'Test MangaModel fromRandomJson',
        () => expect(
            MangaModel.fromRandomJson(mangaModelAsJson), expectedMangaModel));

    test('Test MangaModel toJson',
        () => expect(expectedMangaModel.toJson(), mangaModelAsJson));
  });
}
