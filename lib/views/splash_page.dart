import 'package:flutter/material.dart';
import 'package:news_app/services/navigation_service.dart';

import 'main_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  NavigationService _navigator;

  @override
  void initState() {
    _navigator = NavigationService();
    Future.delayed(Duration(seconds: 3), () async {
      _navigator.replaceNewPage(context: context, newPage: MainPage());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          child: Image.asset(
            "assets/multicamp.png",
          ),
        ),
      ),
    );
  }
}
