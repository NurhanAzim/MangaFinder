part of 'search_mangas_bloc.dart';

abstract class SearchMangaEvent extends Equatable {
  const SearchMangaEvent();

  @override
  List<Object?> get props => [];
}

class SearchForMangaEvent extends SearchMangaEvent {
  final String query;

  const SearchForMangaEvent({required this.query});

  @override
  List<Object?> get props => [query];
}

class RemoveSearchedEvent extends SearchMangaEvent {
  const RemoveSearchedEvent();
}
