import 'package:flutter/material.dart';

class AutoComplete extends StatefulWidget {
  const AutoComplete({Key? key}) : super(key: key);
  @override
  State<AutoComplete> createState() => _AutoCompleteState();
}

class _AutoCompleteState extends State<AutoComplete> {
  List<dynamic> candidates = [];
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "排名页面",
      ),
    );
  }
}
