import 'package:flutter/material.dart';
import 'package:flutter_yt_app/components/alert.dart';
import 'package:flutter_yt_app/configs/size_config.dart';

class TopNavigator extends StatelessWidget {
  final Color? color;
  final bool isAdmin;
  final bool isDesktop;
  const TopNavigator(
      {super.key, this.isAdmin = false, this.color, this.isDesktop = false});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final double defaultSize = SizeConfig.defaultSize;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 1.6 * defaultSize),
      color: color ?? Colors.transparent,
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
          child: GestureDetector(
              child: isDesktop
                  ? Text(
                      'ออกจากระบบ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 1.0 * defaultSize,
                      ),
                    )
                  : Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
              onTap: () {
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
