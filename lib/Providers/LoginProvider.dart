import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ewarrenty/helpers/PrefKeys.dart';

class LoginProvider extends ChangeNotifier {
  SharedPreferences _prefs;
  // LoginService _loginService = LoginService.create();
  String _username = '';
  String _password = '';
  String _email = "";
  String _fullName = "";
  int _userId = 5;
  bool _loginProgress = false;

  // TODO: don't forget about the token
  String _token = "";
  bool _isPasswordShown = true;
  String _userRole = "";

  String _restoredPassword = "";
  String _restoredUsername = "";
  String _usingEmailToRestore = "";
  String _usingPhoneToRestore = "";
  bool _emailValidator = false;

  int _failedLoginCounter = 0;

  LoginProvider() {
    //TODO: don't forget to test
    // print("LoginProvider constructor");
    SharedPreferences.getInstance().then((value) {
      _prefs = value;
      // print("LoginProvider SharedPreferences Loaded");
      if (_prefs.containsKey(PrefKeys.fullName)) {
        this.fullName = _prefs.getString(PrefKeys.fullName);
      }
      if (_prefs.containsKey(PrefKeys.token)) {
        this.token = _prefs.getString(PrefKeys.token);
      }
      if (_prefs.containsKey(PrefKeys.userRole)) {
        this.userRole = _prefs.getString(PrefKeys.userRole);
      }
      if (_prefs.containsKey(PrefKeys.userEmail)) {
        this.email = _prefs.getString(PrefKeys.userEmail);
      }
      if (_prefs.containsKey(PrefKeys.userId)) {
        this.email = _prefs.getString(PrefKeys.userId);
      }
    });
  }

  bool get emailValidator => _emailValidator;

  set emailValidator(bool value) {
    _emailValidator = value;
    notifyListeners();
  }

  int get failedLoginCounter => _failedLoginCounter;

  set failedLoginCounter(int value) {
    _failedLoginCounter = value;
  }

  String get usingEmailToRestore => _usingEmailToRestore;

  set usingEmailToRestore(String value) {
    _usingEmailToRestore = value;
  }

  String get restoredPassword => _restoredPassword;

  set restoredPassword(String value) {
    _restoredPassword = value;
  }

  int get userId => _userId;

  set userId(int value) {
    _userId = value;
  }

  String get username => _username;

  set username(String value) {
    _username = value;
    notifyListeners();
  }

  String get password => _password;

  set password(String value) {
    _password = value;
    notifyListeners();
  }

  get isPasswordShown => _isPasswordShown;

  set isPasswordShown(bool value) {
    _isPasswordShown = value;
    notifyListeners();
  }

  SharedPreferences get prefs => _prefs;

  // LoginService get loginService => _loginService;

  String get token => _token;

  set token(String value) {
    _token = value;
    notifyListeners();
  }

  String get fullName => _fullName;

  set fullName(String value) {
    _fullName = value;
    notifyListeners();
  }

  String get email => _email;

  set email(String value) {
    _email = value;
    notifyListeners();
  }

  bool get loginProgress => _loginProgress;

  set loginProgress(bool value) {
    _loginProgress = value;
    notifyListeners();
  }

  String get userRole => _userRole;

  set userRole(String value) {
    _userRole = value;
    notifyListeners();
  }

  String get restoredUsername => _restoredUsername;

  set restoredUsername(String value) {
    _restoredUsername = value;
  }

  String get usingPhoneToRestore => _usingPhoneToRestore;

  set usingPhoneToRestore(String value) {
    _usingPhoneToRestore = value;
  }
}
