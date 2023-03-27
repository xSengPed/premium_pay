import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_yt_app/components/alert.dart';
import 'package:flutter_yt_app/components/member_card.dart';
import 'package:flutter_yt_app/components/profile_picture.dart';
import 'package:flutter_yt_app/components/sx_button.dart';
import 'package:flutter_yt_app/components/top_navigator.dart';
import 'package:flutter_yt_app/configs/size_config.dart';
import 'package:responsive_builder/responsive_builder.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  Alert alert = Alert();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final double defaultSize = SizeConfig.defaultSize;
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: ResponsiveBuilder(
        builder: (context, breakpoint) {
          if (breakpoint.isDesktop) {
            return Column();
          } else {
            return Container(
                width: double.infinity,
                height: double.infinity,
                child: Stack(
                  children: [
                    SizedBox(
                      child: SvgPicture.asset(
                          'assets/bg/wave-haikei-mobile.svg',
                          fit: BoxFit.cover),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 1.60 * defaultSize),
                      child: Flexible(
                          child: Column(
                        children: [
                          const TopNavigator(),
                          Flexible(
                              child: ListView(
                            children: [
                              const ProfilePicture(),
                              SizedBox(
                                height: 1.6 * defaultSize,
                              ),
                              const MemberCard(),
                              SizedBox(
                                height: 1.6 * defaultSize,
                              ),
                              Container(
                                constraints: BoxConstraints(
                                    minHeight:
                                        MediaQuery.of(context).size.height *
                                            0.25),
                                padding: EdgeInsets.all(1.6 * defaultSize),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "ประวัติการชำระเงิน",
                                          style: TextStyle(
                                              fontSize: 1.6 * defaultSize,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    const Divider(),
                                    ListView(
                                      shrinkWrap: true,
                                      primary: false,
                                      children: [],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ))
                        ],
                      )),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 1.6 * defaultSize),
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            'Version 1.0.0b',
                            style: TextStyle(
                              fontSize: 1.4 * defaultSize,
                              color: Colors.white,
                            ),
                          )),
                    )
                  ],
                ));
          }
        },
      ),
    );
  }
}
