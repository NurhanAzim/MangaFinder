import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manga_finder/src/blocs/bloc_constants.dart';
import 'package:manga_finder/src/data/models/manga_model.dart';
import 'package:manga_finder/src/data/repositories/manga_repo_impl.dart';
import 'package:stream_transform/stream_transform.dart';

part 'trending_mangas_event.dart';
part 'trending_mangas_state.dart';

const throttleDuration = Duration(microseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class TrendingMangaBloc extends Bloc<TrendingMangaEvent, TrendingMangaState> {
  final MangaRepository _repo;
  int page = 1;
  int limit = 5;

  TrendingMangaBloc(this._repo) : super(const TrendingMangaState()) {
    on<TrendingMangaInitialEvent>(_trendingMangaInitialEvent);
    on<LoadMoreTrendingMangaEvent>(_loadTrendingMangaEvent,
        transformer: throttleDroppable(throttleDuration));
  }

  FutureOr<void> _trendingMangaInitialEvent(
      TrendingMangaInitialEvent event, Emitter<TrendingMangaState> emit) async {
    if (state.status == StateStatus.initial) {
      try {
        final mangas = await _repo.getTrending(page: page);

        page = page + 1;
        return emit(const TrendingMangaState().copyWith(
          status: StateStatus.success,
          trendingMangas: mangas,
          hasReachedMax: false,
        ));
      } catch (e) {
        return emit(const TrendingMangaState().copyWith(
          error: e.toString(),
          status: StateStatus.failure,
        ));
      }
    }
  }

  FutureOr<void> _loadTrendingMangaEvent(LoadMoreTrendingMangaEvent event,
      Emitter<TrendingMangaState> emit) async {
    if (state.hasReachedMax) return;

    if (page <= limit) {
      try {
        final mangas = await _repo.getTrending(page: page);
        page = page + 1;
        return emit(const TrendingMangaState().copyWith(
          status: StateStatus.success,
          trendingMangas: List.of(state.trendingMangas)..addAll(mangas),
          hasReachedMax: false,
        ));
      } catch (e) {
        return emit(const TrendingMangaState().copyWith(
          status: StateStatus.failure,
          error: e.toString(),
        ));
      }
    }
    emit(state.copyWith(hasReachedMax: true));
  }
}
