import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_builder.dart';

import 'home_page.dart';

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
            Form(
              key: _emailKey,
              child: TextFormField(
                controller: _emailController,
                validator: (String value) => validateEmail(value),
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
                obscureText: true,
                controller: _passController,
                validator: (String value) => validatePassword(value),
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),
            ),
            SizedBox(height: 12),
            Form(
              key: _nameKey,
              child: TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: "İsim",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),
            ),
            SizedBox(height: 12),
            SignInButtonBuilder(
              backgroundColor: Colors.grey,
              text: "Kayıt Ol",
              icon: Icons.person_add,
              onPressed: () {
                if (_emailKey.currentState.validate() && _passKey.currentState.validate()) {
                  print("validate");
                  _registerNew();
                } else {
                  print("olmadı");
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value))
      return ('Geçerli Bir Email Giriniz');
    else
      return null;
  }

  String validatePassword(String value) {
    if (value.isEmpty) {
      return "Bu Kısım Boş Bırakılamaz";
    } else if (value.length < 6) {
      return "Şifre en az 6 karakter olmalıdır";
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

        Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => HomePage(),
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Hata: Zayıf Parola"),
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Hata. Bu Email Kullanılmaktadır"),
          ),
        );
      }
    } catch (er) {
      print(er);
    }
  }
}
