import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_yt_app/models/user_profile.dart';

class FirestoreService {
  static late FirebaseFirestore fs;
  static String subscibedMemberPath = "subscribe_member";
  FirestoreService.init() {
    fs = FirebaseFirestore.instance;
  }

  static Future getUserList() async {
    try {
      final CollectionReference collectionReference =
          fs.collection(subscibedMemberPath);
      final QuerySnapshot querySnapshot = await collectionReference.get();
      return querySnapshot.docs
          .map((e) => UserProfile.fromJson(jsonDecode(jsonEncode(e.data()))))
          .toList();
    } catch (err) {
      throw Exception();
    }
  }
}
