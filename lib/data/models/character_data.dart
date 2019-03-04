import 'package:rick_and_morty_app/data/models/location_data.dart';

class Character {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final Location origin;
  final Location location;
  final String imageUrl;
  final List<String> episode;
  final String url;
  final DateTime created;

  const Character(
      {this.id,
      this.name,
      this.status,
      this.species,
      this.type,
      this.gender,
      this.origin,
      this.location,
      this.imageUrl,
      this.episode,
      this.url,
      this.created});

  Character.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        name = map['name'],
        status = map['status'],
        species = map['species'],
        type = map['type'],
        gender = map['gender'],
        origin = Location.fromMap(map['origin']),
        location = Location.fromMap(map['location']),
        imageUrl = map['image'],
        episode = map['episode']?.cast<String>(),
        url = map['url'],
        created = DateTime.parse(map['created']);
}
