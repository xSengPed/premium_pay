import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthService {
  static Future signinWithEmail(BuildContext context,
      {required String email, required String password}) async {
    FirebaseAuth auth = await FirebaseAuth.instance;

    try {
      final UserCredential user = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      GoRouter.of(context).pushReplacement("/admin");
    } catch (err) {
      log(err.toString());
      throw {
        "code": 5000,
        "desc": "Generic Error",
      };
    }
  }

  static Future<void> signOut() async {
    FirebaseAuth auth = await FirebaseAuth.instance;

    try {
      auth.signOut();
    } catch (err) {
      throw {
        "code": 5000,
        "desc": "Generic Error",
      };
    }
  }

  static Future<bool> isUserAuth() async {
    try {
      FirebaseAuth auth = await FirebaseAuth.instance;

      if (auth.currentUser?.uid == null || auth.currentUser?.email == null) {
        throw {
          "code": "5002",
          "desc": "User is not login",
        };
      } else {
        log('user already login');
        return true;
      }
    } catch (err) {
      log("ERR");

      log(err.toString());
      return false;
    }
  }
}
