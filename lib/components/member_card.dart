import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_yt_app/components/button.dart';
import 'package:flutter_yt_app/models/user_profile.dart';

class MemberCard extends StatelessWidget {
  final UserProfile user;
  const MemberCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(user.name.toString(),
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
                fontWeight: FontWeight.w600,
              )),
          Text(user.email.toString()),
          Text(user.mobileNo.toString()),
          Text(user.lastPaid.toString()),
          Text(user.expired.toString()),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Button(
                child: SvgPicture.asset(
                  "assets/icons/settings-outline.svg",
                  width: 18,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
