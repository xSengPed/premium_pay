import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_yt_app/components/button.dart';
import 'package:flutter_yt_app/components/member_card.dart';
import 'package:flutter_yt_app/components/payment_overlay.dart';
import 'package:flutter_yt_app/components/tool_bar.dart';
import 'package:flutter_yt_app/models/user_profile.dart';
import 'package:flutter_yt_app/screens/home/home.controller.dart';
import 'package:flutter_yt_app/screens/layout.dart';
import 'package:provider/provider.dart';
import 'package:responsive_grid/responsive_grid.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late HomeController controller;
  @override
  void initState() {
    controller = HomeController(context: context);
    super.initState();
  }

  List<ResponsiveGridCol> getMemberWidget(HomeController ctrl) {
    return ctrl.users.map((UserProfile user) {
      return ResponsiveGridCol(
          xs: 12,
          sm: 6,
          md: 6,
          lg: 4,
          xl: 3,
          child: MemberCard(
            user: user,
          ));
    }).toList();
  }

  void showQrCodeOverlay() {
    showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) {
        return Dialog(
          backgroundColor: Colors.white,
          child: PaymentOverlay(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => controller,
      child: Consumer<HomeController>(builder: (context, ctrl, child) {
        return Layout(
          floatingActionButton: Button(
            child: CircleAvatar(
              radius: 36,
              child: SvgPicture.asset(
                "assets/icons/qr-code-outline.svg",
                colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                width: 24,
              ),
            ),
            onClick: showQrCodeOverlay,
          ),
          children: [...getMemberWidget(ctrl)],
        );
      }),
    );
  }
}
