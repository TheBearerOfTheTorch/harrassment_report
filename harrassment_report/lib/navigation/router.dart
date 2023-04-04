import 'package:go_router/go_router.dart';
import 'package:harrassment_report/navigation/navigation.dart';

import '../features/features.dart';

final GoRouter router = GoRouter(
  initialLocation: Routes.index.path,
  routes: [
    Routes.wrapper,
    Routes.index,
    Routes.home,
    Routes.admin,
    Routes.counsels
  ],
  errorBuilder: (context, state) {
    return const ErrorScreen();
  },
);
