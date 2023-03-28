import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_yt_app/models/user_profile.dart';

enum YtUser {
  admin,
  member,
}

class FirestoreServices {
  static FirebaseFirestore? firestore;
  FirestoreServices.init() {
    firestore = FirebaseFirestore.instance;
  }

  static Future<int> getSubscribedMember() async {
    firestore = FirebaseFirestore.instance;
    String collectionName = "subscribe_member";
    try {
      final CollectionReference collectionReference =
          firestore!.collection(collectionName);
      final QuerySnapshot querySnapshot = await collectionReference.get();
      return querySnapshot.docs.length;
    } catch (e) {
      throw e;
    }
  }

  static Future<bool> getCreatePermission() async {
    try {
      final int memberCount = await getSubscribedMember();
      if (memberCount >= 0 && memberCount != 6) {
        return true;
      } else {
        throw {
          "title": "ไม่สามารถเพิ่มสมาชิกได้",
          "desc": "เนื่องจากจำนวนสมาชิก ได้ถูกเพิ่มครบแล้ว",
        };
      }
    } catch (e) {
      throw e;
    }
  }

  static Future<UserProfile?> getUserProfile(String email) async {
    try {
      final Query query = firestore!
          .collection("subscribe_member")
          .where("email", isEqualTo: email);
      final snapshot = await query.get();
      String encodedJson = jsonEncode(snapshot.docs.first.data());
      return UserProfile.fromJson(jsonDecode(encodedJson));
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  static createSubscribedMember(UserProfile member) async {
    try {
      await firestore!.collection("subscribe_member").add(member.toJson());
    } catch (e) {
      log(e.toString());
      throw e;
    }
  }

  static Future<List<UserProfile>> getSubscribedMemberList() async {
    try {
      final QuerySnapshot querySnapshot =
          await firestore!.collection("subscribe_member").get();
      return querySnapshot.docs
          .map((e) => UserProfile.fromJson(jsonDecode(jsonEncode(e.data()))))
          .toList();
    } catch (e) {
      throw e;
    }
  }
}
