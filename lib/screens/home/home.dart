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

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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
            loginAsAdmin: false,
            user: user,
          ));
    }).toList();
  }

  showQrCodeOverlay() {
    return showModalBottomSheet(
      context: context,
      constraints: BoxConstraints(maxWidth: 500),
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (context) {
        return PaymentOverlay();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => controller,
      child: Consumer<HomeController>(builder: (context, ctrl, child) {
        return Layout(
          toolbar: Toolbar(
            color: Colors.white,
            leading: Row(children: [
              SvgPicture.asset(
                "assets/icons/yt_premium.svg",
                width: 100,
              ),
            ]),
          ),
          floatingActionButton: Button(
            child: CircleAvatar(
              backgroundColor: Color(0xFFBD395D),
              radius: 36,
              child: SvgPicture.asset(
                "assets/icons/qr-code-outline.svg",
                colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                width: 24,
              ),
            ),
            onClick: () {
              showQrCodeOverlay();
            },
          ),
          children: [...getMemberWidget(ctrl)],
        );
      }),
    );
  }
}
