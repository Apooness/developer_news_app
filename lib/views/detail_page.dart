import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key key, this.url}) : super(key: key);
  final url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar,
      body: WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }

  Widget get _appbar => AppBar(
        actions: [
          _shareIcon,
        ],
      );

  Widget get _shareIcon => IconButton(
        icon: Icon(Icons.share),
        onPressed: _share,
      );

  Future<void> _share() async {
    final title = "Deneme";

    await FlutterShare.share(
      linkUrl: url,
      title: title,
    );
  }
}
