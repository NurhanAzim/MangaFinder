import "package:equatable/equatable.dart";

import "genre_model.dart";

class MangaModel extends Equatable {
  final int malId;
  final List<GenreModel> genres;
  final String title;
  final String imageUrl;
  final int chapters;
  final String? status;
  final String? synopsis;
  final List<dynamic> authors;
  final int? publishedYear;

  const MangaModel(
      {required this.malId,
      this.genres = const [],
      required this.title,
      required this.imageUrl,
      this.chapters = 0,
      this.status,
      this.synopsis,
      this.authors = const [],
      this.publishedYear});

  factory MangaModel.fromJson(Map<String, dynamic> json) {
    return MangaModel(
      malId: json['mal_id']?.toInt() ?? 0,
      genres: List<GenreModel>.from(
          json['genres']?.map((x) => GenreModel.fromJson(x)) ?? []),
      title: json['titles'][0]['title'] ?? '',
      imageUrl: json['images']['jpg']['image_url'] ?? '',
      chapters: json['chapters'] ?? 0,
      status: json['status'] ?? 'Unknown status',
      synopsis: json['synopsis'] ?? 'Synopsis unavailable',
      authors: json['authors'] != null
          ? List<String>.from(
              json['authors'].map((author) => author['name'] as String))
          : [],
    );
  }

  factory MangaModel.fromPopularJson(Map<String, dynamic> json) {
    return MangaModel(
        malId: json['mal_id'] ?? 0,
        title: json['titles'][0]['title'] ?? '',
        imageUrl: json['images']['jpg']['image_url'] ?? '');
  }

  factory MangaModel.fromTrendingJson(Map<String, dynamic> json) {
    final entry = json['entry'][0];

    return MangaModel(
      malId: entry['mal_id'] ?? 0,
      title: entry['title'] ?? '',
      imageUrl: entry['images']['jpg']['image_url'] ?? '',
    ); //TODO: result show all in 1 page
  }

  factory MangaModel.fromRandomJson(Map<String, dynamic> json) {
    return MangaModel(
      malId: json['mal_id'] ?? 0,
      title: json['titles'][0]['title'] ?? '',
      imageUrl: json['images']['jpg']['large_image_url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mal_id': malId,
      'genres': genres.map((genre) => genre.toJson()).toList(),
      'titles': [
        {'title': title}
      ],
      'images': {
        'jpg': {'image_url': imageUrl}
      },
      'chapters': chapters,
      'status': status,
      'synopsis': synopsis,
      'authors': authors.map((author) => {'name': author}).toList(),
    };
  }

  @override
  List<Object?> get props => [malId, title];

  @override
  bool? get stringify => true;
}
