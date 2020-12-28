import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_builder.dart';

import 'developer_info.dart';
import 'main_page.dart';

class SettingPage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
                TextButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => DeveloperPage(),
                    ),
                  ),
                  child: Text(
                    "Geliştirici",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 32,
                    ),
                  ),
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
                SignInButtonBuilder(
                  backgroundColor: Colors.blue,
                  text: "Çıkış Yap",
                  icon: Icons.logout,
                  onPressed: () {
                    _auth.signOut();
                    Navigator.of(context).popUntil((route) => route.isFirst);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => MainPage(),
                      ),
                    );
                    print(_auth.currentUser.email);
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
