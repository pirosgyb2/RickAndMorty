import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:http/http.dart' as http;
import 'package:rick_and_morty_app/data/models/character_data.dart';
import 'package:rick_and_morty_app/data/models/episode_data.dart';
import 'package:rick_and_morty_app/data/models/location_data.dart';
import 'package:rick_and_morty_app/data/models/result_info_data.dart';

class Repository<T> {
  String apiUri = 'https://rickandmortyapi.com/api/';
  final JsonDecoder decoder = new JsonDecoder();
  ResultInfo responseInfo = new ResultInfo(nextURL: "this is the first page");

  Repository() {
    specifyUri();
  }

  Future<T> fetchOne(String uri) {} //TODO: ez itt megkene legyen irva, nem?

  Future<List<T>> fetchList(int pageNumber) async {
    updateURIpageNumber(pageNumber);
    final response = await http.get(apiUri);
    final jsonBody = response.body;
    final statusCode = response.statusCode;

    if (statusCode < 200 || statusCode >= 300 || jsonBody == null) {
      throw new FetchDataException(
          "Error while getting items [StatusCode:$statusCode, Error:${response
              .reasonPhrase}]");
    }
    final container = decoder.convert(jsonBody);
    final List items = container['results'];

    responseInfo = ResultInfo.fromJson(container['info']);

    return _getItems(items);
  }

  Future<List<T>> search(String query) async {
    final response = await http.get(apiUri + "/?name=" + query);
    final jsonBody = response.body;
    final statusCode = response.statusCode;

    if (statusCode < 200 || statusCode >= 300 || jsonBody == null) {
      throw new FetchDataException(
          "Error while getting items [StatusCode:$statusCode, Error:${response
              .reasonPhrase}]");
    }
    final container = decoder.convert(jsonBody);
    final List items = container['results'];

    // responseInfo = ResultInfo.fromJson(container['info']);

    return _getItems(items);
  }

  void specifyUri() {
    switch (T) {
      case (Character):
        apiUri = apiUri + 'character';
        break;
      case (Episode):
        apiUri = apiUri + 'episode';
        break;
      case (Location):
        apiUri = apiUri + 'location';
        break;
    }
  }

  T getItem(dynamic container) {}

  List<T> _getItems(List items) {
    switch (T) {
      case (Character):
        return items.map((raw) => (Character.fromJson(raw)) as T).toList();
        break;
      case (Episode):
        return items.map((raw) => (Episode.fromJson(raw)) as T).toList();
        break;
      case (Location):
        return items.map((raw) => (Location.fromJson(raw)) as T).toList();
        break;
      default:
        return null;
        break;
    }
  }

  void updateURIpageNumber(int pageNumber) {
    if (apiUri.contains("/?page=", 0)) {
      apiUri = apiUri.replaceRange(
          apiUri.indexOf('=') + 1, apiUri.length, pageNumber.toString());
    } else {
      apiUri = apiUri + "/?page=" + pageNumber.toString();
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
