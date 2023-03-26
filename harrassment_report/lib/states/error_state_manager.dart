import 'package:flutter/material.dart';

/// Handle Application error messages state
class ErrorStateManager extends ChangeNotifier {
  ///authentication errors
  bool _foundAuthError = false;
  bool _isErrorOnRegister = false;
  var _authErrorValue;

  bool get isAuthErrorFound => _foundAuthError;
  bool get isErrorOnRegister => _isErrorOnRegister;
  get getAuthErrorValue => _authErrorValue;

  //setting errors
  set setAuthErrorToErrorValue(errorValue) {
    _authErrorValue = errorValue;
    notifyListeners();
  }

  set setIsAuthErrorFound(error) {
    _foundAuthError = error;
    notifyListeners();
  }

  //setting where error occurred Register / Login
  set setErrorOnRegister(error) {
    _isErrorOnRegister = error;
    notifyListeners();
  }

  ///next one here
}
