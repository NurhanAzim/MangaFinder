part of 'manga_details_bloc.dart';

abstract class MangaDetailsEvent extends Equatable {
  const MangaDetailsEvent();

  @override
  List<Object?> get props => [];
}

class LoadMangaDetails extends MangaDetailsEvent {
  final int id;

  const LoadMangaDetails(this.id);

  @override
  List<Object?> get props => [id];
}
