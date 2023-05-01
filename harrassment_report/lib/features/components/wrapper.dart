import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:harrassment_report/features/screens/admin/admin_page.dart';
import 'package:provider/provider.dart';

import '../../navigation/navigation.dart';
import '../../states/states.dart';
import '../features.dart';

class Wrapper extends StatefulWidget {
  static MaterialPage page({LocalKey? key}) {
    return MaterialPage(key: key, child: Wrapper());
  }

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool isToggle = false;

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
                        checkingRole(user);
                      }
                      if (snapshot.hasError) {
                        return const Text("An unknown error has occured !");
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return Center(child: Text(snapshot.hasError.toString()));
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

  checkingRole(User? user) async {
    String role = 'user';
    if (user != null) {
      final DocumentSnapshot snap = await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .get();

      if (snap['userRole'] == 'user') {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Home()));
        //return Routes.home.path;
      }

      if (snap['userRole'] == 'admin') {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const AdminPage()));
      }

      if (snap['userRole'] == 'investigator') {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Counselor()));
      }
    }
    return LandingPage();
  }
}
