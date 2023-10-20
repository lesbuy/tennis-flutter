import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingProvider with ChangeNotifier {
  bool _isLoading = false;
  String innerText = "";
  bool get isLoading => _isLoading;
  void toggleLoading() {
    _isLoading = !_isLoading;
    notifyListeners(); // 通知监听者状态已更改
  }

  void loading() {
    _isLoading = true;
    notifyListeners(); // 通知监听者状态已更改
  }

  void deloading() {
    _isLoading = false;
    innerText = "";
    notifyListeners(); // 通知监听者状态已更改
  }

  void setText(String text) {
    innerText = text;
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
      ],
    );
  }
}
