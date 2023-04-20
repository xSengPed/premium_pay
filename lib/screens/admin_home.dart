import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_flushbar/flutter_flushbar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_yt_app/components/admin_member_card.dart';
import 'package:flutter_yt_app/components/admin_view_detail_sheet.dart';
import 'package:flutter_yt_app/components/alert.dart';
import 'package:flutter_yt_app/components/create_member_bottomsheet.dart';
import 'package:flutter_yt_app/components/sx_button.dart';
import 'package:flutter_yt_app/components/top_navigator.dart';
import 'package:flutter_yt_app/configs/size_config.dart';
import 'package:flutter_yt_app/models/user_profile.dart';
import 'package:flutter_yt_app/services/firestore_services.dart';
import 'package:responsive_grid/responsive_grid.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  List<UserProfile> subscribedMembers = [];

  _fetchSubscribedMembers({bool isFromCreate = false}) async {
    log('fetch member list');
    EasyLoading.show(status: "");
    final temp = await FirestoreServices.getSubscribedMemberList();
    EasyLoading.dismiss();
    if (isFromCreate == true) {
      Flushbar(
        flushbarPosition: FlushbarPosition.TOP,
        flushbarStyle: FlushbarStyle.FLOATING,
        backgroundColor: Colors.green[700]!,
        messageSize: 1.4 * 10,
        message: "สร้างสมาชิกใหม่ สำเร็จ",
        duration: const Duration(milliseconds: 1500),
        padding: EdgeInsets.only(
          left: 1.2 * 10,
          right: 1.2 * 10,
          bottom: 1.2 * 10,
        ),
      ).show(context);
    }
    setState(() {
      subscribedMembers = temp;
    });
  }

  @override
  void initState() {
    _fetchSubscribedMembers();
    super.initState();
  }

  void addNewMember(BuildContext context) async {
    try {
      await FirestoreServices.getCreatePermission();
      await showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
        isScrollControlled: true,
        builder: (context) {
          return CreateMemberActionSheet(
            onCreateComplete: () async {
              _fetchSubscribedMembers(isFromCreate: true);
            },
          );
        },
      );
    } catch (e) {
      final err_data = jsonDecode(jsonEncode(e));
      Alert().show(
        context,
        okOnly: true,
        descAlignment: MainAxisAlignment.center,
        title: err_data["title"],
        desc: err_data["desc"],
      );
    }
  }

  void viewDetail(UserProfile subscribedMembers) {
    showDialog(
      context: context,
      barrierDismissible: false,
      useSafeArea: true,
      builder: (context) =>
          AdminViewDetailSheet(subscribeMember: subscribedMembers),
    );
  }

  List getMemberList(List<UserProfile> members) {
    return members.map((UserProfile user) {
      return Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              user.name.toString(),
            ),
          ],
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final double defaultSize = SizeConfig.defaultSize;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            child: SvgPicture.asset('assets/bg/wave-haikei-mobile.svg',
                fit: BoxFit.cover),
          ),

          Column(
            children: [
              TopNavigator(
                color: Colors.red,
              ),
              Flexible(
                  child: ResponsiveGridList(
                desiredItemWidth: MediaQuery.of(context).size.width / 2,
                minSpacing: 10,
                children: [
                  ...getMemberList(subscribedMembers),
                ],
              )),
            ],
          ),
          // SingleChildScrollView(
          //   child: ResponsiveGridRow(children: [
          //     ...getMemberList(subscribedMembers),
          //   ]),
          // ),
        ],
      ),
    );
  }
}
