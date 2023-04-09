import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../navigation/navigation.dart';
import '../../states/states.dart';
import '../features.dart';
import '../screens/admin/admin.dart';

class Wrapper extends StatefulWidget {
  static MaterialPage page({LocalKey? key}) {
    return MaterialPage(key: key, child: Wrapper());
  }

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  String role = 'user';
  bool isToggle = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, authSnapshot) {
          if (authSnapshot.hasData) {
            if (user != null) {
              if (!user.emailVerified) {
                //print(user);
                return const VerifyEmail();
              } else {
                return StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("users")
                        .doc(user.uid)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data != null) {
                        //print(user);
                        checkingRole(user, context);
                      }
                      if (snapshot.hasError) {
                        return const Text("An unknown error has occured !");
                      }
                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {}
                      return const Center(child: CircularProgressIndicator());
                    });
              }
            }
          }
          return LandingPage();
        });
  }

  void toggleScreen() {
    setState(() {
      isToggle = !isToggle;
    });
  }

  checkingRole(user, context) async {
    if (user != null) {
      final DocumentSnapshot snap = await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .get();

      setState(() {
        role = snap['role'];
      });

      if (role == 'investigator') {
        GoRouter.of(context).go(Routes.counsels.path);
      }

      if (role == 'user') {
        GoRouter.of(context).go(Routes.home.path);
      }
    }
    return LandingPage();
  }
}
