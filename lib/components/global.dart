import 'package:flutter/material.dart';

class Global {
  static bool loading = false;

  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
  }
}
