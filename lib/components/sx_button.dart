import 'package:flutter/material.dart';
import 'package:flutter_yt_app/components/button.dart';

class SxButton extends StatelessWidget {
  final String label;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final VoidCallback? onClick;
  final TextStyle? labelStyle;
  final double height;
  const SxButton(
      {super.key,
      this.label = "",
      this.backgroundColor,
      this.borderRadius,
      this.onClick,
      this.labelStyle,
      this.height = 35});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Button(
        onClick: onClick,
        child: SizedBox(
          height: height,
          child: Container(
              decoration: BoxDecoration(
                  color: backgroundColor ?? Colors.grey[100],
                  borderRadius: borderRadius ?? BorderRadius.circular(8)),
              child: Center(
                  child: Text(
                '$label',
                style: labelStyle,
              ))),
        ),
      ),
    );
  }
}
