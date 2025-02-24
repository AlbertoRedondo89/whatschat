import 'package:flutter/material.dart';
import 'package:whatschat/preferences/preferences.dart';

class PreferencesProvider with ChangeNotifier {
  bool _rememberMe = Preferences.rememberMe;

  bool get rememberMe => _rememberMe;

  set rememberMe(bool value) {
    _rememberMe = value;
    Preferences.rememberMe = value;
    notifyListeners(); 
  }
}
