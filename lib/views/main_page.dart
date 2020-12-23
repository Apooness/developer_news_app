import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:news_app/views/sign_in_page.dart';
import 'package:news_app/views/sign_up_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hoş Geldiniz"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 24),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  color: Colors.black,
                  child: Image.asset(
                    "assets/multicamp-logo.png",
                    height: 150,
                    width: 150,
                  ),
                ),
                SizedBox(width: 30),
                Container(
                  height: 150,
                  width: 150,
                  color: Colors.black,
                  child: FlutterLogo(),
                )
              ],
            ),
            SizedBox(height: 100),
            Expanded(
              child: Container(
                child: Column(
                  children: [
                    SignInButtonBuilder(
                      height: 50,
                      backgroundColor: Colors.orange,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => SignInPage(),
                          ),
                        );
                      },
                      text: "Giriş ",
                      icon: Icons.email,
                    ),
                    SizedBox(height: 50),
                    SignInButtonBuilder(
                      height: 50,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => SignUpPage(),
                          ),
                        );
                      },
                      backgroundColor: Colors.blue,
                      text: "Kayıt Ol",
                      icon: Icons.person_add,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
