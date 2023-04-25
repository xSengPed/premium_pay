import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_yt_app/services/auth_service.dart';
import 'package:go_router/go_router.dart';

class SignInController extends ChangeNotifier {
  BuildContext context;
  SignInController(this.context) {
    _init();
  }

  _init() {}

  signInWithEmail(BuildContext context,
      {required String email, required String password}) async {
    try {
      EasyLoading.show(status: "");
      await AuthService.signinWithEmail(context,
          email: email, password: password);
      EasyLoading.dismiss();
    } catch (err) {
      EasyLoading.dismiss();
    }
  }

  checkAuth() async {
    await AuthService.isUserAuth();
  }
}
