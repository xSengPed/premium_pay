import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_yt_app/components/button.dart';
import 'package:flutter_yt_app/models/user_profile.dart';

class MemberCard extends StatelessWidget {
  final bool loginAsAdmin;

  final VoidCallback? onClickSetting;
  final VoidCallback? onClickDelete;
  final UserProfile user;
  const MemberCard({
    super.key,
    this.loginAsAdmin = false,
    this.onClickSetting,
    this.onClickDelete,
    required this.user,
  });

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
          Row(
            children: [
              Text(user.name.toString(),
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w600,
                  )),
              Spacer(),
              Visibility(
                visible: loginAsAdmin,
                child: Button(
                  child: SvgPicture.asset(
                    "assets/icons/settings-outline.svg",
                    width: 18,
                  ),
                  onClick: onClickSetting,
                ),
              ),
            ],
          ),
          Text(user.email.toString()),
          Text(user.mobileNo.toString()),
          Row(
            children: [
              Text(
                "หมดอายุ ",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              ),
              Text(
                user.expired.toString(),
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
          Visibility(
              visible: user.admin == false && loginAsAdmin == true,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Button(
                    child: SvgPicture.asset(
                      "assets/icons/trash-outline.svg",
                      colorFilter:
                          ColorFilter.mode(Colors.red, BlendMode.srcIn),
                      width: 18,
                    ),
                    onClick: onClickDelete,
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
