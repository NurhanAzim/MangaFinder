import "package:equatable/equatable.dart";
import "package:flutter/material.dart";

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
    debugPrint(json.toString());
    String defaultTitle = json['titles']
        .firstWhere((title) => title['type'] == 'Default')['title'];

    return MangaModel(
      malId: json['mal_id']?.toInt() ?? 0,
      genres: List<GenreModel>.from(
          json['genres']?.map((x) => GenreModel.fromJson(x)) ?? []),
      title: defaultTitle,
      imageUrl: json['images']['jpg']['image_url'] ?? '',
      chapters: json['chapters'] ?? 0,
      status: json['status'] ?? 'Unknown status',
      synopsis: json['synopsis'] ?? 'Synopsis unavailable',
      authors:
          json['authors'].map((author) => author['name'] as String).toList(),
    );
  }

  factory MangaModel.fromPopularJson(Map<String, dynamic> json) {
    return MangaModel(
        malId: json['mal_id'] ?? 0,
        title: json['titles']
                .firstWhere((title) => title['type'] == 'Default')['title'] ??
            '',
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
      title: json['titles'][0]['title'],
      imageUrl: json['images']['jpg']['large_image_url'],
      publishedYear: DateTime.parse(json['published']['from']).year,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'malId': malId,
      'genres': genres,
      'title': title,
      'imageUrl': imageUrl,
      'chapters': chapters,
      'status': status,
      'synopsis': synopsis,
      'authors': authors,
    };
  }

  @override
  List<Object?> get props => [malId, title];

  @override
  bool? get stringify => true;
}
