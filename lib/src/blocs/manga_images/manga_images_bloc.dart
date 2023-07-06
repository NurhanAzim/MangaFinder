import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:manga_finder/src/data/repositories/manga_repo_impl.dart';

part 'manga_images_event.dart';
part 'manga_images_state.dart';

class MangaImagesBloc extends Bloc<MangaImagesEvent, MangaImagesState> {
  final MangaRepository _repo;

  MangaImagesBloc(this._repo) : super(MangaImagesInitialState()) {
    on<LoadMangaImages>(_loadMangaImages);
  }

  FutureOr<void> _loadMangaImages(
      LoadMangaImages event, Emitter<MangaImagesState> emit) async {
    try {
      emit(MangaImagesLoadingState());
      List<dynamic> images = await _repo.getImages(id: event.id);
      emit(MangaImagesSuccessState(images: images));
    } catch (e) {
      emit(MangaImagesErrorState(e.toString()));
    }
  }
}
