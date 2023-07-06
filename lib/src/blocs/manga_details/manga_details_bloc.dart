import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:manga_finder/src/data/models/manga_details_model.dart';
import 'package:manga_finder/src/data/repositories/manga_repo_impl.dart';

part 'manga_details_event.dart';
part 'manga_details_state.dart';

class MangaDetailsBloc extends Bloc<MangaDetailsEvent, MangaDetailState> {
  final MangaRepository _repo;

  MangaDetailsBloc(this._repo) : super(MangaDetailsInitialState()) {
    on<LoadMangaDetails>(_loadMangaDetails);
  }

  FutureOr<void> _loadMangaDetails(
      LoadMangaDetails event, Emitter<MangaDetailState> emit) async {
    try {
      emit(MangaDetailsLoadingState());
      MangaDetailsModel manga = await _repo.getMangaDetails(id: event.id);
      emit(MangaDetailsSuccessState(manga: manga));
    } catch (e, stackTrace) {
      emit(MangaDetailsErrorState('$e   $stackTrace'));
    }
  }
}
