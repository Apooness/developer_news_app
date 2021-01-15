import 'package:flutter/material.dart';
import 'package:news_app/states/sncakbar_message_state.dart';
import 'package:provider/provider.dart';

class ShowSnackBar {
  void scaffoldMessenger({BuildContext context}) {
    final snackBarMessage = Provider.of<SnackBarMessage>(context, listen: false).message;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(snackBarMessage),
      ),
    );
  }
}
