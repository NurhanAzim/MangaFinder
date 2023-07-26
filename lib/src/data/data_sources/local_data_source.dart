import 'dart:convert';
import 'package:hive/hive.dart';

import '../models/manga_model.dart';

// Constants for cache keys
const String cachedPopularMangas = 'CACHED_POPULAR';
const String cachedTrendingMangas = 'CACHED_TRENDING';
const String cachedRandomMangas = 'CACHED_RANDOM';

// Hive box name
const String hiveBox = 'MY_MANGA_BOX';

// Abstract class representing the local data source contract
abstract class LocalDataSource {
  Future<void> cache(
      {required String key,
      required List<MangaModel> mangas,
      required int page});
  Future<List<MangaModel>> get({required String key, required int page});
}

// Implementation of the local data source using Hive
class LocalDataSourceImpl implements LocalDataSource {
  @override
  Future<void> cache(
      {required String key,
      required List<MangaModel> mangas,
      required int page}) async {
    // Only cache data if it's the first page (page == 1)
    if (page == 1) {
      final mangaBox = await Hive.openBox(hiveBox);
      // Convert MangaModel list to JSON and save it in the Hive box with the given key
      return mangaBox.put(
          key, json.encode(mangas.map((e) => e.toJson()).toList()));
    }
  }

  @override
  Future<List<MangaModel>> get({required String key, required int page}) async {
    // Only retrieve data if it's the first page (page == 1)
    if (page == 1) {
      final mangaBox = await Hive.openBox(hiveBox);
      final cachedMangas = mangaBox.get(key);
      if (cachedMangas != null) {
        // Decode JSON and convert it back to a list of MangaModel objects
        return json
            .decode(cachedMangas)
            .map<MangaModel>((e) => MangaModel.fromJson(e))
            .toList();
      } else {
        // If there's no cached data for the given key, throw an error
        throw 'Empty Cache!';
      }
    } else {
      // For pages other than the first page, return an empty list
      return <MangaModel>[];
    }
  }
}
