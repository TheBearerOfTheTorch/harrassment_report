import 'package:flutter/material.dart';

import '../features/features.dart';
import '../states/states.dart';

class AppRouter extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  // 2
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  // state managers
  final StateManager appStateManager;
  final FieldsStateManager fieldStateManager;
  final AuthenticationStateManager authStateManager;
  final ErrorStateManager errorStateManager;
  final LoadingStateManager loadingStateManager;

  AppRouter(
      {required this.appStateManager,
      required this.fieldStateManager,
      required this.authStateManager,
      required this.errorStateManager,
      required this.loadingStateManager})
      : navigatorKey = GlobalKey<NavigatorState>() {
    appStateManager.addListener(notifyListeners);
    fieldStateManager.addListener(notifyListeners);
    authStateManager.addListener(notifyListeners);
    errorStateManager.addListener(notifyListeners);
    loadingStateManager.addListener(notifyListeners);
  }

  @override
  void dispose() {
    appStateManager.removeListener(notifyListeners);
    fieldStateManager.removeListener(notifyListeners);
    authStateManager.removeListener(notifyListeners);
    errorStateManager.removeListener(notifyListeners);
    loadingStateManager.removeListener(notifyListeners);
    super.dispose();
  }

  // 5
  @override
  Widget build(BuildContext context) {
    // 6
    return Navigator(
      // 7
      key: navigatorKey,
      onPopPage: _handlePopPage,

      pages: [
        if (!appStateManager.isInitialized) SplashScreen.page(),
        if (appStateManager.isInitialized && !appStateManager.isLoggedIn)
          Wrapper.page(),
        if (appStateManager.isLoggedIn) Home.page(),
      ],
    );
  }

  bool _handlePopPage(Route<dynamic> route, result) {
    // 3
    if (!route.didPop(result)) {
      return false;
    }

    // poping and logging out
    if (route.settings.name == "/") {
      //appStateManager.logout();
    }
    return true;
  }

  // 9
  @override
  Future<void> setNewRoutePath(configuration) async => null;
}
