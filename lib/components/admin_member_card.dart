import 'package:flutter/material.dart';
import 'package:flutter_yt_app/components/admin_view_detail_sheet.dart';
import 'package:flutter_yt_app/configs/size_config.dart';
import 'package:flutter_yt_app/models/user_profile.dart';

class AdminMemberCard extends StatelessWidget {
  final UserProfile subscribedMembers;
  const AdminMemberCard({super.key, required this.subscribedMembers});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final double defaultSize = SizeConfig.defaultSize;

    void viewDetail() {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        isDismissible: false,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
        builder: (context) =>
            AdminViewDetailSheet(subscribeMember: subscribedMembers),
      );
    }

    return Container(
      margin: EdgeInsets.all(1.6 * defaultSize),
      padding: EdgeInsets.all(1.6 * defaultSize),
      height: 12 * defaultSize,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(subscribedMembers.name.toString(),
                      style: TextStyle(
                          fontSize: 1.6 * defaultSize,
                          fontWeight: FontWeight.w600)),
                ),
                GestureDetector(
                  child: Icon(Icons.edit_document),
                  onTap: () => viewDetail(),
                )
              ],
            ),
            Spacer(),
            Text(subscribedMembers.email.toString()),
            Text(subscribedMembers.mobileNo.toString(),
                style: TextStyle(
                    fontSize: 1.2 * defaultSize, fontWeight: FontWeight.w400)),
          ]),
    );
  }
}
