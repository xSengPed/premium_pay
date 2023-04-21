import 'package:flutter_yt_app/main.dart';
import 'package:flutter_yt_app/screens/home/home.dart';

import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(routes: <RouteBase>[
  // GoRoute(
  //   path: '/',
  //   builder: (context, state) => const MyHomePage(title: "My App"),
  // ),
  // GoRoute(
  //   path: '/',
  //   builder: (context, state) => const SignInScreen(),
  // ),
  // GoRoute(
  //   path: '/admin',
  //   builder: (context, state) => const AdminHome(),
  // ),
  GoRoute(
    path: '/',
    builder: (context, state) => const Home(),
  ),
]);
