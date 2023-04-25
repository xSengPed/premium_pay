import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_yt_app/components/sx_button.dart';
import 'package:flutter_yt_app/components/tool_bar.dart';
import 'package:flutter_yt_app/screens/sign_in/sign_in.controller.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart' as rb;

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  late SignInController controller;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final InputDecoration defaultDecoration = InputDecoration(
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.circular(10.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.circular(10.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.circular(10.0),
    ),
  );

  @override
  void initState() {
    controller = SignInController(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => controller,
      child: Consumer<SignInController>(builder: (context, ctrl, child) {
        return Scaffold(
          backgroundColor: Colors.blue,
          body: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                child: rb.ResponsiveBuilder(
                  builder: (context, breakpoint) {
                    if (breakpoint.isMobile) {
                      return SvgPicture.asset(
                        'assets/bg/wave-haikei-mobile.svg',
                        fit: BoxFit.cover,
                      );
                    } else {
                      return SvgPicture.asset(
                        'assets/bg/waves-haikei-desktop.svg',
                        fit: BoxFit.cover,
                      );
                    }
                  },
                ),
              ),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  constraints: BoxConstraints(maxWidth: 350),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Spacer(),
                      TextFormField(
                        controller: emailController,
                        decoration:
                            defaultDecoration.copyWith(hintText: "E-Mail"),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: passwordController,
                        decoration:
                            defaultDecoration.copyWith(hintText: "Password"),
                        obscureText: true,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          Spacer(),
                          SxButton(
                            backgroundColor: Colors.indigo,
                            height: 50,
                            label: "Sign In",
                            labelStyle: TextStyle(color: Colors.white),
                            onClick: () {
                              ctrl.signInWithEmail(context,
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim());
                            },
                          ),
                        ],
                      ),
                      Spacer(),
                      // Row(
                      //   children: [
                      //     SxButton(
                      //       backgroundColor: Colors.indigo,
                      //       height: 50,
                      //       label: "Check Auth",
                      //       labelStyle: TextStyle(color: Colors.white),
                      //       onClick: () {
                      //         ctrl.checkAuth();
                      //       },
                      //     ),
                      //   ],
                      // ),
                      SizedBox(
                        height: 16,
                      ),
                      // Row(
                      //   children: [
                      //     SxButton(
                      //       backgroundColor: Colors.indigo,
                      //       height: 50,
                      //       label: "Sign Out",
                      //       labelStyle: TextStyle(color: Colors.white),
                      //       onClick: () {
                      //         // ctrl.signOut(context);
                      //       },
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ),
              Toolbar(
                color: Colors.white,
                leading: Row(children: [
                  SvgPicture.asset(
                    "assets/icons/yt_premium.svg",
                    width: 100,
                  ),
                ]),
                trailing: Text('Administrator'),
              ),
            ],
          ),
        );
      }),
    );
  }
}