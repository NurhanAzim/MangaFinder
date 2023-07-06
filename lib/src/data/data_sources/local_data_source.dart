import 'dart:convert';
import 'package:hive/hive.dart';

import '../models/manga_model.dart';

const String cachedPopularMangas = 'CACHED_POPULAR';
const String cachedTrendingMangas = 'CACHED_TRENDDING';
const String cachedRandomMangas = 'CACHED_RANDOM';
const String hiveBox = 'MY_MANGA_BOX';

abstract class LocalDataSource {
  Future<void> cache(
      {required String key,
      required List<MangaModel> mangas,
      required int page});
  Future<List<MangaModel>> get({required String key, required int page});
}

class LocalDataSourceImpl implements LocalDataSource {
  @override
  Future<void> cache(
      {required String key,
      required List<MangaModel> mangas,
      required int page}) async {
    if (page == 1) {
      final mangaBox = await Hive.openBox(hiveBox);
      return mangaBox.put(
          key, json.encode(mangas.map((e) => e.toJson()).toList()));
    }
  }

  @override
  Future<List<MangaModel>> get({required String key, required int page}) async {
    if (page == 1) {
      final mangaBox = await Hive.openBox(hiveBox);
      final cachedMangas = mangaBox.get(key);
      if (cachedMangas != null) {
        return json
            .decode(cachedMangas)
            .map<MangaModel>((e) => MangaModel.fromJson(e))
            .toList();
      } else {
        throw 'Empty Cache!';
      }
    } else {
      return <MangaModel>[];
    }
  }
}
