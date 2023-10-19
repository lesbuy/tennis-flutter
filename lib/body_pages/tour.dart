import 'package:flutter/material.dart';

class Tour extends StatefulWidget {
  const Tour({Key? key}) : super(key: key);
  @override
  State<Tour> createState() => _TourState();
}

class _TourState extends State<Tour> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "赛事页面",
      ),
    );
  }
}
