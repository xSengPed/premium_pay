import 'package:flutter/material.dart';
import 'package:flutter_yt_app/components/alert.dart';
import 'package:flutter_yt_app/configs/size_config.dart';

class TopNavigator extends StatelessWidget {
  final bool isAdmin;
  const TopNavigator({super.key, this.isAdmin = false});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final double defaultSize = SizeConfig.defaultSize;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 1.6 * defaultSize),
      color: Colors.transparent,
      width: double.infinity,
      height: 70,
      child: Stack(children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'สวัสดี , Donnukrit',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ),
              onPressed: () {
                Alert().show(context,
                    title: "ออกจากระบบ",
                    desc: "คุณต้องการออกจากระบบ หรือ ไม่ ?",
                    okText: "ออกจากระบบ",
                    cancelText: "ยกเลิก",
                    descAlignment: MainAxisAlignment.center);
              }),
        ),
      ]),
    );
  }
}
