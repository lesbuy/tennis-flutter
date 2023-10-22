import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coric_tennis/components/iconfont.dart';
import 'package:coric_tennis/components/global.dart';

import 'package:coric_tennis/body_pages/player.dart';
import 'package:coric_tennis/body_pages/rank.dart';
import 'package:coric_tennis/body_pages/setting.dart';
import 'package:coric_tennis/body_pages/tour.dart';
import 'package:coric_tennis/body_pages/score.dart';
import 'package:coric_tennis/body_pages/default.dart';
import 'package:coric_tennis/components/loading.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => LoadingProvider(), // 创建LoadingProvider
      child: const MyApp(),
    ),
  );
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
              isSelected: _tabIndex == 1,
              icon: const Icon(IconFont.player),
              onPressed: () => _onChooseItem(1),
            ),
            IconButton(
              isSelected: _tabIndex == 2,
              icon: const Icon(IconFont.trophy),
              onPressed: () => _onChooseItem(2),
            ),
            IconButton(
              isSelected: _tabIndex == 3,
              icon: const Icon(IconFont.score),
              onPressed: () => _onChooseItem(3),
            ),
            IconButton(
              isSelected: _tabIndex == 4,
              icon: const Icon(IconFont.rank),
              onPressed: () => _onChooseItem(4),
            ),
            IconButton(
              isSelected: _tabIndex == 5,
              icon: const Icon(IconFont.profile),
              onPressed: () => _onChooseItem(5),
            ),
          ],
        )
      ],
      body:
          Stack(children: [Body(tabIndex: _tabIndex), const LoadingOverlay()]),
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
      return const Tour();
    } else if (widget.tabIndex == 3) {
      return const Score();
    } else if (widget.tabIndex == 4) {
      return const Rank();
    } else if (widget.tabIndex == 5) {
      return const Setting();
    } else {
      return const DefaultPage();
    }
  }
}
