import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coric_tennis/components/http.dart';
import 'package:coric_tennis/components/loading.dart';
import 'package:coric_tennis/components/assets.dart';

class Player extends StatefulWidget {
  const Player({Key? key}) : super(key: key);
  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  bool loading = false;
  List<List<dynamic>> top10 = [[], []];

  @override
  void initState() {
    super.initState();
    // fetchInitData();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchInitData();
    });
  }

  void fetchInitData() async {
    final loadingProvider =
        Provider.of<LoadingProvider>(context, listen: false);
    loadingProvider.setText("加载球员");
    loadingProvider.loading();
    final atpFuture = officialRankTop10("atp").then((data) {
      setState(() {
        top10[0] = data;
      });
    });
    final wtaFuture = officialRankTop10("wta").then((data) {
      setState(() {
        top10[1] = data;
      });
    });
    Future.wait([atpFuture, wtaFuture]).then((_) {
      loadingProvider.deloading();
    });
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> top10View = List.filled(2, null);
    for (int i = 0; i < 2; i++) {
      top10View[i] = Column(
        children: top10[i].asMap().entries.map((entry) {
          int index = entry.key;
          Map item = entry.value;
          if (index == 0 && top10[i].isNotEmpty) {
            // 在第0个位置添加SizedBox和图像
            return Column(
              children: [
                SizedBox(
                  child: Image.network(ImgPt(item["pid"]),
                      width: 100, height: 100),
                ),
                Text(item["eng_name"]),
              ],
            );
          } else {
            return Text(item["eng_name"]);
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
    var cw = Center(
      child: Column(
        children: <Widget>[
          AppBar(
            //导航栏
            title: Text("Top10"),
            backgroundColor: Colors.amber[400],
          ),
          top10Block,
        ],
      ),
    );
    return cw;
  }
}
