import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_yt_app/components/button.dart';
import 'package:flutter_yt_app/components/middleware_alert.dart';
import 'package:flutter_yt_app/components/sx_button.dart';
import 'package:flutter_yt_app/models/user_profile.dart';
import 'package:flutter_yt_app/screens/admin/admin.controller.dart';
import 'package:flutter_yt_app/uitls.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class SettingOverlay extends StatefulWidget {
  final AdminController controller;

  final UserProfile user;
  const SettingOverlay({
    super.key,
    required this.controller,
    required this.user,
  });

  @override
  State<SettingOverlay> createState() => _SettingOverlayState();
}

class _SettingOverlayState extends State<SettingOverlay> {
  MaskTextInputFormatter mobileNoFormat =
      MaskTextInputFormatter(mask: "###-###-####");
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController mobileController;
  late final TextEditingController lastPaidController;
  late final TextEditingController expireDateController;
  late final TextEditingController overdueController;
  late bool paid;
  final InputDecoration defaultDecoration = InputDecoration(
      filled: true,
      enabledBorder: InputBorder.none,
      focusedBorder: InputBorder.none);
  @override
  void initState() {
    setupTextField();
    setState(() {
      paid = widget.user.paid ?? false;
    });

    super.initState();
  }

  void setupTextField() {
    nameController = TextEditingController(text: widget.user.name);
    emailController = TextEditingController(text: widget.user.email);
    mobileController = TextEditingController(text: widget.user.mobileNo);
    lastPaidController = TextEditingController(text: widget.user.lastPaid);
    expireDateController = TextEditingController(text: widget.user.expired);
    overdueController =
        TextEditingController(text: widget.user.overdue.toString());
  }

  Future<void> setPaidDate(BuildContext context,
      {bool forSwitch = false}) async {
    DateTime? lastpaidDate;
    DateTime? expiredDate;
    if (forSwitch == true) {
      lastpaidDate = DateTime.now();
    } else {
      lastpaidDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now().subtract(Duration(days: 366)),
        lastDate: DateTime.now(),
      );
    }

    if (lastpaidDate != null) {
      expiredDate = lastpaidDate.add(Duration(days: 366));

      if (paid == true) {
        setState(() {
          lastPaidController.text = Utils.formatDate(lastpaidDate!);
          expireDateController.text = Utils.formatDate(expiredDate!);
        });
      } else {
        setState(() {
          lastPaidController.text = "-";
          expireDateController.text = "-";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Row(
              children: [
                Text(
                  "แก้ไขสมาชิก",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                Spacer(),
                Button(
                  child: Icon(Icons.close),
                  onClick: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          // name
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: TextFormField(
              controller: nameController,
              decoration: defaultDecoration.copyWith(label: Text("ชื่อเต็ม")),
            ),
          ),
          // mail
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: TextFormField(
                controller: emailController,
                decoration: defaultDecoration.copyWith(label: Text("อีเมลล์"))),
          ),
          // mobile
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: TextFormField(
                controller: mobileController,
                inputFormatters: [mobileNoFormat],
                decoration:
                    defaultDecoration.copyWith(label: Text("หมายเลขโทรศัพท์"))),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Row(
              children: [
                Flexible(
                  child: TextFormField(
                    controller: lastPaidController,
                    readOnly: true,
                    enabled: paid,
                    decoration:
                        defaultDecoration.copyWith(label: Text("วันที่จ่าย")),
                    onTap: () => setPaidDate(context),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: TextFormField(
                        controller: expireDateController,
                        readOnly: true,
                        enabled: paid,
                        decoration: defaultDecoration.copyWith(
                            label: Text("วันหมดอายุ")))),
              ],
            ),
          ),

          // is Paid

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Row(
              children: [
                Text(
                  "ทำเครื่องหมายว่าชำระเงิน",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                Spacer(),
                CupertinoSwitch(
                  value: paid,
                  onChanged: (bool v) {
                    setState(() {
                      paid = v;
                    });

                    if (paid == true) {
                      setPaidDate(context, forSwitch: true);
                      setState(() {
                        overdueController.text = 0.toString();
                      });
                    } else {
                      setPaidDate(context, forSwitch: true);
                      setState(() {
                        overdueController.text = 600.toString();
                      });
                    }
                  },
                ),
              ],
            ),
          ),
          // overdue
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Row(
              children: [
                Spacer(),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                    child: TextFormField(
                        controller: overdueController,
                        readOnly: true,
                        decoration: defaultDecoration.copyWith(
                            label: Text("ยอดชำระ")))),
              ],
            ),
          ),
          Spacer(),
          Divider(),
          Row(
            children: [
              SxButton(
                height: 45,
                label: "บันทึกการเปลี่ยนแปลง",
                backgroundColor: Color(0xffBD395D),
                labelStyle: TextStyle(color: Colors.white),
                onClick: () async {
                  final UserProfile updatedUser = UserProfile();
                  updatedUser
                    ..uuid = widget.user.uuid
                    ..name = nameController.text.trim()
                    ..email = emailController.text.trim()
                    ..mobileNo = mobileController.text.trim()
                    ..paid = paid
                    ..expired = expireDateController.text.trim()
                    ..lastPaid = lastPaidController.text.trim()
                    ..overdue = int.parse(overdueController.text.trim());

                  try {
                    await widget.controller.submitEdit(updatedUser);
                    Navigator.pop(context);
                  } catch (err) {
                    MiddelwareAlert.show(context, err);
                  }
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
