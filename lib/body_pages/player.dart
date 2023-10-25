import 'dart:async';

import 'package:coric_tennis/common/image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coric_tennis/base/http.dart';
import 'package:coric_tennis/common/loading.dart';
import 'package:coric_tennis/common/auto_complete.dart';
import 'package:coric_tennis/common/assets.dart';
import 'package:transparent_image/transparent_image.dart';

class Player extends StatefulWidget {
  const Player({Key? key}) : super(key: key);
  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  dynamic _selectedPlayer;
  final List<List<dynamic>> _top10 = [[], []];
  final List<String> _favPlayers = ["230234", "328120", "322222"];
  final List<Widget> _favPlayersWidgets = [];

  @override
  void initState() {
    super.initState();
    // fetchInitData();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // fetchInitData();
    });
  }

  // 初始化时获取男女top10
  void fetchInitData() async {
    final loadingProvider =
        Provider.of<LoadingProvider>(context, listen: false);
    loadingProvider.setText("加载球员");
    loadingProvider.loading();

    // 加载男女Top10
    final atpFuture =
        officialRankTop10(context, "atp", disableLoading: true).then((data) {
      if (data["success"]) {
        setState(() {
          _top10[0] = data["data"];
        });
      } else {
        loadingProvider.setErrorText(data["msg"]);
      }
    });
    final wtaFuture =
        officialRankTop10(context, "wta", disableLoading: true).then((data) {
      if (data["success"]) {
        setState(() {
          _top10[1] = data["data"];
        });
      } else {
        loadingProvider.setErrorText(data["msg"]);
      }
    });

    // 加载星标球员
    Future.delayed(const Duration(milliseconds: 800), () {
      setState(() {
        _favPlayers.map((e) {
          _favPlayersWidgets.add(Headshot(
            e,
            height: 80,
            borderRadius: 50,
            decoration: const BoxDecoration(color: Colors.grey),
          ));
        });
      });
    });

    Future.wait([atpFuture, wtaFuture]).then((_) {
      loadingProvider.deloading();
    });
  }

  @override
  Widget build(BuildContext context) {
    // top10版块
    List<dynamic> top10View = List.filled(2, null);
    for (int i = 0; i < 2; i++) {
      top10View[i] = Column(
        children: _top10[i].asMap().entries.map((entry) {
          int index = entry.key;
          Map item = entry.value;
          if (index == 0 && _top10[i].isNotEmpty) {
            // 在第0个位置添加SizedBox和图像，其它行只显示名字
            return Column(
              children: [
                // 若施回点击动作，需要用GestureDetector包起来
                GestureDetector(
                  onTap: () {},
                  child: SizedBox(
                    child: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: imgPt(item["pid"]),
                        width: 100,
                        height: 100),
                  ),
                ),
                Text(item["name"]),
              ],
            );
          } else {
            return Text(item["name"]);
          }
        }).toList(),
      );
    }
    var top10Block = Row(
      children: [
        Expanded(
          child: top10View[0],
        ),
        Expanded(
          child: top10View[1],
        ),
      ],
    );

    // 球员搜索条
    var input = AutoComplete(callback: (item) {
      setState(() {
        _selectedPlayer = item;
      });
    });

    var myPlayers = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ListTile(
          title: Text("My Players"),
        ),
        Padding(
            padding: const EdgeInsets.only(left: 24),
            child: Wrap(
              alignment: WrapAlignment.start,
              spacing: 12.0,
              children: _favPlayersWidgets,
            )),
      ],
    );

    // 主界面
    var cw = Center(
      child: Column(
        children: <Widget>[
          AppBar(
            //导航栏
            title: const Text("PLAYERS"),
            backgroundColor: Colors.amber[400],
          ),
          top10Block,
          input,
          Text(_selectedPlayer != null ? "已选择：${_selectedPlayer["le"]}" : ""),
          myPlayers,
        ],
      ),
    );
    return cw;
  }
}
