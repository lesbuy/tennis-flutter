import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coric_tennis/common/iconfont.dart';
import 'package:coric_tennis/base/global.dart';

import 'package:coric_tennis/body_pages/player.dart';
import 'package:coric_tennis/body_pages/rank.dart';
import 'package:coric_tennis/body_pages/setting.dart';
import 'package:coric_tennis/body_pages/tour.dart';
import 'package:coric_tennis/body_pages/score.dart';
import 'package:coric_tennis/body_pages/default.dart';
import 'package:coric_tennis/common/loading.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<LoadingProvider>(
          create: (context) => LoadingProvider(),
        ),
        ChangeNotifierProvider<GlobalProvider>(
          create: (context) => GlobalProvider(),
        ),
      ],
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
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 7,
            ),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.deepOrange[900],
          unselectedItemColor: Colors.green[400],
          currentIndex: _tabIndex,
          onTap: _onChooseItem,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(IconFont.player),
              label: 'Player',
            ),
            BottomNavigationBarItem(
              icon: Icon(IconFont.trophy),
              label: 'Tour',
            ),
            BottomNavigationBarItem(
              icon: Icon(IconFont.score),
              label: 'Score',
            ),
            BottomNavigationBarItem(
              icon: Icon(IconFont.rank),
              label: 'Rank',
            ),
            BottomNavigationBarItem(
              icon: Icon(IconFont.profile),
              label: 'Profile',
            ),
          ],
        ),
      ),
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
    if (widget.tabIndex == 0) {
      return const Player();
    } else if (widget.tabIndex == 1) {
      return const Tour();
    } else if (widget.tabIndex == 2) {
      return const Score();
    } else if (widget.tabIndex == 3) {
      return const Rank();
    } else if (widget.tabIndex == 4) {
      return const Setting();
    } else {
      return const DefaultPage();
    }
  }
}
