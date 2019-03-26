class ResultInfo {
  final int count;
  final int pages;
  final String nextURL;
  final String prevURL;

  const ResultInfo({this.count, this.pages, this.nextURL, this.prevURL});

  ResultInfo.fromJson(Map<String, dynamic> map)
      : count = map['count'],
        pages = map['pages'],
        nextURL = map['next'],
        prevURL = map['prev'];
}
