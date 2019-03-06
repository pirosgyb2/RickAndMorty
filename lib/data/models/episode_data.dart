class Episode {
  final int id;
  final String name;
  final String airDate;
  final String episode;
  final List<String> characters;
  final String url;
  final DateTime created;

  const Episode(
      {this.id,
      this.name,
      this.airDate,
      this.episode,
      this.characters,
      this.url,
      this.created});

  Episode.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        name = map['name'],
        airDate = map['air_date'],
        episode = map['episode'],
        characters = map['characters']?.cast<String>(),
        url = map['url'],
        created = map['created'] != null
            ? DateTime.parse(map['created'])
            : DateTime.now();
}
