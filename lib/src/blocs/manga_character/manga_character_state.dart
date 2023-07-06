part of 'manga_character_bloc.dart';

abstract class MangaCharacterState extends Equatable {
  const MangaCharacterState();

  @override
  List<Object?> get props => [];
}

class MangaCharacterInitialState extends MangaCharacterState {}

class MangaCharacterLoadingState extends MangaCharacterState {}

class MangaCharacterSuccessState extends MangaCharacterState {
  final List<CharacterModel> characters;

  const MangaCharacterSuccessState({required this.characters});

  @override
  List<Object?> get props => [characters];
}

class MangaCharacterErrorState extends MangaCharacterState {
  final String error;

  const MangaCharacterErrorState({required this.error});

  @override
  List<Object?> get props => [error];
}
