import 'dart:async';

import 'package:coric_tennis/common/image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coric_tennis/base/http.dart';
import 'package:coric_tennis/base/pair.dart';
import 'package:coric_tennis/common/loading.dart';
import 'package:coric_tennis/common/auto_complete.dart';
import 'package:coric_tennis/common/table.dart';
import 'package:coric_tennis/common/assets.dart';
import 'package:transparent_image/transparent_image.dart';

var divider = Container(
    margin: const EdgeInsets.only(top: 12, bottom: 12),
    child: Divider(
      color: Colors.grey[300],
      height: 1, // 设置分割线的高度
      thickness: 1, // 设置分割线的厚度
    ));

class Player extends StatefulWidget {
  const Player({Key? key}) : super(key: key);
  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  dynamic _selectedPlayer;
  final List<List<dynamic>> _top5Array = [[], []];
  final List<String> _favPlayers = ["230234", "328120", "322222"];
  List<Widget> _favPlayersWidgets = [];
  PDataTable? _top5;

  final List<Pair<String, String>> _schema = [
    Pair("ID", "id"),
    Pair("FRank", "f_rank"),
    Pair("CRank", "c_rank"),
    Pair("Point", "point"),
    Pair("F", "first"),
    Pair("L", "last"),
    Pair("IOC", "ioc"),
    Pair("Age", "age"),
  ];

  @override
  void initState() {
    super.initState();
    _top5 = generateTop5();
    // fetchInitData();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchInitData();
    });
  }

  PDataTable generateTop5() {
    return PDataTable(
      schema: _schema,
      rows: _top5Array[0],
    );
  }

  // 初始化时获取男女top10
  void fetchInitData() async {
    final loadingProvider =
        Provider.of<LoadingProvider>(context, listen: false);
    loadingProvider.setText("");
    loadingProvider.loading();

    // 加载男女Top10
    final atpFuture =
        liveRank(context, "atp", disableLoading: true).then((data) {
      if (data["success"]) {
        setState(() {
          _top5Array[0] = data["data"];
          _top5 = generateTop5();
        });
      } else {
        loadingProvider.setErrorText(data["msg"]);
      }
    });
    final wtaFuture =
        liveRank(context, "wta", disableLoading: true).then((data) {
      if (data["success"]) {
        setState(() {
          _top5Array[1] = data["data"];
        });
      } else {
        loadingProvider.setErrorText(data["msg"]);
      }
    });

    // 加载星标球员
    Future.delayed(const Duration(milliseconds: 800)).then((_) {
      setState(() {
        _favPlayersWidgets = _favPlayers.map((e) {
          return Headshot(
            e,
            height: 80,
            borderRadius: 50,
            decoration: const BoxDecoration(color: Colors.grey),
          );
        }).toList();
      });
    });

    Future.wait([atpFuture, wtaFuture]).then((_) {
      loadingProvider.deloading();
    });
  }

  @override
  Widget build(BuildContext context) {
    // 版块1：球员搜索条
    var input = AutoComplete(callback: (item) {
      setState(() {
        _selectedPlayer = item;
      });
    });

    // 版块2：星标球员
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

    // 版块3：top5排名

    // 主界面
    var cw = ListView(
      shrinkWrap: true,
      children: <Widget>[
        AppBar(
          //导航栏
          title: const Text("PLAYERS"),
          backgroundColor: Colors.amber[400],
        ),
        input,
        Text(_selectedPlayer != null ? "已选择：${_selectedPlayer["le"]}" : ""),
        divider,
        myPlayers,
        divider,
        _top5 ?? const SizedBox(),
      ],
    );
    return cw;
  }
}
