import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:harrassment_report/navigation/navigation.dart';

import '../features/features.dart';
import '../states/states.dart';

final GoRouter router = GoRouter(
  initialLocation: Routes.splash.path,
  routes: [
    Routes.login,
    Routes.home,
  ],
  refreshListenable: StateManager(),
  // redirect: (BuildContext context, GoRouterState state) {
  //   return GoRouterRedirector.instance.redirect(state, stateManager);
  // },
  errorBuilder: (context, state) {
    return const ErrorScreen();
  },
);

class GoRouterRedirector {
  const GoRouterRedirector(this._redirects);
  final List<Redirect> _redirects;

  static GoRouterRedirector get instance => GoRouterRedirector([
        LoggedInRedirect(),
        LoggedOutRedirect(),
        UninitializedRedirect(),
        OnInitializationRedirect(),
        UpdateHomeTabRedirect(),
      ]);

  String? redirect(GoRouterState state, StateManager manager) {
    final current = Uri(path: state.subloc, queryParameters: state.queryParams);
    for (final redirect in _redirects) {
      if (redirect.predicate(state, manager)) {
        final uri = redirect.getNewUri(state, manager);
        if (uri != null) {
          final uriString = uri.toString();

          if (uriString == current.toString()) {
            // ignore: avoid_print
            print('$redirect attempted to redirect to itself at $uriString');
            return null;
          }

          // ignore: avoid_print
          print(
              '$redirect redirecting from ${current.toString()} to $uriString');
          return uriString;
        }
      }
    }
    return null;
  }
}

abstract class Redirect {
  /// Determines whether this redirection should take place.
  bool predicate(GoRouterState state, StateManager manager);

  /// Returns an optional `Uri` instance if there is a redirect. This
  /// can return Null because `predicate` may return true if it knows there is
  /// zero chance any future redirect should be checked. For example, if the
  /// app is not initialized, you may know that your only possible redirect is
  /// *to* the splash screen. However, if you are already there, [getNewUri]
  /// will return null.
  Uri? getNewUri(GoRouterState state, StateManager manager);
}

/// Takes any route to the Splash screen.
class UninitializedRedirect extends Redirect {
  @override
  bool predicate(GoRouterState state, StateManager manager) =>
      !stateManager.isInitialized;

  @override
  Uri? getNewUri(GoRouterState state, StateManager manager) {
    if (state.subloc == Routes.splash.path) return null;

    final queryParams = Map<String, String>.from(state.queryParams);
    queryParams['next'] = state.subloc;
    return Uri(
      path: Routes.splash.path,
      //queryParameters: queryParams,
    );
  }
}

/// Leaves the splash screen once the app is initialized.
class OnInitializationRedirect extends Redirect {
  @override
  bool predicate(GoRouterState state, StateManager manager) =>
      manager.isInitialized && state.subloc == Routes.splash.path;

  @override
  Uri? getNewUri(GoRouterState state, StateManager manager) {
    final queryParams = Map<String, String>.from(state.queryParams);

    String next = Routes.home.path;
    if (queryParams.containsKey('next')) {
      // Grab a complete copy of the upcoming location.
      next = queryParams.remove('next')!;
      final uri = Uri(path: next);

      // See if the upcoming location is the home page and mentions a tab, and
      // if so, set that tab in our manager.
      // if (uri.path == Routes.home.path &&
      //     uri.queryParameters.containsKey('tab')) {
      //   stateManager.silentlySetTab(int.parse(uri.queryParameters['tab']!));
      // }
      next = uri.path;
    }

    if (manager.isLoggedIn) {
      return Uri(path: next, queryParameters: queryParams);
    } else {
      queryParams['next'] = next;
      return Uri(path: Routes.login.path);
    }
  }
}

class LoggedInRedirect extends Redirect {
  @override
  bool predicate(GoRouterState state, StateManager manager) =>
      manager.isLoggedIn && state.subloc == Routes.login.path;

  @override
  Uri? getNewUri(GoRouterState state, StateManager manager) {
    Map<String, String> queryParams = <String, String>{...state.queryParams};
    String next = queryParams.remove('next') ?? Routes.home.path;
    return Uri(path: next);
  }
}

class LoggedOutRedirect extends Redirect {
  @override
  bool predicate(GoRouterState state, StateManager manager) =>
      manager.isInitialized &&
      (!manager.isLoggedIn && state.subloc != Routes.login.path);

  @override
  Uri? getNewUri(GoRouterState state, StateManager manager) =>
      Uri(path: Routes.login.path);
}

class UpdateHomeTabRedirect extends Redirect {
  @override
  bool predicate(GoRouterState state, StateManager manager) =>
      state.subloc == Routes.home.path;

  @override
  Uri? getNewUri(GoRouterState state, StateManager manager) {
    if (manager.selectedTab.toString() != state.queryParams['tab']) {
      final queryParams = Map<String, String>.from(state.queryParams);
      queryParams['tab'] = stateManager.selectedTab.toString();
      return Uri(
        path: state.subloc,
        queryParameters: queryParams,
      );
    }
  }
}
