import 'package:http/http.dart' as http;
import 'package:webfeed/webfeed.dart';

class HttpService {
  String _url = "https://t24.com.tr/rss";

  Future<RssFeed> getNews() async {
    final response = await http.get(_url);
    final news = RssFeed.parse(response.body);
    return news;
  }
}
