import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:manga_finder/src/data/data_sources/local_data_source.dart';
import 'package:manga_finder/src/data/data_sources/remote_data_source.dart';
import 'package:manga_finder/src/data/models/character_model.dart';
import 'package:manga_finder/src/data/models/manga_details_model.dart';
import 'package:manga_finder/src/data/models/manga_model.dart';

abstract class MangaRepository {
  Future<List<MangaModel>> getPopular({required int page});
  Future<List<MangaModel>> getTrending({required int page});
  Future<List<MangaModel>> getRandom({required int page});
  Future<List<MangaModel>> getSearchedManga({required String query});
  Future<MangaDetailsModel> getMangaDetails({required int id});
  Future<List<dynamic>> getImages({required int id});
  Future<List<CharacterModel>> getCharacters({required int id});
}

class MangaRepoImpl implements MangaRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
  final InternetConnectionChecker internetConnectionChecker;

  MangaRepoImpl(this.remoteDataSource, this.localDataSource,
      this.internetConnectionChecker);

  @override
  Future<List<MangaModel>> getPopular({required int page}) async {
    try {
      if (await internetConnectionChecker.hasConnection) {
        final mangas = await remoteDataSource.getPopular(page: page);

        await localDataSource.cache(
            key: cachedPopularMangas, mangas: mangas, page: page);
        return mangas;
      } else {
        final cachedMangas =
            await localDataSource.get(key: cachedPopularMangas, page: page);
        return cachedMangas;
      }
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<List<MangaModel>> getTrending({required int page}) async {
    try {
      if (await internetConnectionChecker.hasConnection) {
        final mangas = await remoteDataSource.getTrending(page: page);
        await localDataSource.cache(
            key: cachedTrendingMangas, mangas: mangas, page: page);
        return mangas;
      } else {
        final cachedMangas =
            await localDataSource.get(key: cachedTrendingMangas, page: page);
        return cachedMangas;
      }
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<List<MangaModel>> getRandom({required int page}) async {
    try {
      if (await internetConnectionChecker.hasConnection) {
        final mangas = await remoteDataSource.getRandom(page: page);
        await localDataSource.cache(
            key: cachedRandomMangas, mangas: mangas, page: page);
        return mangas;
      } else {
        final cachedMangas =
            await localDataSource.get(key: cachedRandomMangas, page: page);
        return cachedMangas;
      }
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<List<CharacterModel>> getCharacters({required int id}) async {
    try {
      final characters = await remoteDataSource.getCharacters(id: id);
      return characters;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<List> getImages({required int id}) async {
    try {
      final images = await remoteDataSource.getImages(id: id);
      return images;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<MangaDetailsModel> getMangaDetails({required int id}) async {
    try {
      final mangas = await remoteDataSource.getMangaDetails(id: id);
      return mangas;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<List<MangaModel>> getSearchedManga({required String query}) async {
    try {
      final mangas = await remoteDataSource.getSearchedManga(query: query);
      return mangas;
    } catch (_) {
      rethrow;
    }
  }
}
