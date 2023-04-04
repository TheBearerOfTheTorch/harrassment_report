import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_theme.dart';
import 'features/screens/admin/admin.dart';
import 'firebase_options.dart';
import 'navigation/navigation.dart';
import 'states/states.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setUrlStrategy(PathUrlStrategy());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _fieldStateManager = FieldsStateManager();

  final _authStateManager = AuthenticationStateManager();

  final _errorStateManager = ErrorStateManager();

  final _loadingStateManager = LoadingStateManager();

  final StateManager _stateManager = StateManager();

  late AppRouter _appRouter;

  @override
  void initState() {
    super.initState();
    _appRouter = AppRouter(
        appStateManager: _stateManager,
        fieldStateManager: _fieldStateManager,
        authStateManager: _authStateManager,
        loadingStateManager: _loadingStateManager,
        errorStateManager: _errorStateManager);
  }

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
        ChangeNotifierProvider(
          create: (context) => MenuAppController(),
        ),
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
            child: MaterialApp(
              theme: theme,
              debugShowCheckedModeBanner: false,
              home: Router(
                routerDelegate: _appRouter,
              ),
            ),
          );
        },
      ),
    );
  }
}
