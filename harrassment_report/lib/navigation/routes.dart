import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/features.dart';

class Routes {
  static final home = GoRoute(
      path: '/',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return Home.page();
      });
  static final admin = GoRoute(
      path: '/admin',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return MainScreen.page();
      });
  static final counsels = GoRoute(
      path: '/counselor',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return Counselor.page();
      });

  static final wrapper = GoRoute(
      path: '/wrapper',
      builder: (BuildContext context, GoRouterState state) {
        return Wrapper();
      });

  static final index = GoRoute(
      path: '/index',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return LandingPage.page();
      });
}
