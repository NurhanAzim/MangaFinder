class GenreModel {
  final int malId;
  final String type;
  final String name;
  final String url;

  GenreModel({
    required this.malId,
    required this.type,
    required this.name,
    required this.url,
  });

  factory GenreModel.fromJson(Map<String, dynamic> json) {
    return GenreModel(
      malId: json['mal_id']?.toInt() ?? 0,
      type: json['type'] ?? '',
      name: json['name'] ?? '',
      url: json['url'] ?? '',
    );
  }
}
