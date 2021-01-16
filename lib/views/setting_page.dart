import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/services/navigation_service.dart';
import 'package:news_app/states/theme_state.dart';
import 'package:news_app/views/widgets/theme_dialog.dart';
import 'package:provider/provider.dart';

import 'developer_info.dart';
import 'main_page.dart';

class SettingPage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final NavigationService _navigator = NavigationService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flex(
              direction: Axis.vertical,
              children: [
                RaisedButton(
                  onPressed: () =>
                      _navigator.goToNewPage(context: context, newPage: DeveloperPage()),
                  child: Text(
                    "Geliştirici",
                    style: Theme.of(context).textTheme.button,
                  ),
                ),
                Consumer<ThemeState>(
                  builder: (BuildContext context, value, Widget child) {
                    return RaisedButton(
                      onPressed: () => showDialog(
                        context: context,
                        builder: (context) => ThemeDialog(value: value),
                      ),
                      child: Text(
                        "Tema",
                        style: Theme.of(context).textTheme.button,
                      ),
                    );
                  },
                ),
              ],
            ),
            Flex(
              direction: Axis.vertical,
              children: [
                Text(
                  "Sürüm: 1.0",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
                RaisedButton(
                  child: Row(
                    children: [
                      Icon(Icons.logout),
                      SizedBox(width: 10),
                      Text(
                        "Çıkış Yap",
                        style: Theme.of(context).textTheme.button,
                      ),
                    ],
                  ),
                  onPressed: () {
                    _auth.signOut();
                    _navigator.replaceNewPage(context: context, newPage: MainPage());
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
