import 'package:flutter_test/flutter_test.dart';
import 'package:manga_finder/src/data/models/character_model.dart';

void main() {
  group('CharacterModel', () {
    Map<String, dynamic> characterModelAsJson = {
      "character": {
        "images": {
          "jpg": {
            "image_url":
                "https://cdn.myanimelist.net/images/characters/10/161005.jpg?s=8e3191d4d9691fffe3dafaefaf086014"
          },
        },
        "name": "Brook"
      },
      "role": "Main"
    };

    CharacterModel expectedCharacterModel = const CharacterModel(
        name: 'Brook',
        image:
            "https://cdn.myanimelist.net/images/characters/10/161005.jpg?s=8e3191d4d9691fffe3dafaefaf086014",
        role: 'Main');
    test('Test CharacterModel fromJson', () {
      expect(CharacterModel.fromJson(characterModelAsJson),
          expectedCharacterModel);
    });
  });
}
