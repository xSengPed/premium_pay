import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_yt_app/components/admin_member_card.dart';
import 'package:flutter_yt_app/components/alert.dart';
import 'package:flutter_yt_app/components/create_member_bottomsheet.dart';
import 'package:flutter_yt_app/components/sx_button.dart';
import 'package:flutter_yt_app/components/top_navigator.dart';
import 'package:flutter_yt_app/configs/size_config.dart';
import 'package:flutter_yt_app/models/user_profile.dart';
import 'package:flutter_yt_app/services/firestore_services.dart';
import 'package:responsive_builder/responsive_builder.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  List<UserProfile> subscribedMembers = [];

  void _fetchSubscribedMembers() async {
    log('fetch member list');
    EasyLoading.show(status: "");
    final temp = await FirestoreServices.getSubscribedMemberList();
    EasyLoading.dismiss();
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
            onCreateComplete: () => _fetchSubscribedMembers(),
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

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final double defaultSize = SizeConfig.defaultSize;
    return Scaffold(
      body: ResponsiveBuilder(
        builder: (context, breakpoint) {
          if (breakpoint.isMobile) {
            return Container(
              width: double.infinity,
              height: double.infinity,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    child: SvgPicture.asset('assets/bg/wave-haikei-mobile.svg',
                        fit: BoxFit.cover),
                  ),
                  Column(
                    children: [
                      const TopNavigator(isAdmin: true),
                      Flexible(
                        child: ListView.builder(
                          itemCount: subscribedMembers.length,
                          itemBuilder: (context, index) {
                            return AdminMemberCard(
                                subscribedMembers: subscribedMembers[index]);
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(1.6 * defaultSize),
                        height: 4.5 * defaultSize,
                        child: SxButton(
                          backgroundColor: Colors.red[500],
                          child: const Text('เพิ่มสมาชิกใหม่'),
                          onTap: () => addNewMember(context),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
