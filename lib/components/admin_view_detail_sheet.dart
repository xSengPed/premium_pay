import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_yt_app/components/alert.dart';
import 'package:flutter_yt_app/components/sx_button.dart';
import 'package:flutter_yt_app/configs/size_config.dart';
import 'package:flutter_yt_app/models/user_profile.dart';

class AdminViewDetailSheet extends StatefulWidget {
  final UserProfile subscribeMember;
  const AdminViewDetailSheet({super.key, required this.subscribeMember});

  @override
  State<AdminViewDetailSheet> createState() => _AdminViewDetailSheetState();
}

class _AdminViewDetailSheetState extends State<AdminViewDetailSheet> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController expiredDateController = TextEditingController();
  bool isEditFlag = false;
  bool isPaid = false;

  @override
  void initState() {
    startDateController.text = widget.subscribeMember.lastPaid ?? "";
    expiredDateController.text = widget.subscribeMember.expired ?? "";

    setState(() {
      isPaid = widget.subscribeMember.paid ?? false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final double defaultSize = SizeConfig.defaultSize;
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      padding: EdgeInsets.all(1.6 * defaultSize),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: Text(
                  "โปรไฟล์สมาชิก",
                  style: TextStyle(
                      fontSize: 1.6 * defaultSize, fontWeight: FontWeight.w600),
                )),
                GestureDetector(
                  child: Icon(Icons.close),
                  onTap: () => Navigator.pop(context),
                ),
              ],
            ),
            SizedBox(
              height: 1.6 * defaultSize,
            ),
            Row(
              children: [
                Spacer(),
                Text("แก้ไขข้อมูล",
                    style: TextStyle(
                      fontSize: 1.2 * defaultSize,
                      fontWeight: FontWeight.w600,
                    )),
                SizedBox(
                  width: 1.4 * defaultSize,
                ),
                SizedBox(
                  height: 4.0 * defaultSize,
                  child: CupertinoSwitch(
                    value: isEditFlag,
                    onChanged: (bool value) {
                      if (isEditFlag == true) {
                        Alert().show(
                          context,
                          title: "บันทึกการเปลี่ยนแปลง",
                          descAlignment: MainAxisAlignment.center,
                          desc: "ระบบจะทำการบันทึก การเปลี่ยนแปลงที่เกิดขึ้น",
                          okText: "บันทึก",
                          cancelText: "ยกเลิก",
                          okSubmit: () {
                            setState(() {
                              isEditFlag = false;
                            });
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                        );
                      } else {
                        setState(() {
                          isEditFlag = true;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 1.6 * defaultSize,
            ),
            TextFormField(
              enabled: false,
              initialValue: widget.subscribeMember.name,
              decoration: InputDecoration(
                  label: Text('ชื่อ'),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 1.6 * defaultSize,
            ),
            TextFormField(
              enabled: false,
              initialValue: widget.subscribeMember.email,
              decoration: InputDecoration(
                  label: Text('อีเมล์'),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 1.6 * defaultSize,
            ),
            Row(
              children: [
                Flexible(
                  child: TextFormField(
                      controller: startDateController,
                      readOnly: true,
                      enabled: isEditFlag,
                      onTap: () async {
                        DateTime? startDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate:
                                DateTime.now().subtract(Duration(days: 366)),
                            lastDate: DateTime.now().add(Duration(days: 366)));
                        if (startDate != null) {
                          final expiredDate =
                              startDate.add(Duration(days: 366));
                          startDateController.text =
                              startDate.toIso8601String().split("T").first;
                          expiredDateController.text =
                              expiredDate.toIso8601String().split("T").first;
                        }
                      },
                      decoration: InputDecoration(
                          label: Text('ชำระล่าสุด'),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder())),
                ),
                SizedBox(
                  width: 1.6 * defaultSize,
                ),
                Flexible(
                  child: TextFormField(
                      controller: expiredDateController,
                      readOnly: true,
                      enabled: isEditFlag,
                      decoration: InputDecoration(
                          label: Text('หมดอายุ'),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder())),
                ),
              ],
            ),
            SizedBox(
              height: 1.6 * defaultSize,
            ),
            Row(
              children: [
                Flexible(
                  child: TextFormField(
                    enabled: isEditFlag,
                    decoration: InputDecoration(
                        label: Text('ค่ารายปี'),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder()),
                  ),
                ),
                SizedBox(
                  width: 1.6 * defaultSize,
                ),
                Spacer()
              ],
            ),
            SizedBox(
              height: 1.6 * defaultSize,
            ),
            if (isEditFlag == true)
              Row(
                children: [
                  Spacer(),
                  Text("ทำเครื่องหมายว่าชำระเงินแล้ว",
                      style: TextStyle(
                        fontSize: 1.2 * defaultSize,
                        fontWeight: FontWeight.w600,
                      )),
                  SizedBox(
                    width: 1.4 * defaultSize,
                  ),
                  CupertinoSwitch(
                    value: isPaid,
                    onChanged: (bool value) {
                      setState(() {
                        isPaid = value;
                      });
                    },
                  ),
                ],
              ),
            Spacer(),
            Divider(),
            SizedBox(
              height: 4.0 * defaultSize,
              child: SxButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Icon(
                      //   Icons.save,
                      //   color: Colors.white,
                      // ),
                      Text('ลบ'),
                    ],
                  ),
                  backgroundColor:
                      isEditFlag == true ? Colors.red[800] : Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
