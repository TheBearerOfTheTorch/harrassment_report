import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_theme.dart';
import 'firebase_options.dart';
import 'navigation/navigation.dart';
import 'states/states.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _fieldStateManager = FieldsStateManager();
  final _authStateManager = AuthenticationStateManager();
  final _errorStateManager = ErrorStateManager();
  final _loadingStateManager = LoadingStateManager();
  final StateManager _stateManager = StateManager();
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => _stateManager,
        ),
        ChangeNotifierProvider(create: (context) => _fieldStateManager),
        ChangeNotifierProvider(create: (context) => _authStateManager),
        ChangeNotifierProvider(create: (context) => _errorStateManager),
        ChangeNotifierProvider(create: (context) => _loadingStateManager),
        StreamProvider<User?>.value(
          value: _authStateManager.user,
          initialData: null,
        ),
      ],
      child: Consumer<StateManager>(
        builder: (context, value, child) {
          ThemeData theme;
          if (value.darkMode) {
            theme = AppTheme.dark();
          } else {
            theme = AppTheme.light();
          }

          return Material(
            child: MaterialApp.router(
              theme: theme,
              routerDelegate: router.routerDelegate,
              routeInformationParser: router.routeInformationParser,
            ),
          );
        },
      ),
    );
  }
}
