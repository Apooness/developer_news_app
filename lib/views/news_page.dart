import 'package:flutter/material.dart';
import 'package:news_app/data/http.dart';
import 'package:news_app/views/setting_page.dart';
import 'package:webfeed/domain/rss_feed.dart';

import 'detail_page.dart';

class NewsPage extends StatefulWidget {
  NewsPage({Key key}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  HttpService _service;
  TextEditingController _searchController;

  @override
  void initState() {
    _service = HttpService();
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(hintText: "Ara"),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                setState(() {
                  getNews();
                });
              }),
          IconButton(icon: Icon(Icons.settings), onPressed: () => goToSettingPage()),
        ],
      ),
      body: getNews(),
    );
  }

  getNews() {
    return FutureBuilder(
      future: _service.getNews(),
      builder: (context, AsyncSnapshot<RssFeed> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Text("Hata oluştu. Hata:${snapshot.error}");
        }
        if (!snapshot.hasData && snapshot.data.items.length == 0) {
          return Text("No Data");
        }
        return ListView.builder(
          itemCount: snapshot.data.items.length,
          itemBuilder: (BuildContext context, int index) {
            final news = snapshot.data.items[index];
            return InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => DetailPage(url: news.link),
                ),
              ),
              child: Card(
                child: Row(
                  children: [
                    Image(
                      fit: BoxFit.cover,
                      height: 100,
                      width: 150,
                      image: NetworkImage(news.enclosure.url),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        news.title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 5,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  goToSettingPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => SettingPage(),
      ),
    );
  }
}
