import 'dart:async';
import 'dart:core';

import 'package:http/http.dart' as http;
import 'package:rick_and_morty_app/data/models/character_data.dart';
import 'package:rick_and_morty_app/data/models/episode_data.dart';
import 'package:rick_and_morty_app/data/models/location_data.dart';
import 'package:rick_and_morty_app/data/repos/common_repo.dart';

class SpecCharacterRepository extends Repository<Character> {
  @override
  Future<Character> fetchOne(String uri) async {
    final response = await http.get(uri);
    final jsonBody = response.body;
    final statusCode = response.statusCode;
    if (statusCode < 200 || statusCode >= 300 || jsonBody == null) {
      throw new FetchDataException(
          "Error while getting items [StatusCode:$statusCode, Error:${response.reasonPhrase}]");
    }
    final container = decoder.convert(jsonBody);
    return getItem(container);
  }

  @override
  Character getItem(container) {
    return Character.fromJson(container);
  }
}

class SpecEpisodeRepository extends Repository<Episode> {
  @override
  Future<Episode> fetchOne(String uri) async {
    final response = await http.get(uri);
    final jsonBody = response.body;
    final statusCode = response.statusCode;
    if (statusCode < 200 || statusCode >= 300 || jsonBody == null) {
      throw new FetchDataException(
          "Error while getting items [StatusCode:$statusCode, Error:${response.reasonPhrase}]");
    }
    final container = decoder.convert(jsonBody);
    return getItem(container);
  }

  @override
  Episode getItem(container) {
    return Episode.fromJson(container);
  }
}

class SpecLocationRepository extends Repository<Location> {
  @override
  Future<Location> fetchOne(String uri) async {
    final response = await http.get(uri);
    final jsonBody = response.body;
    final statusCode = response.statusCode;
    if (statusCode < 200 || statusCode >= 300 || jsonBody == null) {
      throw new FetchDataException(
          "Error while getting items [StatusCode:$statusCode, Error:${response.reasonPhrase}]");
    }
    final container = decoder.convert(jsonBody);
    return getItem(container);
  }

  @override
  Location getItem(container) {
    return Location.fromJson(container);
  }
}
