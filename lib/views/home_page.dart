import 'package:flutter/material.dart';
import 'package:news_app/data/http.dart';
import 'package:news_app/views/setting_page.dart';
import 'package:webfeed/domain/rss_feed.dart';
import 'package:turkish/turkish.dart';

import 'detail_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      body: getFilteredNews(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () {
          setState(() {
            _service.getNews();
          });
        },
      ),
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

  getFilteredNews() {
    return FutureBuilder(
      future: _service.getNews(),
      // ignore: missing_return
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
          // ignore: missing_return
          itemBuilder: (BuildContext context, int index) {
            final lowerSearch = turkish.toLowerCase(_searchController.text);
            final lowerNewsTitle = turkish.toLowerCase(snapshot.data.items[index].title);
            if (_searchController.text != null) {
              if (lowerNewsTitle.contains(lowerSearch)) {
                final news = snapshot.data.items[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => DetailPage(url: news.link),
                      ),
                    );
                  },
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
              }
            } else {
              getNews();
            }
          },
        );
      },
    );
  }
}
