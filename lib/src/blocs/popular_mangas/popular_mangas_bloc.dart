import 'dart:async';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manga_finder/src/blocs/popular_mangas/popular_mangas_event.dart';
import 'package:manga_finder/src/blocs/popular_mangas/popular_mangas_state.dart';
import 'package:manga_finder/src/data/repositories/manga_repo_impl.dart';
import 'package:stream_transform/stream_transform.dart';

import '../bloc_constants.dart';

const throttleDuration = Duration(microseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class PopularMangaBloc extends Bloc<PopularMangaEvent, PopularMangaState> {
  final MangaRepository _repo;
  int page = 1;
  int limit = 5;

  PopularMangaBloc(this._repo) : super(const PopularMangaState()) {
    on<PopularMangaInitialEvent>(_popularMangaInitialEvent);
    on<LoadMorePopularMangaEvent>(_loadMorePopularMangaEvent,
        transformer: throttleDroppable(throttleDuration));
  }

  FutureOr<void> _popularMangaInitialEvent(
      PopularMangaInitialEvent event, Emitter<PopularMangaState> emit) async {
    if (state.status == StateStatus.initial) {
      try {
        final mangas = await _repo.getPopular(page: page);

        page = page + 1;
        return emit(const PopularMangaState().copyWith(
          status: StateStatus.success,
          popularMangas: mangas,
          hasReachedMax: false,
        ));
      } catch (e) {
        return emit(const PopularMangaState().copyWith(
          error: e.toString(),
          status: StateStatus.failure,
        ));
      }
    }
  }

  Future<void> _loadMorePopularMangaEvent(
      LoadMorePopularMangaEvent event, Emitter<PopularMangaState> emit) async {
    if (state.hasReachedMax) return;
    if (page <= limit) {
      try {
        final mangas = await _repo.getPopular(page: page);
        page = page + 1;
        return emit(const PopularMangaState().copyWith(
          status: StateStatus.success,
          popularMangas: List.of(state.popularMangas)..addAll(mangas),
          hasReachedMax: false,
        ));
      } catch (e) {
        return emit(const PopularMangaState().copyWith(
          status: StateStatus.failure,
          error: e.toString(),
        ));
      }
    }

    emit(state.copyWith(hasReachedMax: true));
  }
}
