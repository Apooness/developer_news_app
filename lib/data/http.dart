import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:webfeed/webfeed.dart';

class HttpService extends ChangeNotifier {
  final _url = 'https://t24.com.tr/rss';

  /// Service
  Future<RssFeed> getNews() async {
    try {
      final response = await http.get(
        Uri.encodeFull(_url),
      );
      final _rssBody = response.body;

      final _rssResponse = RssFeed.parse(_rssBody);
      switch (response.statusCode) {
        case 200:
          debugPrint('200 OK');
          return _rssResponse;
        default:
          throw Exception(response.body.toString());
      }
    } on SocketException {
      debugPrint('SocketException');
      throw Exception('No Internet connection');
    }
  }

}

