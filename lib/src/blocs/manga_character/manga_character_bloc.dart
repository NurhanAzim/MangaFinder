import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:manga_finder/src/data/models/character_model.dart';
import 'package:manga_finder/src/data/repositories/manga_repo_impl.dart';

part 'manga_character_event.dart';
part 'manga_character_state.dart';

class MangaCharacterBloc
    extends Bloc<MangaCharacterEvent, MangaCharacterState> {
  final MangaRepository _repo;

  MangaCharacterBloc(this._repo) : super(MangaCharacterInitialState()) {
    on<LoadMangaCharacter>(_loadMangaCharacter);
  }

  FutureOr<void> _loadMangaCharacter(
      LoadMangaCharacter event, Emitter<MangaCharacterState> emit) async {
    try {
      emit(MangaCharacterLoadingState());
      List<CharacterModel> characters = await _repo.getCharacters(id: event.id);
      emit(MangaCharacterSuccessState(characters: characters));
    } catch (e) {
      emit(MangaCharacterErrorState(error: e.toString()));
    }
  }
}
