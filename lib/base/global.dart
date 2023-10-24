import 'package:flutter/material.dart';

class GlobalProvider with ChangeNotifier {
  String _lang = "zh";
  bool _isTest = false;
  int _asso = 0; // 0表示不限，1表示只看atp，2表示只看wta

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

  int get asso => _asso;

  set asso(int asso) {
    _asso = asso;
    notifyListeners();
  }
}
