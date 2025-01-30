import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> emailSignIn(String user, password) async {
    try {
      UserCredential fbUser = await _auth.signInWithEmailAndPassword(
          email: user, password: password);
      if (fbUser.user != null) {
        return "";
      }
      return "error";
    } on FirebaseAuthException catch (error) {
      return error.code;
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

  Future<void> logOut() async {
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
