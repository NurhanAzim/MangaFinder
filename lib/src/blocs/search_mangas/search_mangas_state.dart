part of 'search_mangas_bloc.dart';

abstract class SearchMangaState extends Equatable {
  const SearchMangaState();
  @override
  List<Object?> get props => [];
}

class SearchInitialState extends SearchMangaState {}

class SearchLoadingState extends SearchMangaState {}

class SearchSuccessState extends SearchMangaState {
  final List<MangaModel> mangas;
  const SearchSuccessState({required this.mangas});
  @override
  List<Object?> get props => [mangas];
}

class SearchErrorState extends SearchMangaState {
  final String message;
  const SearchErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
