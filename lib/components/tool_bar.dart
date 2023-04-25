import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_yt_app/components/alert.dart';
import 'package:flutter_yt_app/components/button.dart';

class Toolbar extends StatelessWidget {
  final Widget? leading;
  final Widget? trailing;
  final double height;
  final Color? color;
  const Toolbar(
      {super.key, this.leading, this.trailing, this.height = 75.0, this.color});

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
          trailing ?? Container(),
        ],
      ),
    );
  }
}
