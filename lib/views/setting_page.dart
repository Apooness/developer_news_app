import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              "Mustafa AKİL",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              "Sürüm: 1.0",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                "Çıkış Yap",
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 36,
                  fontWeight: FontWeight.w400,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
