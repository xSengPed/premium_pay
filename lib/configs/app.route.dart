import 'package:flutter_yt_app/screens/admin/admin.dart';
import 'package:flutter_yt_app/screens/home/home.dart';

import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(routes: <RouteBase>[
  GoRoute(
    path: '/',
    builder: (context, state) => const Home(),
  ),
  GoRoute(
    path: '/admin',
    redirect: (context, state) async {
      return '/admin';
    },
    builder: (context, state) {
      return Admin();
    },
  ),
]);
