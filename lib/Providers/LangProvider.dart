import 'package:ewarrenty/Constants/prefKeys.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LangProvider extends ChangeNotifier{
  String _languageCode="";
  SharedPreferences _prefs;

  LangProvider(){
    // SharedPreferences.getInstance().then((value){
    //         _prefs=value;
    //         if(_prefs.containsKey(languageCode));
    //         _languageCode =_prefs.getString(langCode)??"";
    //     });

  }
  // async {
  //
  // }

  SharedPreferences get prefs => _prefs;

  set prefs(SharedPreferences value) {
    _prefs = value;
    // notifyListeners();
  }

  String get languageCode => _languageCode;

  set languageCode(String value) {
    _languageCode = value;
    // notifyListeners();
  }
}