import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> emailSignIn(String user, password) async {
    try {
      UserCredential fbUser = await _auth.signInWithEmailAndPassword(
          email: user, password: password);
      if (fbUser.user != null) {
        return true;
      }
      return false;
    } on FirebaseAuthException catch (error) {
      EasyLoading.showError(error.code);
      debugPrint("💥 emailSignIn error: $error");
      return false;
    }
  }

  Future<String> forgetPassword(String mail) async {
    try {
      await _auth.sendPasswordResetEmail(email: mail);
      return "";
    } on FirebaseAuthException catch (error) {
      return error.code;
    }
  }

  Future<void> logOut(context) async {
    await _auth.signOut();
    // got to login screen
  }

  bool checkUser() {
    User? fbUser = _auth.currentUser;
    if (fbUser != null) {
      return true;
    } else {
      return false;
    }
  }
}
