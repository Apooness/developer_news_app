class News {
  String title;
  String link;
  String enclosure;

  News({this.title, this.link, this.enclosure});

  News.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    link = json['link'];
    enclosure = json['enclosure'];
  }
}
