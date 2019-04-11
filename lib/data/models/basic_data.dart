class BasicData {
  int id;
  String name;
  String url;
  DateTime created;

  BasicData({this.id, this.name, this.url, this.created});

  BasicData.fromJson(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    url = map['url'];
    created = map['created'] != null
        ? DateTime.parse(map['created'])
        : DateTime.now();
  }
}
