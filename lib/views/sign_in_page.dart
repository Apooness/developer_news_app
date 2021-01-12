import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:news_app/navigation/slide_route.dart';
import 'package:news_app/services/auth_service.dart';

import 'home_page.dart';

class SignInPage extends StatefulWidget {
  SignInPage({Key key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _emailKey = GlobalKey<FormState>();
  final _passKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  AuthService _authService = AuthService();
  GlobalKey _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Giriş Yap"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flex(
              direction: Axis.vertical,
              children: [
                Form(
                  key: _emailKey,
                  child: TextFormField(
                    controller: _emailController,
                    validator: (value) => validateEmail(value),
                    decoration: InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12),
                Form(
                  key: _passKey,
                  child: TextFormField(
                    controller: _passController,
                    validator: (value) => validatePassword(value),
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 24),
                buildSignInButton(context),
              ],
            ),
            SignInButton(
              Buttons.GoogleDark,
              onPressed: () {
                signInGmail();
              },
            )
          ],
        ),
      ),
    );
  }

  Widget buildSignInButton(BuildContext context) {
    return SignInButtonBuilder(
      backgroundColor: Colors.grey[600],
      onPressed: () {
        if (_emailKey.currentState.validate() && _passKey.currentState.validate()) {
          _signInEmail(context);
        } else {}
      },
      text: "Giriş Yap",
      icon: Icons.email,
    );
  }

  Widget buildFormField({final key, final validator, final label, final controller}) {
    return Form(
      key: key,
      child: TextFormField(
        controller: controller,
        validator: (value) => validator(value),
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
      ),
    );
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Geçerli Bir Email Giriniz';
    else
      return null;
  }

  String validatePassword(String value) {
    if (value.isEmpty) {
      return "Bu Kısım Boş Bırakılamaz";
    } else {
      return null;
    }
  }

  _signInEmail(BuildContext context) async {
    final message = await _authService.signInWithEmailandPassword(
      context: context,
      email: _emailController.text,
      password: _passController.text,
    );
    Scaffold.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void signInGmail() async {
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final UserCredential userCredential = await _auth.signInWithCredential(credential);
    final User user = userCredential.user;

    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text("Hoşgeldin ${user.displayName}"),
      ),
    );

    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.pushReplacement(context, SlideRightRoute(page: HomePage()));
  }
}
