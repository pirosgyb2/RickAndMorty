import 'dart:async';

import 'package:rick_and_morty_app/data/models/character_data.dart';
import 'package:rick_and_morty_app/data/models/common_data.dart';

class MockCharacterRepository implements CommonRepository<Character> {
  @override
  Future<List<Character>> fetch() {
    return Future.value(kCharacters);
  }
}

const kCharacters = const <Character>[
  const Character(name: 'Romain Hoogmoed', species: 'Human'),
  const Character(name: 'Emilie Olsen', species: 'Human')
];
