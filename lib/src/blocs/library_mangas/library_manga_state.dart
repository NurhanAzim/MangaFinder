import 'package:equatable/equatable.dart';
import 'package:manga_finder/src/blocs/bloc_constants.dart';
import 'package:manga_finder/src/data/models/library_manga_model.dart';

class LibraryMangaState extends Equatable {
  const LibraryMangaState(
      {this.status = StateStatus.initial,
      this.mangas = const <LibraryManga>[],
      this.error = ''});

  final StateStatus status;
  final List<LibraryManga> mangas;
  final String error;

  LibraryMangaState copyWith(
      {StateStatus? status, List<LibraryManga>? mangas, String? error}) {
    return LibraryMangaState(
      status: status ?? this.status,
      mangas: mangas ?? this.mangas,
      error: error ?? this.error,
    );
  }

  @override
  String toString() {
    return '''LibraryMangaState {status: $status, mangas: $mangas, error: $error}''';
  }

  @override
  List<Object> get props => [status, mangas, error];
}
