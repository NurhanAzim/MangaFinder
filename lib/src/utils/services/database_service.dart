import 'package:manga_finder/src/data/models/library_manga_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DatabaseService {
  SupabaseClient client = Supabase.instance.client;

  // Future<bool> checkManga(int malId, String userId) async {
  //   try {
  //     final response = await client
  //         .from('library_mangas')
  //         .select()
  //         .eq('manga_id', malId)
  //         .eq('user_id', userId)
  //         .single();

  //     return response != null;
  //   } on PostgrestException catch (_) {
  //     rethrow;
  //   }
  // }

  Future<void> addManga({required LibraryManga manga}) async {
    try {
      await client.from('library_mangas').insert(manga.toJson());
    } on PostgrestException catch (e) {
      if (e.message.contains('unique constraint')) {
        throw 'Manga already in library';
      } else {
        throw 'Someething went wrong';
      }
    }
  }

  Future<void> deleteManga(int malId) async {
    await client.from('library_mangas').delete().match({'manga_id': malId});
  }

  // Future<void> toggleLibraryButton(
  //     {required LibraryManga manga, required String userId}) async {
  //   try {
  //     final mangaExists = await checkManga(manga.malId, userId);

  //     if (mangaExists) {
  //       await deleteManga(manga.malId);
  //     } else {
  //       await addManga(manga: manga);
  //     }
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  Stream<List<LibraryManga>> mangaStream() {
    String userId = client.auth.currentUser!.id;
    try {
      return client
          .from('library_mangas')
          .stream(primaryKey: ['manga_id'])
          .eq('user_id', userId)
          .map((response) =>
              response.map((json) => LibraryManga.fromJson(json)).toList());
    } on PostgrestException catch (e) {
      throw e.message;
    }
  }

  Future<void> deleteAllMangas() async {
    await client.from('library_mangas').delete().neq('user_id', 0);
  }
}
