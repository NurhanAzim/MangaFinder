part of 'manga_character_bloc.dart';

abstract class MangaCharacterEvent extends Equatable {
  const MangaCharacterEvent();

  @override
  List<Object?> get props => [];
}

class LoadMangaCharacter extends MangaCharacterEvent {
  final int id;

  const LoadMangaCharacter(this.id);
  @override
  List<Object?> get props => [id];
}
