import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manga_finder/src/blocs/bloc_constants.dart';
import 'package:manga_finder/src/blocs/library_mangas/library_manga_event.dart';
import 'package:manga_finder/src/blocs/library_mangas/library_manga_state.dart';
import 'package:manga_finder/src/utils/services/database_service.dart';
import 'package:stream_transform/stream_transform.dart';

const throttleDuration = Duration(microseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class LibraryMangaBloc extends Bloc<LibraryMangaEvent, LibraryMangaState> {
  final DatabaseService _databaseService;

  LibraryMangaBloc(this._databaseService) : super(const LibraryMangaState()) {
    on<LibraryMangaInitialEvent>(_libraryMangaInitialEvent);
    on<LibraryMangaAddMangaEvent>(_libraryMangaAddMangaEvent,
        transformer: throttleDroppable(throttleDuration));
    on<LibraryMangaRemoveMangaEvent>(_libraryMangaRemoveMangaEvent,
        transformer: throttleDroppable(throttleDuration));
  }

  /// Handles the initial event for the library manga.
  FutureOr<void> _libraryMangaInitialEvent(
      LibraryMangaInitialEvent event, Emitter<LibraryMangaState> emit) async {
    if (state.status == StateStatus.initial) {
      final mangaStream = _databaseService.mangaStream();

      mangaStream.listen((mangas) {
        if (mangas.isEmpty) {
          return emit(const LibraryMangaState()
              .copyWith(status: StateStatus.success, mangas: []));
        } else {
          return emit(const LibraryMangaState()
              .copyWith(status: StateStatus.success, mangas: mangas));
        }
      }, onError: (error) {
        return emit(const LibraryMangaState()
            .copyWith(status: StateStatus.failure, error: error.toString()));
      });
    }
  }

  FutureOr<void> _libraryMangaAddMangaEvent(
      LibraryMangaAddMangaEvent event, Emitter<LibraryMangaState> emit) async {
    if (state.status == StateStatus.success) {
      try {
        await _databaseService.addManga(manga: event.manga);
        emit(const LibraryMangaState()
            .copyWith(status: StateStatus.success, mangas: state.mangas));
      } catch (e) {
        emit(const LibraryMangaState()
            .copyWith(status: StateStatus.failure, error: e.toString()));
      }
    }
  }

  FutureOr<void> _libraryMangaRemoveMangaEvent(
      LibraryMangaRemoveMangaEvent event,
      Emitter<LibraryMangaState> emit) async {
    if (state.status == StateStatus.success) {
      try {
        await _databaseService.deleteManga(event.manga.malId);
        emit(const LibraryMangaState()
            .copyWith(status: StateStatus.success, mangas: state.mangas));
      } catch (e) {
        emit(const LibraryMangaState()
            .copyWith(status: StateStatus.failure, error: e.toString()));
      }
    }
  }
}
