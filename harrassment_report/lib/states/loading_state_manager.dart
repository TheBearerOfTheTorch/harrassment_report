import 'package:flutter/material.dart';

///Handles application's loading state
class LoadingStateManager extends ChangeNotifier {
  bool _requiresLoading = false;

  bool get loadingRequest => _requiresLoading;

  set isLoadingRequired(loading) {
    _requiresLoading = loading;
    notifyListeners();
  }
}
