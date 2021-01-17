import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/services/navigation_service.dart';
import 'package:news_app/states/theme_state.dart';
import 'package:news_app/views/widgets/custom_raised_button.dart';
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
      appBar: _appbar,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flex(
              direction: Axis.vertical,
              children: [
                goToDevPage(context),
                openThemeDialog(),
              ],
            ),
            Flex(
              direction: Axis.vertical,
              children: [
                versionInfo(context),
                logOutButton(context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget get _appbar => AppBar(
        title: Text("Settings"),
      );

  Widget goToDevPage(BuildContext context) => customRaisedButton(
      child: Text(
        "Geliştirici",
        style: Theme.of(context).textTheme.button,
      ),
      onPressed: () => _navigator.goToNewPage(context: context, newPage: DeveloperPage()));

  Widget openThemeDialog() => Consumer<ThemeState>(
        builder: (BuildContext context, value, Widget child) {
          return customRaisedButton(
            child: Text(
              "Tema",
              style: Theme.of(context).textTheme.button,
            ),
            onPressed: () => showDialog(
              context: context,
              builder: (context) => ThemeDialog(value: value),
            ),
          );
        },
      );

  Widget versionInfo(BuildContext context) => Text(
        "Sürüm: 1.0",
        style: Theme.of(context).textTheme.headline1.copyWith(color: Theme.of(context).accentColor),
      );

  Widget logOutButton(BuildContext context) => customRaisedButton(
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
      );
}
