import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:manga_finder/src/blocs/bloc_constants.dart';
import 'package:manga_finder/src/data/models/manga_model.dart';
import 'package:manga_finder/src/data/repositories/manga_repo_impl.dart';
import 'package:stream_transform/stream_transform.dart';

part 'random_manga_event.dart';
part 'random_manga_state.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class RandomMangaBloc extends Bloc<RandomMangaEvent, RandomMangaState> {
  final MangaRepository _repo;
  int page = 1;
  int limit = 1;

  RandomMangaBloc(this._repo) : super(const RandomMangaState()) {
    on<LoadRandomMangaEvent>(_loadRandomMangaEvent,
        transformer: throttleDroppable(throttleDuration));
  }

  Future<void> _loadRandomMangaEvent(
      LoadRandomMangaEvent event, Emitter<RandomMangaState> emit) async {
    if (state.hasReachedMax) return;
    if (state.status == StateStatus.initial) {
      try {
        final mangas = await _repo.getRandom(page: page);
        page = page + 1;
        return emit(const RandomMangaState().copyWith(
          status: StateStatus.success,
          randomMangas: mangas,
          hasReachedMax: false,
        ));
      } catch (e) {
        return emit(const RandomMangaState().copyWith(
          status: StateStatus.failure,
          error: e.toString(),
        ));
      }
    }

    if (page <= limit) {
      try {
        final mangas = await _repo.getRandom(page: page);
        page = page + 1;
        return emit(const RandomMangaState().copyWith(
          status: StateStatus.success,
          randomMangas: List.of(state.randomMangas)..addAll(mangas),
          hasReachedMax: false,
        ));
      } catch (e) {
        emit(const RandomMangaState().copyWith(
          status: StateStatus.failure,
          error: e.toString(),
        ));
      }
    }

    emit(state.copyWith(hasReachedMax: true));
  }
}
