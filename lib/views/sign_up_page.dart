import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_builder.dart';
import 'package:news_app/services/auth_service.dart';
import 'package:news_app/services/validator_service.dart';
import 'package:news_app/views/widgets/form_field.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  ValidatorService _validator = ValidatorService();
  AuthService _authService = AuthService();
  final _emailKey = GlobalKey<FormState>();
  final _passKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 24),
        child: Column(
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
            SizedBox(height: 12),
            buildSignUpButtonBuilder(context),
          ],
        ),
      ),
    );
  }

  Widget get _appBar {
    return AppBar(
      title: Text("Kayıt Ol"),
    );
  }

  SignInButtonBuilder buildSignUpButtonBuilder(BuildContext context) {
    return SignInButtonBuilder(
      backgroundColor: Colors.grey,
      text: "Kayıt Ol",
      icon: Icons.person_add,
      onPressed: () {
        if (_emailKey.currentState.validate() && _passKey.currentState.validate()) {
          _authService.registerNew(
            context: context,
            email: _emailController.text,
            password: _passController.text,
          );
        } else {}
      },
    );
  }
}
