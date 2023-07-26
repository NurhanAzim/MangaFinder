import 'package:equatable/equatable.dart';
import 'package:manga_finder/src/data/models/genre_model.dart';

class MangaDetailsModel extends Equatable {
  final int malId;
  final String status;
  final String title;
  final String synopsis;
  final String imageUrl;
  final List<GenreModel> genres;

  MangaDetailsModel({
    required this.malId,
    required this.status,
    required this.title,
    required this.synopsis,
    required this.imageUrl,
    required this.genres,
  });

  factory MangaDetailsModel.fromMap(Map<String, dynamic> json) {
    return MangaDetailsModel(
      malId: json['mal_id']?.toInt() ?? 0,
      status: json['status'] ?? '',
      title: json['title'] ?? '',
      synopsis: json['synopsis'] ?? '',
      imageUrl: json['images']['jpg']['large_image_url'] ?? '',
      genres: List<GenreModel>.from(
          json['genres']?.map((x) => GenreModel.fromJson(x)) ?? []),
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [malId];
}
