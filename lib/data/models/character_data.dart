import 'package:rick_and_morty_app/data/models/basic_data.dart';
import 'package:rick_and_morty_app/data/models/location_data.dart';

class Character extends BasicData {
  String status;
  String species;
  String type;
  String gender;
  Location origin;
  Location location;
  String imageUrl;
  List<String> episode;

  Character({int id,
    String name,
    this.status,
    this.species,
    this.type,
    this.gender,
    this.origin,
    this.location,
    this.imageUrl,
    this.episode,
    String url,
    DateTime created})
      : super(id: id, name: name, url: url, created: created);

  Character.fromJson(Map<String, dynamic> map) : super.fromJson(map) {
    status = map['status'];
    species = map['species'];
    type = map['type'];
    gender = map['gender'];
    origin = Location.fromJson(map['origin']);
    location = Location.fromJson(map['location']);
    imageUrl = map['image'];
    episode = map['episode']?.cast<String>();
  }
}
