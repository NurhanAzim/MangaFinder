part of 'random_manga_bloc.dart';

abstract class RandomMangaEvent extends Equatable {
  const RandomMangaEvent();

  @override
  List<Object?> get props => [];
}

class LoadRandomMangaEvent extends RandomMangaEvent {}
