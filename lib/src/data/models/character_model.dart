class CharacterModel {
  final String name;
  final String image;
  final String role;

  const CharacterModel(
      {required this.name, required this.image, required this.role});

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      name: json['character']['name'] ?? '',
      image: json['character']['images']['jpg']['image_url'] ?? '',
      role: json['role'] ?? '',
    );
  }
}
