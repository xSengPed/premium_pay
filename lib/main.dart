import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_yt_app/configs/router.dart';
import 'package:flutter_yt_app/configs/size_config.dart';
import 'package:flutter_yt_app/firebase_options.dart';
import 'package:flutter_yt_app/providers/members_provider.dart';
import 'package:flutter_yt_app/services/firestore_services.dart';
import 'package:flutter_yt_app/services/auth_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

_initializeEasyLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}

void main() async {
  _initializeEasyLoading();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirestoreServices.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MembersProvider()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router,
        builder: EasyLoading.init(),
        theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: GoogleFonts.kanitTextTheme()),
      ),
    );
  }
}
