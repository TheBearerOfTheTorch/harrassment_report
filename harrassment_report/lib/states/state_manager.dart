import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class ApodTab {
  static const int home = 0;
  static const int updates = 1;
  static const int reports = 2;
  static const int profile = 3;
}

class InvestigatorTab {
  static const int home = 0;
  static const int notification = 1;
  static const int graphs = 2;
}

class StateManager extends ChangeNotifier {
  //setter
  bool _initializeApp = false;
  bool _loggedIn = false;
  bool _loggedOut = false;
  bool _registerPressed = false;
  bool _darkMode = false;
  int _selectedTab = ApodTab.home;
  int _investigorSelectedTab = InvestigatorTab.home;
  String _role = 'user';

  //getter
  bool get isInitialized => _initializeApp;
  bool get isLoggedIn => _loggedIn;
  bool get isLoggedOut => _loggedOut;
  bool get darkMode => _darkMode;
  bool get registerPressed => _registerPressed;
  int get selectedTab => _selectedTab;
  int get investigatorTab => _investigorSelectedTab;
  String get role => _role;

  final firebase_auth.FirebaseAuth _firebaseAuth =
      firebase_auth.FirebaseAuth.instance;

  //initialApp
  void initializeApp() async {
    _initializeApp = true;
    notifyListeners();
  }

  void userRole(role){
    _role = role;
    notifyListeners();
  }

  //checking if register is pressed
  set registerPressed(value) {
    _registerPressed = value;
    notifyListeners();
  }

  //checked if user is logged in
  set userLoggedIn(value) {
    _loggedIn = value;
    notifyListeners();
  }

  void loggedOut() {
    _loggedOut = true;
    notifyListeners();
  }

  //setting dark mode
  set darkMode(bool darkMode) {
    _darkMode = darkMode;
    notifyListeners();
  }

  String? authError;

  void goToTab(index) {
    _selectedTab = index;
    notifyListeners();
  }

  void goToIvestigatorTab(index) {
    _investigorSelectedTab = index;
    notifyListeners();
  }

  /// Useful for deep links to a single tab. Should not be used
  /// during normal navigation.
  void silentlySetTab(int index) {
    _selectedTab = index;
  }

  void goToUpdateReport() {
    _selectedTab = ApodTab.updates;
    notifyListeners();
  }

  void logout() async {
    await _firebaseAuth.signOut();
    _selectedTab = 0;

    initializeApp();
    notifyListeners();
  }

  Future submitReport({phone, harassmentType, date, description}) async {
    final FirebaseFirestore cloud = FirebaseFirestore.instance;
    final User? currentUser = FirebaseAuth.instance.currentUser;

    //getting location
    Location location = Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();

    //saving details to database
    //phone, harassmentType, date, description
    try {
      await cloud
          .collection('users')
          .doc(currentUser!.uid)
          .collection('report')
          .add({
        'harassmentType': harassmentType,
        'date': date,
        'description': description,
        'location': _locationData
      }).whenComplete(() async {
        await cloud.collection('report').add({
          'name': currentUser.displayName,
          'email': currentUser.email,
          'phone': phone,
          'harassmentType': harassmentType,
          'date': date,
          'description': description,
          'location': _locationData
        });
      });
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    notifyListeners();
  }

  Future submitAnonymousReport({phone, harassmentType, date, description}) async {
    final FirebaseFirestore cloud = FirebaseFirestore.instance;
    final User? currentUser = FirebaseAuth.instance.currentUser;

    try {
        await cloud.collection('report').doc(phone).set({
          'name': 'dfsfds',
          'status': 'submitted',
          'email': 'sdfsdfsd',
          'phone': phone,
          'harassmentType': harassmentType,
          'date': date,
          'description': description,
          'location': '_locationData',
        });
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    notifyListeners();
  }
}

final stateManager = StateManager();
