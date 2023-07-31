import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_yt_app/components/add_member_overlay.dart';
import 'package:flutter_yt_app/components/alert.dart';
import 'package:flutter_yt_app/components/button.dart';
import 'package:flutter_yt_app/components/middleware_alert.dart';
import 'package:flutter_yt_app/components/setting_overlay.dart';
import 'package:flutter_yt_app/components/sx_button.dart';
import 'package:flutter_yt_app/models/user_profile.dart';
import 'package:flutter_yt_app/services/auth_service.dart';
import 'package:flutter_yt_app/services/firestore.service.dart';
import 'package:go_router/go_router.dart';

class AdminController extends ChangeNotifier {
  List<UserProfile> users = [];
  BuildContext context;

  AdminController(
    this.context,
  ) {
    _init();
  }

  _init() async {
    try {
      EasyLoading.show(status: "");
      await fetchMembers();
      EasyLoading.dismiss();
    } on Exception {
      log('GENERIC ERROR');
      EasyLoading.dismiss();
    } catch (err) {
      log('CLASSIFY ERROR');
      EasyLoading.dismiss();
    }
  }

  Future<void> fetchMembers() async {
    users = await FirestoreService.getUserList();
    notifyListeners();
  }

  Future<void> submitEdit(UserProfile newUserData) async {
    try {
      EasyLoading.show(status: "");
      await FirestoreService.updateMember(newUserData);
      await fetchMembers();
      EasyLoading.dismiss();
    } catch (err) {
      EasyLoading.dismiss();
      throw err;
    }
  }

  void showDeleteAlert(BuildContext context, {required UserProfile user}) {
    showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) {
        return Dialog(
          child: Container(
            constraints: BoxConstraints(maxWidth: 300),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  child: Button(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'ลบสมาชิก',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    onClick: () => Navigator.pop(context),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Expanded(child: Text("ลบสมาชิก ${user.name}")),
                        ],
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    SxButton(
                      label: "ลบ",
                      labelStyle: TextStyle(color: Colors.white),
                      backgroundColor: Colors.red,
                      onClick: () async {
                        try {
                          EasyLoading.show(status: "");
                          await FirestoreService.deleteMember(user);
                          await fetchMembers();
                          EasyLoading.dismiss();
                          Navigator.pop(context);
                        } catch (err) {
                          log(err.toString());
                          EasyLoading.dismiss();
                          Navigator.pop(context);
                          MiddelwareAlert.show(context, err);
                        }
                      },
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    SxButton(
                      label: "ยกเลิก",
                      labelStyle: TextStyle(color: Colors.white),
                      backgroundColor: Colors.grey,
                      onClick: () => Navigator.pop(context),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  showSettingOverlay(
    BuildContext context,
    UserProfile user,
  ) {
    showModalBottomSheet(
      context: context,
      constraints: BoxConstraints(maxWidth: 500),
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.9,
          padding: const EdgeInsets.all(16),
          child: SettingOverlay(user: user, controller: this),
        );
      },
    );
  }

  signOut(BuildContext context) {
    Alert.show(context,
        title: "ออกจากระบบ",
        description: "",
        okText: "ออกจากระบบ",
        cancelText: "ปิด",
        submitColor: Colors.red, onSubmit: () async {
      try {
        EasyLoading.show(status: "");
        await AuthService.signOut();
        GoRouter.of(context).go('/');
        EasyLoading.dismiss();
      } catch (err) {
        EasyLoading.dismiss();
      }
    });
  }

  Future<void> showAddMemberOverlay(
    AdminController ctrl,
  ) {
    return showModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      context: context,
      builder: (context) {
        return AddMemberOverlay(
          controller: ctrl,
        );
      },
    );
  }
}
