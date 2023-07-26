import 'package:equatable/equatable.dart';

class LibraryManga extends Equatable {
  final int malId;
  final String imageUrl;
  final String title;
  final String synopsis;
  final String userId;

  const LibraryManga(
      {required this.malId,
      required this.imageUrl,
      required this.title,
      required this.synopsis,
      required this.userId});

  factory LibraryManga.fromJson(Map<String, dynamic> json) {
    return LibraryManga(
        malId: json['manga_id'],
        imageUrl: json['image_url'],
        title: json['title'],
        synopsis: json['synopsis'],
        userId: json['user_id']);
  }

  Map<String, dynamic> toJson() {
    return {
      'manga_id': malId,
      'image_url': imageUrl,
      'title': title,
      'synopsis': synopsis,
      'user_id': userId,
    };
  }

  @override
  List<Object?> get props => [malId];
}
