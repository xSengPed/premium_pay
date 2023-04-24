import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_yt_app/components/alert.dart';
import 'package:flutter_yt_app/components/button.dart';

class Toolbar extends StatelessWidget {
  final Widget? leading;
  final double height;
  final Color? color;
  const Toolbar({super.key, this.leading, this.height = 75.0, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        color: color ?? Color.fromARGB(255, 3, 5, 28),
      ),
      child: Row(
        children: [
          leading ?? Container(),
          Spacer(),
          Button(
            child: SvgPicture.asset(
              'assets/icons/log-out-outline.svg',
              width: 18,
              colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
            ),
            onClick: () {
              Alert.show(
                context,
                title: "Logout",
                description: "Do You want to logout?",
                onSubmit: () {},
                onCancel: () {},
              );
            },
          )
          // ResponsiveBuilder(
          //   builder: (context, breakpoint) {
          //     if (breakpoint.isMobile) {
          //       return Button();
          //     } else {
          //       return Button();
          //     }
          //   },
          // )
        ],
      ),
    );
  }
}
