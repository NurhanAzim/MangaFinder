import 'package:flutter_test/flutter_test.dart';
import 'package:manga_finder/src/data/models/genre_model.dart';
import 'package:manga_finder/src/data/models/manga_details_model.dart';

void main() {
  group('MangaDetailsModel', () {
    Map<String, dynamic> mangaDetailsModelAsJson = {
      'mal_id': 13,
      'images': {
        'jpg': {
          'large_image_url': 'https:cdn.myanimelist.netimagesmanga2253146l.jpg'
        },
        'titles': [
          {'title': 'ONE PIECE'}
        ],
        'status': 'Publishing',
        'synopsis': 'mock synopsis',
        'genres': [
          {'mal_id': 1, 'type': 'manga', 'name': 'Action'}
        ]
      }
    };

    MangaDetailsModel expectedMangaDetailsModel = MangaDetailsModel(
        malId: 13,
        status: 'Publishing',
        title: 'ONE PIECE',
        synopsis: 'mock synopsis',
        imageUrl: 'https:cdn.myanimelist.netimagesmanga2253146l.jpg',
        genres: [GenreModel(malId: 1, type: 'manga', name: 'Action')]);

    test(
        'Test MangaDetailsModel fromJson',
        () => expect(MangaDetailsModel.fromMap(mangaDetailsModelAsJson),
            expectedMangaDetailsModel));
  });
}
