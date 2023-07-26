import 'package:equatable/equatable.dart';

class CharacterModel extends Equatable {
  final String name;
  final String image;
  final String role;

  const CharacterModel(
      {required this.name, required this.image, required this.role});

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    final characterJson = json['character'] as Map<String, dynamic>?;
    final jpgImageJson =
        characterJson?['images']?['jpg'] as Map<String, dynamic>?;

    return CharacterModel(
      name: characterJson?['name'] as String? ?? '',
      image: jpgImageJson?['image_url'] as String? ?? '',
      role: json['role'] as String? ?? '',
    );
  }

  @override
  List<Object?> get props => [name, image, role];
}
