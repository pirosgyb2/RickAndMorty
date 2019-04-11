import 'package:rick_and_morty_app/data/models/basic_data.dart';

class Location extends BasicData {
  String type;
  String dimension;
  List<String> residents;

  Location({int id,
    String name,
      this.type,
      this.dimension,
      this.residents,
    String url,
    DateTime created})
      : super(id: id, name: name, url: url, created: created);

  Location.fromJson(Map<String, dynamic> map) : super.fromJson(map) {
    type = map['type'];
    dimension = map['dimension'];
    residents = map['residents']?.cast<String>();
  }
}
