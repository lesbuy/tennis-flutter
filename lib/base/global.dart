import 'package:flutter/material.dart';

class GlobalProvider with ChangeNotifier {
  String _lang = "zh";
  bool _isTest = false;

  String get lang => _lang;

  set lang(String lang) {
    _lang = lang;
    notifyListeners();
  }

  bool get isTest => _isTest;

  set isTest(bool isTest) {
    _isTest = isTest;
    notifyListeners();
  }
}
