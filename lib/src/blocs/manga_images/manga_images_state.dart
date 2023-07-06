part of 'manga_images_bloc.dart';

abstract class MangaImagesState extends Equatable {
  const MangaImagesState();

  @override
  List<Object?> get props => [];
}

class MangaImagesInitialState extends MangaImagesState {}

class MangaImagesLoadingState extends MangaImagesState {}

class MangaImagesSuccessState extends MangaImagesState {
  final List<dynamic> images;

  const MangaImagesSuccessState({required this.images});

  @override
  List<Object?> get props => [images];
}

class MangaImagesErrorState extends MangaImagesState {
  final String error;

  const MangaImagesErrorState(this.error);

  @override
  List<Object> get props => [error];
}
