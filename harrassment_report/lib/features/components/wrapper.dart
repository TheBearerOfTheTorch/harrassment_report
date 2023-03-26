import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../states/states.dart';
import '../features.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  static MaterialPage page({LocalKey? key}) {
    return MaterialPage(key: key, child: const Wrapper());
  }

  @override
  Widget build(BuildContext context) {
    //providing state managers to wrapper
    final user = Provider.of<User?>(context);
    final loggedIn = Provider.of<StateManager>(context);

    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Theres an unkown error"),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LinearProgressIndicator();
          }
          if (snapshot.hasData) {
            if (user != null) {
              if (user.emailVerified) {
                Future.delayed(const Duration(seconds: 5), () {
                  loggedIn.userLoggedIn = true;
                  return const Center(child: CircularProgressIndicator());
                });
              } else {
                //send email verification link
                user.sendEmailVerification();
                //return const VerifyEmail();
              }
            }
          }
          return const LoginScreen();
        });
  }

  checkingRole(user) async {}
}
