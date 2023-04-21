import 'dart:developer';

import 'package:flutter/material.dart';
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
      users = await FirestoreService.getUserList();
      notifyListeners();
    } on Exception {
      log('GENERIC ERROR');
    } catch (err) {
      log('CLASSIFY ERROR');
    }
  }
}
