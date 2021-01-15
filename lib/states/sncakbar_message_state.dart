import 'package:flutter/material.dart';

class SnackBarMessage with ChangeNotifier {
  String _message = "";
  bool _loginResult = false;

  bool get loginResult => _loginResult;

  String get message => _message;

  changeSnackbarMessage(String text) {
    _message = text;
    notifyListeners();
  }

  changeLoginResult() {
    _loginResult = !_loginResult;
    notifyListeners();
  }
}
