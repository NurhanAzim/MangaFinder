import 'package:manga_finder/src/data/core/dio_client.dart';
import 'package:manga_finder/src/data/models/character_model.dart';
import 'package:manga_finder/src/data/models/manga_details_model.dart';
import 'package:manga_finder/src/data/models/manga_model.dart';

abstract class RemoteDataSource {
  Future<List<MangaModel>> getPopular({required int page});
  Future<List<MangaModel>> getTrending({required int page});
  Future<List<MangaModel>> getRandom({required int page});
  Future<List<MangaModel>> getSearchedManga({required String query});
  Future<MangaDetailsModel> getMangaDetails({required int id});
  Future<List<CharacterModel>> getCharacters({required int id});
  Future<List<dynamic>> getImages({required int id});
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final DioClient _dioClient;

  RemoteDataSourceImpl(this._dioClient);

  @override
  Future<List<MangaModel>> getPopular({required int page}) async {
    try {
      final response = await _dioClient.get(page: page, path: 'top');
      final mangas = response.data['data']
          .map<MangaModel>((json) => MangaModel.fromPopularJson(json))
          .toList();
      return mangas;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<MangaModel>> getTrending({required int page}) async {
    try {
      final response =
          await _dioClient.get(page: page, path: 'recommendations');
      final mangas = response.data['data']
          .map<MangaModel>((json) => MangaModel.fromTrendingJson(json))
          .toList();
      return mangas;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<MangaModel>> getRandom({required int page}) async {
    try {
      final List<MangaModel> mangas = [];

      for (int i = 0; i < 5; i++) {
        final response = await _dioClient.get(page: page, path: 'random');
        final manga = MangaModel.fromRandomJson(response.data['data']);
        mangas.add(manga);
      }

      return mangas;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<MangaModel>> getSearchedManga({required String query}) async {
    try {
      final response = await _dioClient.search(query: query);
      final mangas = response.data['data']
          .map<MangaModel>((json) => MangaModel.fromJson(json))
          .toList();
      return mangas;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<MangaDetailsModel> getMangaDetails({required int id}) async {
    try {
      final response = await _dioClient.getDetails(id: id);
      final mangas = MangaDetailsModel.fromMap(response.data['data']);
      print('manga info: ${mangas.malId}');
      return mangas;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<dynamic>> getImages({required int id}) async {
    try {
      final response = await _dioClient.getPictures(id: id);
      final images = response.data['data'];

      return images;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<List<CharacterModel>> getCharacters({required int id}) async {
    try {
      final response = await _dioClient.getCharacters(id: id);
      final characters = response.data['data']
          .map<CharacterModel>((json) => CharacterModel.fromJson(json))
          .where((character) => character.role == 'Main')
          // .take(9)
          .toList();

      return characters;
    } catch (e) {
      rethrow;
    }
  }
}
