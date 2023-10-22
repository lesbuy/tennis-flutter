import 'package:flutter/material.dart';

class Score extends StatefulWidget {
  const Score({Key? key}) : super(key: key);
  @override
  State<Score> createState() => _ScoreState();
}

class _ScoreState extends State<Score> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "赛程页面",
      ),
    );
  }
}
