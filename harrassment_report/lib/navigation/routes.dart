import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/features.dart';

class Routes {
  static final login = GoRoute(
      path: '/signin',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return LoginScreen.page();
      });

  static final splash = GoRoute(
      path: '/splash',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return SplashScreen.page();
      });

  static final home = GoRoute(
      path: '/',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return Home.page();
      });

  static final wrapper = GoRoute(
      path: '/wrapper',
      builder: (BuildContext context, GoRouterState state) {
        return const Wrapper();
      });

  static final register = GoRoute(
      path: '/signup',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return RegisterScreen.page();
      });
}
