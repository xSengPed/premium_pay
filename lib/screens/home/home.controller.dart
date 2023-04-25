import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_yt_app/components/payment_overlay.dart';
import 'package:flutter_yt_app/models/user_profile.dart';
import 'package:flutter_yt_app/services/firestore.service.dart';

class HomeController extends ChangeNotifier {
  BuildContext context;
  List<UserProfile> users = [];
  HomeController({required this.context}) {
    _init();
  }
  _init() async {
    try {
      EasyLoading.show(status: "");
      users = await FirestoreService.getUserList();

      notifyListeners();
      EasyLoading.dismiss();
    } on Exception {
      log('GENERIC ERROR');
    } catch (err) {
      log('CLASSIFY ERROR');
    }
  }

  showPaymentOverlay() {
    showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) {
        return PaymentOverlay();
      },
    );
  }
}
