import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_yt_app/components/middleware_alert.dart';
import 'package:flutter_yt_app/services/auth_service.dart';

class SignInController extends ChangeNotifier {
  bool toggleHiddenPassword = true;
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
      MiddelwareAlert.show(context, err);
      EasyLoading.dismiss();
    }
  }

  checkAuth() async {
    await AuthService.isUserAuth();
  }
}
