import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:news_app/services/navigation_service.dart';
import 'package:news_app/states/sncakbar_message_state.dart';
import 'package:news_app/views/home_page.dart';
import 'package:news_app/views/widgets/snackbar.dart';
import 'package:provider/provider.dart';

class AuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  NavigationService _navigator = NavigationService();

  signInWithEmailandPassword({String email, String password, BuildContext context}) async {
    final showSnackBar = ShowSnackBar();
    final value = Provider.of<SnackBarMessage>(context, listen: false);
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User user = userCredential.user;

      value.changeSnackbarMessage("Hoş Geldiniz ${user.email}");

      showSnackBar.scaffoldMessenger(context: context);
      _navigator.goToNewPage(context: context, newPage: HomePage());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        value.changeSnackbarMessage("Hata: Kullanıcı Bulunamadı");
        showSnackBar.scaffoldMessenger(context: context);
      } else if (e.code == 'wrong-password') {
        value.changeSnackbarMessage("Hata: Şifre Hatalı");

        showSnackBar.scaffoldMessenger(context: context);
      }
    }
  }

  signInGmail({BuildContext context}) async {
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final UserCredential userCredential = await _auth.signInWithCredential(credential);
    final User user = userCredential.user;
    final value = Provider.of<SnackBarMessage>(context, listen: false);
    final showSnackBar = ShowSnackBar();

    value.changeSnackbarMessage("Hoşgeldin ${user.displayName}");

    showSnackBar.scaffoldMessenger(context: context);

    _navigator.goToNewPage(context: context, newPage: HomePage());
  }

  registerNew({BuildContext context, final email, final password}) async {
    final value = Provider.of<SnackBarMessage>(context, listen: false);
    final showSnackBar = ShowSnackBar();

    try {
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User user = userCredential.user;

      if (user != null) {
        value.changeSnackbarMessage("Merhaba $email");
        showSnackBar.scaffoldMessenger(context: context);
        _navigator.goToNewPage(context: context, newPage: HomePage());
      } else {
        value.changeSnackbarMessage("Hata Oldu");
        showSnackBar.scaffoldMessenger(context: context);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        value.changeSnackbarMessage("Hata: Zayıf Parola");
        showSnackBar.scaffoldMessenger(context: context);
      } else if (e.code == 'email-already-in-use') {
        value.changeSnackbarMessage("Hata: Bu Email Kullanılmaktadır");
        showSnackBar.scaffoldMessenger(context: context);
      }
    } catch (er) {
      value.changeSnackbarMessage("Bilinmeyen Hata:${er.toString()}");
      showSnackBar.scaffoldMessenger(context: context);
    }
  }
}
