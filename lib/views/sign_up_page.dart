import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_builder.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final _emailKey = GlobalKey<FormState>();
  final _passKey = GlobalKey<FormState>();
  final _nameKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kayıt Ol"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 24),
        child: Column(
          children: [
            buildFormField(
              key: _emailKey,
              label: "Email",
              validator: validateEmail(_emailController.text),
              controller: _emailController,
            ),
            SizedBox(height: 12),
            buildFormField(
              secure: true,
              key: _passKey,
              label: "Password",
              validator: validatePassword(_passController.text),
              controller: _passController,
            ),
            SizedBox(height: 12),
            buildFormField(
              controller: _nameController,
              key: _nameKey,
              label: "Name",
            ),
            SizedBox(height: 12),
            SignInButtonBuilder(
              backgroundColor: Colors.grey,
              text: "Kayıt Ol",
              icon: Icons.person_add,
              onPressed: () {
                if (_emailKey.currentState.validate() && _passKey.currentState.validate()) {
                  print("oldu");
                } else {
                  print("olmadı");
                }
                _registerNew();
              },
            ),
          ],
        ),
      ),
    );
  }

  Form buildFormField({
    final key,
    final validator,
    final label,
    final controller,
    final secure = false,
  }) {
    return Form(
      key: key,
      child: TextFormField(
        obscureText: secure,
        controller: controller,
        validator: (value) => validator,
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

  void _registerNew() async {
    try {
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passController.text,
      );
      final User user = userCredential.user;

      if (user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Merhaba ${_nameController.text}"),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Hata Oldu"),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (er) {
      print(er);
    }
  }
}
