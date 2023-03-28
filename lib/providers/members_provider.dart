import 'package:flutter/material.dart';
import 'package:flutter_yt_app/models/user_profile.dart';

class MembersProvider extends ChangeNotifier {
  List<UserProfile> subscribedMembers = [];

  void fetchMembers() async {
    try {
      notifyListeners();
    } catch (e) {}
  }
}
