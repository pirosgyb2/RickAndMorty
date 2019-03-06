import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:http/http.dart' as http;
import 'package:rick_and_morty_app/data/models/character_data.dart';
import 'package:rick_and_morty_app/data/models/episode_data.dart';
import 'package:rick_and_morty_app/data/models/location_data.dart';

class Repository<T> {
  String _apiUri = 'https://rickandmortyapi.com/api/';
  final JsonDecoder _decoder = new JsonDecoder();

  Repository() {
    _specifyUri();
  }

  Future<List<T>> fetch() async {
    final response = await http.get(_apiUri);
    final jsonBody = response.body;
    final statusCode = response.statusCode;

    if (statusCode < 200 || statusCode >= 300 || jsonBody == null) {
      throw new FetchDataException(
          "Error while getting items [StatusCode:$statusCode, Error:${response
              .reasonPhrase}]");
    }
    final container = _decoder.convert(jsonBody);
    final List items = container['results'];

    return _getItems(items);
  }

  void _specifyUri() {
    switch (T) {
      case (Character):
        _apiUri = _apiUri + 'character';
        break;
      case (Episode):
        _apiUri = _apiUri + 'episode';
        break;
      case (Location):
        _apiUri = _apiUri + 'location';
        break;
    }
  }

  List<T> _getItems(List items) {
    switch (T) {
      case (Character):
        return items.map((raw) => (Character.fromMap(raw)) as T).toList();
        break;
      case (Episode):
        return items.map((raw) => (Episode.fromMap(raw)) as T).toList();
        break;
      case (Location):
        return items.map((raw) => (Location.fromMap(raw)) as T).toList();
        break;
    }
  }
}

class FetchDataException implements Exception {
  String _message;

  FetchDataException(this._message);

  String toString() {
    return "Exception: $_message";
  }
}
