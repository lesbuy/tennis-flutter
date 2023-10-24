import 'package:flutter/material.dart';
import 'package:coric_tennis/common/image.dart';

class Tour extends StatefulWidget {
  const Tour({Key? key}) : super(key: key);
  @override
  State<Tour> createState() => _TourState();
}

class _TourState extends State<Tour> {
  List<Widget> svgWidgets = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        children: [IocFlag("CHN", height: 30)],
      ),
    );
  }
}
