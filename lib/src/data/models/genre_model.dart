import 'package:equatable/equatable.dart';

class GenreModel extends Equatable {
  final int malId;
  final String type;
  final String name;

  GenreModel({
    required this.malId,
    required this.type,
    required this.name,
  });

  factory GenreModel.fromJson(Map<String, dynamic> json) {
    return GenreModel(
      malId: json['mal_id']?.toInt() ?? 0,
      type: json['type'] ?? '',
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'malId': malId,
      'type': type,
      'name': name,
    };
  }

  @override
  // TODO: implement props
  List<Object?> get props => [malId, type, name];
}
