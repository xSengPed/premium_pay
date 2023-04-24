import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_yt_app/components/button.dart';
import 'package:flutter_yt_app/components/setting_overlay.dart';
import 'package:flutter_yt_app/components/sx_button.dart';
import 'package:flutter_yt_app/models/user_profile.dart';
import 'package:flutter_yt_app/services/firestore.service.dart';

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
      await fetchMembers();
    } on Exception {
      log('GENERIC ERROR');
    } catch (err) {
      log('CLASSIFY ERROR');
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
      log('submit error');
      EasyLoading.dismiss();
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
                        Text('Delete Member'),
                      ],
                    ),
                    onClick: () => Navigator.pop(context),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [Text("Delete Desc")],
                  ),
                ),
                Row(
                  children: [
                    SxButton(
                      label: "Delete",
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
                        }
                      },
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    SxButton(
                      label: "Cancel",
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
}
