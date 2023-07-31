import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_yt_app/components/button.dart';
import 'package:flutter_yt_app/components/middleware_alert.dart';
import 'package:flutter_yt_app/components/sx_button.dart';
import 'package:flutter_yt_app/models/user_profile.dart';
import 'package:flutter_yt_app/screens/admin/admin.controller.dart';
import 'package:flutter_yt_app/services/firestore.service.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AddMemberOverlay extends StatefulWidget {
  final AdminController controller;
  const AddMemberOverlay({super.key, required this.controller});

  @override
  State<AddMemberOverlay> createState() => _AddMemberOverlayState();
}

class _AddMemberOverlayState extends State<AddMemberOverlay> {
  MaskTextInputFormatter mobileNoFormat =
      MaskTextInputFormatter(mask: "###-###-####");
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final InputDecoration defaultDecoration = InputDecoration(
        filled: true,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none);
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Text("Add Member",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                Spacer(),
                Button(
                  child: Icon(Icons.close),
                  onClick: () => Navigator.pop(context),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Flexible(
                  child: TextFormField(
                    controller: nameController,
                    decoration: defaultDecoration.copyWith(hintText: "ชื่อ"),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                children: [
                  Flexible(
                    child: TextFormField(
                      controller: emailController,
                      decoration:
                          defaultDecoration.copyWith(hintText: "E-Mail"),
                    ),
                  ),
                  SizedBox(width: 16),
                  Spacer(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                children: [
                  Flexible(
                    child: TextFormField(
                      controller: mobileController,
                      inputFormatters: [mobileNoFormat],
                      decoration: defaultDecoration.copyWith(hintText: "TEL."),
                    ),
                  ),
                  SizedBox(width: 16),
                  Spacer(),
                ],
              ),
            ),
            Spacer(),
            Row(
              children: [
                SxButton(
                  height: 45,
                  label: "บันทึกการเปลี่ยนแปลง",
                  backgroundColor: Color(0xffBD395D),
                  labelStyle: TextStyle(color: Colors.white),
                  onClick: () async {
                    try {
                      EasyLoading.show(status: "");
                      await FirestoreService.createMember(UserProfile(
                        name: nameController.text,
                        admin: false,
                        email: emailController.text,
                        expired: "N/A",
                        lastPaid: "N/A",
                        paid: false,
                        mobileNo: mobileController.text,
                      ));

                      widget.controller.fetchMembers();

                      EasyLoading.dismiss();
                      Navigator.pop(context);
                    } catch (err) {
                      EasyLoading.dismiss();
                      MiddelwareAlert.show(context, err);
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
