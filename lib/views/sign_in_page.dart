import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:news_app/services/auth_service.dart';
import 'package:news_app/services/validator_service.dart';
import 'package:news_app/states/sncakbar_message_state.dart';
import 'package:news_app/views/widgets/form_field.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  SignInPage({Key key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  ValidatorService _validator = ValidatorService();

  GlobalKey<FormState> _emailKey = GlobalKey<FormState>();
  GlobalKey<FormState> _passKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Consumer<SnackBarMessage>(
      builder: (BuildContext context, value, Widget child) {
        return Scaffold(
          appBar: _appBar,
          body: Padding(
            padding: EdgeInsets.symmetric(vertical: 24, horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flex(
                  direction: Axis.vertical,
                  children: [
                    BuildFormField(
                      controller: _emailController,
                      formKey: _emailKey,
                      label: "Email",
                      secure: false,
                      validator: (email) => _validator.validateEmail(email),
                    ),
                    SizedBox(height: 12),
                    BuildFormField(
                      controller: _passController,
                      formKey: _passKey,
                      label: "Password",
                      secure: true,
                      validator: (password) => _validator.validatePassword(password),
                    ),
                    SizedBox(height: 24),
                    buildSignInButton(),
                  ],
                ),
                signInWithGoogleButton(context)
              ],
            ),
          ),
        );
      },
    );
  }

  AppBar get _appBar => AppBar(
        title: Text("Giriş Yap"),
      );

  SignInButton signInWithGoogleButton(BuildContext context) {
    return SignInButton(
      Buttons.GoogleDark,
      onPressed: () {
        _authService.signInGmail(context: context);
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
}
