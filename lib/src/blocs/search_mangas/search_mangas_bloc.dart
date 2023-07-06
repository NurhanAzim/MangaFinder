import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manga_finder/src/data/models/manga_model.dart';
import 'package:manga_finder/src/data/repositories/manga_repo_impl.dart';

part 'search_mangas_event.dart';
part 'search_mangas_state.dart';

class SearchMangaBloc extends Bloc<SearchMangaEvent, SearchMangaState> {
  final MangaRepository _repo;

  SearchMangaBloc(this._repo) : super(SearchInitialState()) {
    on<SearchForMangaEvent>(_searchForMangaEvent);
    on<RemoveSearchedEvent>(_removeSearchedEvent);
  }

  FutureOr<void> _searchForMangaEvent(
      SearchForMangaEvent event, Emitter<SearchMangaState> emit) async {
    try {
      emit(SearchLoadingState());
      List<MangaModel> mangas =
          await _repo.getSearchedManga(query: event.query);
      emit(SearchSuccessState(mangas: mangas));
    } catch (e) {
      emit(SearchErrorState(message: e.toString()));
    }
  }

  FutureOr<void> _removeSearchedEvent(
      RemoveSearchedEvent event, Emitter<SearchMangaState> emit) {
    emit(SearchInitialState());
  }
}
