import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_yt_app/models/user_profile.dart';

enum YtUser {
  admin,
  member,
}

class FirestoreServices {
  static FirebaseFirestore? firestore;
  FirestoreServices.init() {
    log('init fs');
    firestore = FirebaseFirestore.instance;
  }

  static getSubscribedMember() async {
    firestore = FirebaseFirestore.instance;
    String collectionName = "subscribe_member";
    try {
      final CollectionReference collectionReference =
          firestore!.collection(collectionName);
      final QuerySnapshot querySnapshot = await collectionReference.get();
      log(querySnapshot.docs.length.toString());
    } catch (e) {
      log(e.toString());
    }
  }

  static Future<UserProfile?> getUserProfile(String email) async {
    try {
      final Query query = firestore!
          .collection("subscribe_member")
          .where("gmail", isEqualTo: email);
      final snapshot = await query.get();
      String encodedJson = jsonEncode(snapshot.docs.first.data());
      return UserProfile.fromJson(jsonDecode(encodedJson));
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
