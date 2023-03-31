import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

///Handle Authentication and Validation states
class AuthenticationStateManager extends ChangeNotifier {
  //firebase instance
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //
  bool _registerWithEmail = false;
  bool _registerWithNumber = false;
  bool _emailVerified = false;

  bool get registerWithEmail => _registerWithEmail;
  bool get registerWithNumber => _registerWithNumber;
  bool get emailVerified => _emailVerified;

  //sign up email
  set withEmail(value) {
    _registerWithEmail = value;
    notifyListeners();
  }

  //sign up phone
  set withPhone(value) {
    _registerWithNumber = value;
    notifyListeners();
  }

  //email verified
  set isEmailVerified(value) {
    _emailVerified = value;
    notifyListeners();
  }

  //email and password sign up
  Future signUpWithEmail(
      {required firstname,
      required lastname,
      required gender,
      required role,
      required emailOrPhone,
      required password}) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(
              email: emailOrPhone, password: password)
          .then((value) {
        //user
        final User? user = value.user;

        //saving to firestore collection
        if (user != null) {
          _firestore.collection('/users').doc(user.uid).set({
            'firstname': firstname,
            'lastname': lastname,
            'gender': gender,
            'email': emailOrPhone,
            'password': password,
            'userRole': role,
          }).whenComplete(() {
            //check if the email is verified
            user.sendEmailVerification();
          });
        } else {
          //print("theres no  users created");
        }
      });
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          return e.message;
        case 'email-already-in-use':
          return e.message;
        case 'weak-password':
          return e.message;
        case 'network-request-failed':
          return "You lost wifi connections";
        default:
          return 'Unknown error occurred';
      }
    }
    notifyListeners();
  }

  //login user
  Future signInWithEmail({email, password}) async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        User? user = value.user;

        //check if the email is verified
        if (!user!.emailVerified) {
          user.sendEmailVerification();
        }
      });
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          return "There's no user with that email address";
        case 'invalid-email':
          return e.message;
        case 'network-request-failed':
          return "You lost wifi connections";
        case 'wrong-password':
          return "The password is incorrect";
        default:
          return 'Unknown error occurred';
      }
    }
    notifyListeners();
  }

  Future logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      // final snackBar = SnackBar(content: Text(e.toString()));
      // ScaffoldMessenger.of(context!).showSnackBar(snackBar);
    }
    notifyListeners();
  }

  Future resetPassword(email) async {
    await _auth.sendPasswordResetEmail(email: email);
    notifyListeners();
  }

  Stream<User?> get user => _auth.authStateChanges().map((event) => event);
}
