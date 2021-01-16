import 'package:flutter/material.dart';
import 'package:news_app/themes/black_theme.dart';
import 'package:news_app/themes/blue_theme.dart';
import 'package:news_app/themes/green_theme.dart';

class ThemeDialog extends StatelessWidget {
  const ThemeDialog({Key key, this.value}) : super(key: key);
  final value;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      children: [
        Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  value.setThemeData(blueTheme);
                },
                child: Text("Açık"),
              ),
              ElevatedButton(
                onPressed: () {
                  value.setThemeData(greenTheme);
                },
                child: Text("Yeşil"),
              ),
              ElevatedButton(
                onPressed: () {
                  value.setThemeData(blackTheme);
                },
                child: Text("Koyu"),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
