import 'package:flutter/material.dart';

class ThemeState with ChangeNotifier {
  ThemeData _themeData;

  ThemeData get themeData => _themeData;

  setThemeData(ThemeData theme) {
    _themeData = theme;
    notifyListeners();
  }
}
