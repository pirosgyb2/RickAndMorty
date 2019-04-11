import 'package:rick_and_morty_app/data/models/basic_data.dart';

class Episode extends BasicData {
  String airDate;
  String episode;
  List<String> characters;

  Episode({int id,
    String name,
      this.airDate,
      this.episode,
      this.characters,
    String url,
    DateTime created})
      : super(id: id, name: name, url: url, created: created);

  Episode.fromJson(Map<String, dynamic> map) : super.fromJson(map) {
    airDate = map['air_date'];
    episode = map['episode'];
    characters = map['characters']?.cast<String>();
  }
}
