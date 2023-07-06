part of 'manga_details_bloc.dart';

abstract class MangaDetailState extends Equatable {
  const MangaDetailState();

  @override
  List<Object?> get props => [];
}

class MangaDetailsInitialState extends MangaDetailState {}

class MangaDetailsLoadingState extends MangaDetailState {}

class MangaDetailsSuccessState extends MangaDetailState {
  final MangaDetailsModel manga;

  const MangaDetailsSuccessState({required this.manga});

  @override
  List<Object?> get props => [manga];
}

class MangaDetailsErrorState extends MangaDetailState {
  final String error;

  const MangaDetailsErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
