class Location {
  final int id;
  final String name;
  final String type;
  final String dimension;
  final List<String> residents;
  final String url;
  final DateTime created;

  const Location(
      {this.id,
      this.name,
      this.type,
      this.dimension,
      this.residents,
      this.url,
      this.created});

  Location.fromJson(Map<String, dynamic> map)
      : id = map['id'],
        name = map['name'],
        type = map['type'],
        dimension = map['dimension'],
        residents = map['residents']?.cast<String>(),
        url = map['url'],
        created = map['created'] != null
            ? DateTime.parse(map['created'])
            : DateTime.now();
}
