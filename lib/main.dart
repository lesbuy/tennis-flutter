import 'package:flutter/material.dart';
import 'package:coric_tennis/components/iconfont.dart';
import 'package:coric_tennis/body_pages/player.dart';
import 'package:coric_tennis/body_pages/rank.dart';
import 'package:coric_tennis/body_pages/setting.dart';
import 'package:coric_tennis/body_pages/tour.dart';
import 'package:coric_tennis/body_pages/default.dart';

void main() {
  runApp(const MyApp());
}

// root
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '丘的网球 Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 11, 239, 49)),
        useMaterial3: true,
      ),
      home: const Home(title: '丘的网球/首页'),
    );
  }
}

// 首页
class Home extends StatefulWidget {
  const Home({super.key, required this.title});
  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _tabIndex = 0;

  void _onChooseItem(int index) {
    setState(() {
      _tabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(IconFont.single),
              onPressed: () => _onChooseItem(1),
            ),
            IconButton(
              icon: const Icon(IconFont.rank),
              onPressed: () => _onChooseItem(2),
            ),
            IconButton(
              icon: const Icon(IconFont.trophy),
              onPressed: () => _onChooseItem(3),
            ),
            IconButton(
              icon: const Icon(IconFont.profile),
              onPressed: () => _onChooseItem(4),
            ),
          ],
        )
      ],
      body: Body(tabIndex: _tabIndex),
    );
  }
}

class Body extends StatefulWidget {
  const Body({Key? key, required this.tabIndex}) : super(key: key);
  final int tabIndex;
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    if (widget.tabIndex == 1) {
      return const Player();
    } else if (widget.tabIndex == 2) {
      return const Rank();
    } else if (widget.tabIndex == 3) {
      return const Tour();
    } else if (widget.tabIndex == 4) {
      return const Setting();
    } else {
      return const DefaultPage();
    }
  }
}
