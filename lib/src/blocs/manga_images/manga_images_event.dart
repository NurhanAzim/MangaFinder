part of 'manga_images_bloc.dart';

abstract class MangaImagesEvent extends Equatable {
  const MangaImagesEvent();

  @override
  List<Object?> get props => [];
}

class LoadMangaImages extends MangaImagesEvent {
  final int id;

  const LoadMangaImages(this.id);

  @override
  List<Object?> get props => [id];
}
