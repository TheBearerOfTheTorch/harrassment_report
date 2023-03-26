import 'package:go_router/go_router.dart';
import 'package:harrassment_report/navigation/navigation.dart';

import '../features/features.dart';
import '../states/states.dart';

final router = GoRouter(
  initialLocation: Routes.login.path,
  refreshListenable: StateManager(),
  routes: [Routes.login, Routes.home, Routes.wrapper],
  errorBuilder: (context, state) {
    return const ErrorScreen();
  },
);
