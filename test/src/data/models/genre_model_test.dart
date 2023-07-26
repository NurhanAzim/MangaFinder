import 'package:flutter_test/flutter_test.dart';
import 'package:manga_finder/src/data/models/genre_model.dart';

void main() {
  group('GenreModel', () {
    Map<String, dynamic> genreModelAsJson = {
      'mal_id': 1,
      'type': 'manga',
      'name': 'Action',
    };

    GenreModel expectedGenreModel =
        GenreModel(malId: 1, type: 'manga', name: 'Action');

    test(
        'Test GenreModel fromJson',
        () =>
            expect(GenreModel.fromJson(genreModelAsJson), expectedGenreModel));
  });
}
