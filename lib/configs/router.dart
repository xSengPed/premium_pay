import 'package:flutter_yt_app/main.dart';
import 'package:flutter_yt_app/screens/admin_home.dart';
import 'package:flutter_yt_app/screens/sign_in_screen.dart';
import 'package:flutter_yt_app/screens/user_profile_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(routes: <RouteBase>[
  GoRoute(
    path: '/',
    builder: (context, state) => const MyHomePage(title: "My App"),
  ),
  GoRoute(
    path: '/sign_in',
    builder: (context, state) => const SignInScreen(),
  ),
  GoRoute(
    path: '/admin',
    builder: (context, state) => const AdminHome(),
  ),
  GoRoute(
    path: '/profile',
    builder: (context, state) => const UserProfileScreen(),
  ),
]);
