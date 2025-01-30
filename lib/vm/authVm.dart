import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/authModel.dart';
import '../sotrage/userstorage.dart';

final authVm = ChangeNotifierProvider<AuthVm>((ref) => AuthVm());

class AuthVm with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoadingF(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  AuthModel? _user;
  AuthModel get userProfile => _user!;
  Future<AuthModel?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final uid = prefs.getString(UserStorage.uidKey).toString();
    final email = prefs.getString(UserStorage.emailKey).toString();
    _user = AuthModel.fromJson({
      "uid": uid,
      "email": email,
    });
    notifyListeners();
    return _user;
  }

  Future loginF(context, {String email = "", String password = ""}) async {
    isLoadingF = true;

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

      // debugPrint("👉 userCredential: $userCredential");

      DocumentSnapshot userDoc = await _firestore
          .collection('users')
          .doc(userCredential.user?.uid)
          .get();
      if (userDoc.exists) {
        _user = AuthModel.fromJson(userDoc.data() as Map<String, dynamic>);
      }

      await UserStorage.setUserF(
        uid: userCredential.user!.uid.toString(),
        email: _user!.email.toString(),
      );
      notifyListeners();
      EasyLoading.showInfo("Login Successfully");
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
      isLoadingF = false;
    }
  }
}
