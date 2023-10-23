import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingProvider with ChangeNotifier {
  bool _isLoading = false;
  String innerText = "";
  String errorText = "";
  bool get isLoading => _isLoading;
  void toggleLoading() {
    _isLoading = !_isLoading;
    notifyListeners(); // 通知监听者状态已更改
  }

  void loading({timeout = 10}) {
    if (!_isLoading) {
      _isLoading = true;
      Future.delayed(Duration(seconds: timeout)).then((_) {
        if (_isLoading) {
          _isLoading = false;
          innerText = "";
          notifyListeners(); // 通知监听者状态已更改
        }
        return Future.value();
      });
      notifyListeners(); // 通知监听者状态已更改
    }
  }

  void deloading() {
    if (_isLoading) {
      _isLoading = false;
      innerText = "";
      notifyListeners(); // 通知监听者状态已更改
    }
  }

  void setText(String text) {
    innerText = text;
    notifyListeners(); // 通知监听者状态已更改
  }

  void setErrorText(String text) {
    if (_isLoading) {
      deloading();
    }
    errorText = text;
    Future.delayed(Duration(seconds: 2)).then((_) {
      if (errorText != "") {
        errorText = "";
        notifyListeners(); // 通知监听者状态已更改
      }
      return Future.value();
    });
    notifyListeners();
  }
}

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    final loadingProvider = Provider.of<LoadingProvider>(context);
    return Stack(
      children: [
        if (loadingProvider.isLoading)
          Container(
            color: Colors.black.withOpacity(0.1),
            child: Center(
              child: SizedBox(
                  height: 200,
                  width: 200,
                  child: Stack(
                    children: [
                      SizedBox(
                        height: 200,
                        width: 200,
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.grey[400],
                          valueColor: AlwaysStoppedAnimation(Colors.grey[700]),
                          // value: .7,
                        ),
                      ),
                      Center(
                        child: Text(loadingProvider.innerText),
                      )
                    ],
                  )
                  // Text(loadingProvider.text)
                  ),
            ),
          ),
        if (!loadingProvider.isLoading && loadingProvider.errorText != "")
          Center(
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(108, 0, 0, 0),
                borderRadius: BorderRadius.circular(10), // 设置边框圆角半径
              ),
              padding: EdgeInsets.all(20),
              child: Text(loadingProvider.errorText,
                  style: TextStyle(color: Colors.white)),
            ),
          ),
      ],
    );
  }
}
