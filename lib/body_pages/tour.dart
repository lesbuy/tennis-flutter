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
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          IocFlag("CHN", height: 30),
          Headshot(
            "328120",
            height: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(100))),
          ),
          Portrait(
            "328120",
            height: 300,
            width: 300,
          )
        ],
      ),
    );
  }
}
