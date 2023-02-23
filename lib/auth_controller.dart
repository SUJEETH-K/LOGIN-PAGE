import 'dart:html';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_auth/Screens/Welcome/welcome_screen.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'Screens/Login/login_screen.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  late Rx<User?> _user;
  FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseAuth get auth => _auth;

  set auth(FirebaseAuth auth) {
    _auth = auth;
  }

  @override
  void onReady() {
    super.onReady();
    var rx = Rx<User?>(auth.currentUser);
    _user = rx;

    _user.bindStream(auth.userChanges());
    ever(_user, _initialScreen);
  }

  _initialScreen(User? user) {
    if (user == null) {
      print("login page");
      Get.offAll(() => LoginScreen());
      Get.offAll(() => WelcomeScreen());
    }
  }

  void register(String trim, String trim2) async {
     try {
    dynamic auth;
    await auth.createUserWithEmailAndpassword(email: trim, password: trim2);
  } catch (e) {
    var snackbar = Get.snackbar("About User", "User message",
        backgroundColor: Colors.redAccent,
        snackPosition: SnackPosition.BOTTOM,
        titleText: Text(
          "Account Creation Failed",
          style: TextStyle(color: Colors.white),
        ),
        messageText: Text(e.toString(), style: TextStyle(color: Colors.white)));
  }
  }
}
