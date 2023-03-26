import 'package:flutter/material.dart';

class StateManager extends ChangeNotifier {
  //setter
  bool _initializeApp = false;
  bool _loggedIn = false;
  bool _loggedOut = false;
  bool _registerPressed = false;
  bool _darkMode = false;

  //getter
  bool get isInitialized => _initializeApp;
  bool get isLoggedIn => _loggedIn;
  bool get isLoggedOut => _loggedOut;
  bool get darkMode => _darkMode;
  bool get registerPressed => _registerPressed;

  //initialApp
  void initializeApp() async {
    _initializeApp = true;
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
}
