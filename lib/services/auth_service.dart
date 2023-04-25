import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthService {
  static Future signinWithEmail(BuildContext context,
      {required String email, required String password}) async {
    FirebaseAuth auth = await FirebaseAuth.instance;

    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      GoRouter.of(context).pushReplacement("/admin");
    } catch (err) {
      if (err.toString().contains("[firebase_auth/invalid-email]")) {
        throw {
          "code": 4001,
          "err_data": {
            "title": "รูปแบบอีเมลล์ไม่ถูกต้อง",
            "desc": "กรุณาลองใหม่อีกครั้ง"
          },
        };
      } else if (err.toString().contains("firebase_auth/wrong-password")) {
        throw {
          "code": 4002,
          "err_data": {
            "title": "รหัสผ่านไม่ถูกต้อง",
            "desc": "กรุณาลองใหม่อีกครั้ง"
          },
        };
      } else {
        throw {
          "code": 5000,
          "err_data": {
            "title": "ไม่สามารถทำรายการได้",
            "desc": "กรุณาลองใหม่อีกครั้ง"
          },
        };
      }
    }
  }

  static Future<void> signOut() async {
    FirebaseAuth auth = await FirebaseAuth.instance;

    try {
      auth.signOut();
    } catch (err) {
      throw {
        "code": 5000,
        "err_data": {
          "title": "ไม่สามารถทำรายการได้",
          "desc": "กรุณาลองใหม่อีกครั้ง"
        },
      };
    }
  }

  static Future<bool> isUserAuth() async {
    try {
      FirebaseAuth auth = await FirebaseAuth.instance;

      if (auth.currentUser?.uid == null || auth.currentUser?.email == null) {
        throw {
          "code": 5000,
          "err_data": {
            "title": "ไม่สามารถทำรายการได้",
            "desc": "กรุณาลองใหม่อีกครั้ง"
          },
        };
      } else {
        log('user already login');
        return true;
      }
    } catch (err) {
      return false;
    }
  }
}
