part of 'trending_mangas_bloc.dart';

abstract class TrendingMangaEvent extends Equatable {
  const TrendingMangaEvent();

  @override
  List<Object?> get props => [];
}

class LoadTrendingMangaEvent extends TrendingMangaEvent {}
