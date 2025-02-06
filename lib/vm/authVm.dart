import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meetworth_admin/widgets/sidebar.dart';

import '../screens/auth/login.dart';

final authVm = ChangeNotifierProvider<AuthVm>((ref) => AuthVm());

class AuthVm with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String isLoadingFor = '';
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void setLoadingF([bool v = true, String? name]) {
    _isLoading = v;
    if (v) {
      isLoadingFor = name ?? '';
    } else {
      isLoadingFor = '';
    }
    notifyListeners();
  }

  Future loginF(context,
      {bool showLoading = false,
      String loadingFor = "",
      String email = "",
      String password = ""}) async {
    setLoadingF(true, loadingFor);

    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        EasyLoading.showInfo("🛜 Network Not Available");
        return;
      }

      if (email.isEmpty) {
        EasyLoading.showInfo("Email is required");
        return;
      }
      if (password.isEmpty) {
        EasyLoading.showInfo("Password is required");
        return;
      }

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      if (userCredential.user == null) {
        EasyLoading.showInfo("Login failed. Please try again.");
        return;
      } else {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const SidebarWidget()));
      }

      notifyListeners();
      EasyLoading.showSuccess("Login Successfully");
      // var v = await Config().getConfig();
    } on FirebaseAuthException catch (e) {
      debugPrint("FirebaseAuthException: $e");
      String errorMessage;

      switch (e.code) {
        case 'user-not-found':
          errorMessage = "User not found";
          break;
        case 'wrong-password':
          errorMessage = "Incorrect password";
          break;
        case 'invalid-email':
          errorMessage = "Invalid email address";
          break;
        case 'user-disabled':
          errorMessage = "User account has been disabled";
          break;
        case 'too-many-requests':
          errorMessage = "Too many requests. Try again later";
          break;
        case 'invalid-credential':
          errorMessage =
              "Invalid credentials. Please check your email and password.";
          break;
        case 'network-request-failed':
          errorMessage = "Please check your network connection.";
          break;
        default:
          errorMessage = "Login failed. Please try again.";
          break;
      }
      EasyLoading.showInfo(errorMessage);
    } catch (e, st) {
      EasyLoading.showError("$e");
      debugPrint("💥 error: $e , st:$st");
    } finally {
      setLoadingF(false);
    }
  }

  /////////
  Future<String> forgotPasswordF(
      {bool showLoading = false,
      String loadingFor = "",
      required String email}) async {
    try {
      if (showLoading) {
        setLoadingF(true, loadingFor);
      }

      if (email.isEmpty) {
        EasyLoading.showInfo("Email is required");
        return "";
      }
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: email)
          .then((v) {
        EasyLoading.showSuccess("Email Sent For Reset Password.");
      });

      setLoadingF(false);
      return "";
    } on FirebaseAuthException catch (error) {
      return error.code;
    }
  }

  Future<void> logOut(context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
  }
}
