import 'package:flutter/material.dart';
import 'package:news_app/states/news_state.dart';
import 'package:provider/provider.dart';

class NewsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildConsumer(),
    );
  }

  AppBar _buildAppBar() => AppBar(
        title: Text(
          'RSS Feed Provider',
        ),
      );

  Consumer<NewsState> _buildConsumer() {
    return Consumer<NewsState>(
      builder: (context, model, child) => model.isLoading ? _buildCenter() : _buildContainer(model),
    );
  }

  Center _buildCenter() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Container _buildContainer(NewsState model) {
    return Container(
      padding: EdgeInsets.all(10),
      child: _buildListView(model),
    );
  }

  ListView _buildListView(NewsState model) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: model.rssFeeds.items.length,
      itemBuilder: (context, int index) {
        return _buildCard(model, index);
      },
    );
  }

  Card _buildCard(NewsState model, int index) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: _buildListTile(model, index),
    );
  }

  ListTile _buildListTile(NewsState model, int index) {
    return ListTile(
      title: Text(
        'Title: ' + model.rssFeeds.items[index].title,
      ),
      subtitle: Text(
        'Link: ' + model.rssFeeds.items[index].link,
      ),
    );
  }
}
