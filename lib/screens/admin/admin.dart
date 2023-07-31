import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_yt_app/components/button.dart';

import 'package:flutter_yt_app/components/member_card.dart';

import 'package:flutter_yt_app/components/tool_bar.dart';
import 'package:flutter_yt_app/models/user_profile.dart';
import 'package:flutter_yt_app/screens/admin/admin.controller.dart';
import 'package:flutter_yt_app/screens/layout.dart';
import 'package:provider/provider.dart';

import 'package:responsive_grid/responsive_grid.dart';

class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  late AdminController controller;
  @override
  void initState() {
    controller = AdminController(context);

    super.initState();
  }

  List<ResponsiveGridCol> getMemberWidget(AdminController ctrl) {
    return ctrl.users.map((UserProfile user) {
      return ResponsiveGridCol(
          xs: 12,
          sm: 6,
          md: 6,
          lg: 4,
          xl: 3,
          child: MemberCard(
            user: user,
            loginAsAdmin: true,
            onClickSetting: () => ctrl.showSettingOverlay(context, user),
            onClickDelete: () => ctrl.showDeleteAlert(context, user: user),
          ));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => controller,
      child: Consumer<AdminController>(builder: (
        context,
        ctrl,
        child,
      ) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: Color(0xFFBD395D),
            elevation: 0,
            child: Icon(Icons.add),
            onPressed: () {
              ctrl.showAddMemberOverlay(ctrl);
            },
          ),
          body: Layout(
            marginTop: 75,
            toolbar: Toolbar(
              leading: Text("Welcome, Administrator",
                  style: TextStyle(color: Colors.white)),
              trailing: Button(
                child: SvgPicture.asset(
                  "assets/icons/log-out-outline.svg",
                  width: 24,
                  colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
                onClick: () => ctrl.signOut(context),
              ),
            ),
            children: [...getMemberWidget(ctrl)],
          ),
        );
      }),
    );
  }
}
