import 'package:equatable/equatable.dart';

abstract class PopularMangaEvent extends Equatable {
  const PopularMangaEvent();
  @override
  List<Object?> get props => [];
}

class LoadPopularMangaEvent extends PopularMangaEvent {}
