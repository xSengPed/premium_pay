import 'dart:convert';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_yt_app/models/user_profile.dart';

class FirestoreService {
  static late FirebaseFirestore fs;
  static String subscibedMemberPath = "subscribe_member";
  FirestoreService.init() {
    fs = FirebaseFirestore.instance;
  }

  static final CollectionReference collectionReference =
      fs.collection(subscibedMemberPath);

  static Future<void> testInjectMemberData() async {
    final List<UserProfile> users = [
      UserProfile(
        admin: true,
        name: "Donnukrit Satirakul",
        email: "kalima007c@gmail.com",
        expired: "N/A",
        lastPaid: "N/A",
        paid: true,
        mobileNo: "091-053-3948",
        overdue: 0,
      ),
      UserProfile(
        name: "Pimwipha Sakulkham",
        email: "m.peaw5500@gmail.com",
        expired: "04-04-2024",
        lastPaid: "N/A",
        paid: false,
        mobileNo: "N/A",
        overdue: 600,
      ),
      UserProfile(
        name: "Peerapatch Angsiyanon",
        email: "caramel.peerapatch@gmail.com",
        expired: "04-04-2024",
        lastPaid: "N/A",
        paid: false,
        mobileNo: "N/A",
        overdue: 600,
      ),
      UserProfile(
        name: "Kong Natthanon",
        email: "kong1558@gmail.com",
        expired: "04-04-2024",
        lastPaid: "N/A",
        paid: false,
        mobileNo: "N/A",
        overdue: 600,
      ),
      UserProfile(
        name: "Teerapong Nithiporndacha",
        email: "nithiporndacha@gmail.com",
        expired: "04-04-2024",
        lastPaid: "N/A",
        paid: false,
        mobileNo: "N/A",
        overdue: 600,
      ),
      UserProfile(
        name: "Danupat Rattanapong",
        email: "danupatjom20@gmail.com",
        expired: "04-04-2024",
        lastPaid: "N/A",
        paid: true,
        mobileNo: "N/A",
        overdue: 0,
      ),
    ];
    try {
      await collectionReference.get().then((snapshot) {
        if (snapshot.docs.length >= 6) {
          throw {
            "code": 2001,
            "desc": "Maximum member limit",
          };
        }
      });
      users.forEach((element) async {
        await collectionReference.add(element.toJson());
      });

      log('[Inject] - Done!');
    } catch (err) {
      log('[Inject] - Failed!');
      log(err.toString());
    }
  }

  static Future<List<UserProfile>> getUserList() async {
    try {
      final QuerySnapshot querySnapshot = await collectionReference.get();
      return querySnapshot.docs
          .map((e) => UserProfile.fromJson(jsonDecode(jsonEncode(e.data()))))
          .toList();
    } catch (err) {
      throw Exception();
    }
  }

  static Future<void> updateMember(UserProfile user) async {
    try {
      final id = await collectionReference
          .where("uuid", isEqualTo: user.uuid)
          .limit(1)
          .get()
          .then((value) {
        if (value.docs.length == 1) {
          return value.docs.first.id;
        } else {
          throw {
            "code": 5000,
            "desc": "Generic Error",
          };
        }
      });

      await collectionReference.doc(id).update(user.toJson());
    } catch (err) {
      throw err;
    }
  }

  static Future<void> createMember(UserProfile user) async {
    try {
      await collectionReference.get().then((snapshot) {
        if (snapshot.docs.length >= 6) {
          throw {
            "code": "4001",
            "desc": "cannot create more member max limit (6) "
          };
        }
      });
      await collectionReference.add(user.toJson());
    } catch (err) {
      throw err;
    }
  }

  static Future<void> deleteMember(UserProfile user) async {
    try {
      if (user.admin == true) {
        throw {"code": 4007, "desc": "Cannot Delete Admin"};
      }
      final id = await collectionReference
          .where("uuid", isEqualTo: user.uuid)
          .limit(1)
          .get()
          .then((value) {
        if (value.docs.length == 1) {
          return value.docs.first.id;
        } else {
          throw {
            "code": 5000,
            "desc": "Generic Error",
          };
        }
      });
      await collectionReference.doc(id).delete();
    } catch (err) {
      throw err;
    }
  }
}
