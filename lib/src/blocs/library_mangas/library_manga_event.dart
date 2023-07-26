import 'package:equatable/equatable.dart';
import 'package:manga_finder/src/data/models/library_manga_model.dart';

abstract class LibraryMangaEvent extends Equatable {
  const LibraryMangaEvent();

  @override
  List<Object?> get props => [];
}

class LibraryMangaInitialEvent extends LibraryMangaEvent {}

class LibraryMangaAddMangaEvent extends LibraryMangaEvent {
  final LibraryManga manga;

  const LibraryMangaAddMangaEvent(this.manga);
  @override
  List<Object?> get props => [manga];
}

class LibraryMangaRemoveMangaEvent extends LibraryMangaEvent {
  final LibraryManga manga;

  const LibraryMangaRemoveMangaEvent(this.manga);
  @override
  List<Object?> get props => [manga];
}
