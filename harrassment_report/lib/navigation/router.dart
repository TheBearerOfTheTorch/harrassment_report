import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:harrassment_report/navigation/navigation.dart';

import '../features/features.dart';
import '../states/states.dart';

final GoRouter router = GoRouter(
  routes: [
    Routes.wrapper,
    Routes.index,
    Routes.home,
    Routes.counsels,
  ],
  refreshListenable: StateManager(),
  redirect: (context, state) {
    final stateManagerProvider = Provider.of<StateManager>(context);
    if (stateManagerProvider.isLoggedIn) {
      return Routes.wrapper.path;
    }
    return Routes.index.path;
  },
  errorBuilder: (context, state) {
    return const ErrorScreen();
  },
);
