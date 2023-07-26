import 'package:flutter_test/flutter_test.dart';
import 'package:manga_finder/src/data/models/library_manga_model.dart';

void main() {
  group('LibraryMangaModel', () {
    Map<String, dynamic> libraryMangaModelAsJson = {
      'manga_id': 2,
      'image_url': 'mock url',
      'title': 'Berserk',
      'synopsis': 'mock synopsis',
      'user_id': 'mock userid',
    };

    LibraryManga expectedLibraryMangaModel = LibraryManga(
        malId: 2,
        imageUrl: 'mock url',
        title: 'Berserk',
        synopsis: 'mock synopsis',
        userId: 'mock userid');

    test(
        'Test LibraryMangaModel fromJson',
        () => expect(LibraryManga.fromJson(libraryMangaModelAsJson),
            expectedLibraryMangaModel));
  });
}
