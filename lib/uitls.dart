import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_grid/responsive_grid.dart';

class Utils {
  static String formatDate(DateTime datetime) {
    return datetime.toIso8601String().split("T").first;
  }

  static Widget getMobileBackground() {
    return SvgPicture.asset(
      'assets/bg/wave-haikei-mobile.svg',
      fit: BoxFit.cover,
    );
  }

  static Widget getDesktopBackground() {
    return SvgPicture.asset(
      'assets/bg/waves-haikei-desktop.svg',
      fit: BoxFit.cover,
    );
  }

  static Widget getBackground() {
    return Container(
        width: double.infinity,
        height: double.infinity,
        child: ResponsiveBuilder(
          child: SizedBox(),
          xs: (context, child) {
            return getMobileBackground();
          },
          sm: (context, child) {
            return getMobileBackground();
          },
          md: (context, child) {
            return getDesktopBackground();
          },
          lg: (context, child) {
            return getDesktopBackground();
          },
          xl: (context, child) {
            return getDesktopBackground();
          },
        ));
  }
}
