import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:news_app/states/sncakbar_message_state.dart';
import 'package:news_app/states/theme_state.dart';
import 'package:news_app/views/splash_page.dart';
import 'package:provider/provider.dart';

import 'views/detail_page.dart';
import 'views/developer_info.dart';
import 'views/main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SnackBarMessage()),
        ChangeNotifierProvider(create: (_) => ThemeState()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Akil Haber',
      theme: Provider.of<ThemeState>(context).themeData,
      home: SplashScreen(),
    );
  }
}
