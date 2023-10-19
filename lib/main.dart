import 'package:flutter/material.dart';
import 'package:coric_tennis/components/iconfont.dart';

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

  void _onItemTapped(int index) {
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
              icon: const Icon(IconFont.rank),
              onPressed: () => _onItemTapped(1),
            ),
            IconButton(
              icon: const Icon(IconFont.trophy),
              onPressed: () => _onItemTapped(2),
            ),
            IconButton(
              icon: const Icon(IconFont.single),
              onPressed: () => _onItemTapped(3),
            ),
            IconButton(
              icon: const Icon(IconFont.refresh),
              onPressed: () => _onItemTapped(4),
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

class Player extends StatefulWidget {
  const Player({Key? key}) : super(key: key);
  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "球员页面",
      ),
    );
  }
}

class Rank extends StatefulWidget {
  const Rank({Key? key}) : super(key: key);
  @override
  State<Rank> createState() => _RankState();
}

class _RankState extends State<Rank> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "排名页面",
      ),
    );
  }
}

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

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);
  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "设置页面",
      ),
    );
  }
}

class DefaultPage extends StatefulWidget {
  const DefaultPage({Key? key}) : super(key: key);
  @override
  State<DefaultPage> createState() => _DefaultPageState();
}

class _DefaultPageState extends State<DefaultPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "默认页面",
      ),
    );
  }
}
