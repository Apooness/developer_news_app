import 'package:flutter/material.dart';
import 'package:news_app/data/http.dart';
import 'package:webfeed/domain/rss_feed.dart';

class NewsState with ChangeNotifier {
  HttpService _service = HttpService();

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  RssFeed _rssFeeds;
  RssFeed get rssFeeds => _rssFeeds;

  Future<void> getRss() async {
    _isLoading = true;
    _rssFeeds = await _service.getNews();
    _isLoading = false;
    notifyListeners();
  }
}
