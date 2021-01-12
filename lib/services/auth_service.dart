import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_app/services/navigation_service.dart';
import 'package:news_app/views/home_page.dart';

class AuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  NavigationService _navigator = NavigationService();

  signInWithEmailandPassword({String email, String password, BuildContext context}) async {
    try {
      UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(email: email, password: password);
      final User user = userCredential.user;

      final message = "Hoş Geldiniz ${user.email}";

      _navigator.goToNewPage(context: context, newPage: HomePage());
      return message;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        final snackBar = SnackBar(
          content: Text("Hata: Kullanıcı Bulunamadı"),
        );
        return snackBar;
      } else if (e.code == 'wrong-password') {
        final snackBar = SnackBar(
          content: Text("Hata: Şifre Hatalı"),
        );
        return snackBar;
      }
    }
  }
}
