
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_yt_app/components/sx_button.dart';
import 'package:flutter_yt_app/services/auth_service.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_builder/responsive_builder.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool obsecurePassword = true;

  @override
  void initState() {
    // TODO: implement initState
    log('message');
    Auth.validateLogin(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveBuilder(
        builder: (context, breakpoint) {
          if (breakpoint.isDesktop) {
            return const Text('Desktop');
          } else {
            return Container(
              padding: const EdgeInsetsDirectional.all(25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: SizedBox(
                              height: 50,
                              child: SxButton(
                                  backgroundColor: Colors.white,
                                  onTap: () async {
                                    try {
                                      if (!EasyLoading.isShow) {
                                        EasyLoading.show(status: 'Loading');
                                        await Auth.signInWithGoolgle(context);
                                        EasyLoading.dismiss();
                                      }
                                    } catch (e) {
                                      EasyLoading.dismiss();
                                    }
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon((Icons.account_balance)),
                                      SizedBox(
                                        width: 16,
                                      ),
                                      Text(
                                        'Sign In With Google',
                                        style: TextStyle(
                                          color: Color(0xFF212121),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ))))
                    ],
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
