import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rick_and_morty_app/data/models/character_data.dart';
import 'package:rick_and_morty_app/data/models/common_data.dart';

class CharacterRepository implements CommonRepository<Character> {
  static const _apiUri = 'https://rickandmortyapi.com/api/character';
  final JsonDecoder _decoder = new JsonDecoder();

  @override
  Future<List<Character>> fetch() async {
    final response = await http.get(_apiUri);
    final jsonBody = response.body;
    final statusCode = response.statusCode;

    if (statusCode < 200 || statusCode >= 300 || jsonBody == null) {
      throw new FetchDataException(
          "Error while getting contacts [StatusCode:$statusCode, Error:${response.reasonPhrase}]");
    }
    final characterContainer = _decoder.convert(jsonBody);
    final List characterItems = characterContainer['results'];

    return characterItems
        .map((characterRaw) => Character.fromMap(characterRaw))
        .toList();
  }
}