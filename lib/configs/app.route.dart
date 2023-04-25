import 'package:flutter_yt_app/screens/admin/admin.dart';
import 'package:flutter_yt_app/screens/home/home.dart';
import 'package:flutter_yt_app/screens/sign_in/sign_in.dart';
import 'package:flutter_yt_app/services/auth_service.dart';

import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(routes: <RouteBase>[
  GoRoute(
    path: '/',
    builder: (context, state) => const Home(),
  ),
  GoRoute(
    path: '/admin',
    redirect: (context, state) async {
      final isUserAuth = await AuthService.isUserAuth();
      if (isUserAuth == true) {
        return '/admin';
      } else {
        return '/admin/sign_in';
      }
    },
    builder: (context, state) {
      return Admin();
    },
  ),
  GoRoute(
    path: '/admin/sign_in',
    redirect: (context, state) async {
      final isUserAuth = await AuthService.isUserAuth();
      if (isUserAuth == true) {
        return '/admin';
      } else {
        return '/admin/sign_in';
      }
    },
    builder: (context, state) {
      return SignIn();
    },
  ),
]);
