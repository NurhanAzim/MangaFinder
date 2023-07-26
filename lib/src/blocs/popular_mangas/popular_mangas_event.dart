import 'package:equatable/equatable.dart';

abstract class PopularMangaEvent extends Equatable {
  const PopularMangaEvent();
  @override
  List<Object?> get props => [];
}

class PopularMangaInitialEvent extends PopularMangaEvent {}

class LoadMorePopularMangaEvent extends PopularMangaEvent {}
