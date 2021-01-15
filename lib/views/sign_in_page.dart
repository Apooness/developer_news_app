import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:news_app/services/auth_service.dart';
import 'package:news_app/states/sncakbar_message_state.dart';
import 'package:provider/provider.dart';

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
  AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Consumer<SnackBarMessage>(
      builder: (BuildContext context, value, Widget child) {
        return Scaffold(
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
                    buildSignInButton(),
                  ],
                ),
                SignInButton(
                  Buttons.GoogleDark,
                  onPressed: () {
                    _authService.signInGmail(context: context);
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildSignInButton() {
    return SignInButtonBuilder(
      backgroundColor: Colors.grey[600],
      onPressed: () async {
        if (_emailKey.currentState.validate() && _passKey.currentState.validate()) {
          await _authService.signInWithEmailandPassword(
            context: context,
            email: _emailController.text,
            password: _passController.text,
          );
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
}
