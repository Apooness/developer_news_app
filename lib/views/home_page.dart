import 'package:flutter/material.dart';
import 'package:news_app/data/http.dart';
import 'package:webfeed/domain/rss_feed.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HttpService _service;

  @override
  void initState() {
    _service = HttpService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News"),
      ),
      body: FutureBuilder(
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
              return Card(
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
                // leading: Image(
                //   image: NetworkImage(news.enclosure.url),
                // ),
                // title: Text(news.title),
              );
            },
            // separatorBuilder: (BuildContext context, int index) {
            //   return Divider();
            // },
          );
        },
      ),
    );
  }
}
