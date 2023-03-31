import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/features.dart';

class Routes {
  static final splash = GoRoute(
      path: '/splash',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return SplashScreen.page();
      });
  static final login = GoRoute(
      path: '/signin',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return LoginScreen.page();
      });

  static final home = GoRoute(
      path: '/',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return Home.page();
      });

  static final wrapper = GoRoute(
      path: '/wrapper',
      builder: (BuildContext context, GoRouterState state) {
        return Wrapper();
      });

  static final index = GoRoute(
      path: '/index',
      routes: [signIn],
      pageBuilder: (BuildContext context, GoRouterState state) {
        return LandingPage.page();
      });

  //sub routes
  static final signIn = GoRoute(
    name: 'loginss',
    path: 'loginss',
    pageBuilder: (BuildContext context, GoRouterState state) =>
        LoginScreen.page(),
  );
}
