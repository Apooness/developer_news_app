import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:news_app/services/navigation_service.dart';
import 'package:news_app/views/sign_in_page.dart';
import 'package:news_app/views/sign_up_page.dart';
import 'package:news_app/views/widgets/custom_container.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NavigationService _navigator = NavigationService();

    return Scaffold(
      appBar: _appBar,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 24),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                customContainer(Colors.black, 150, 150, Image.asset("assets/multicamp-logo.png")),
                space(width: 30),
                customContainer(Colors.black, 150, 150, FlutterLogo())
              ],
            ),
            space(height: 100),
            Expanded(
              child: Column(
                children: [
                  _signInButton(_navigator, context),
                  SizedBox(height: 50),
                  _signUpButton(_navigator, context),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget get _appBar => AppBar(
        title: Text("Hoş Geldiniz"),
      );

  Widget _signUpButton(NavigationService _navigator, BuildContext context) => SignInButtonBuilder(
        height: 50,
        onPressed: () {
          _navigator.goToNewPage(context: context, newPage: SignUpPage());
        },
        backgroundColor: Colors.blue,
        text: "Kayıt Ol",
        icon: Icons.person_add,
      );

  Widget _signInButton(NavigationService _navigator, BuildContext context) => SignInButtonBuilder(
        height: 50,
        backgroundColor: Colors.orange,
        onPressed: () {
          _navigator.goToNewPage(context: context, newPage: SignInPage());
        },
        text: "Giriş ",
        icon: Icons.email,
      );

  Widget space({double width = 0, double height = 0}) => SizedBox(width: width, height: height);
}
