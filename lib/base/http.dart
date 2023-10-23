import 'package:coric_tennis/base/http_base.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:coric_tennis/common/loading.dart';

// 本页的http请求默认带loading遮罩层，如果不需要遮罩，在参数中禁掉

// 根据名字查找球员（最多30个）
Future<dynamic> getPlayerList(BuildContext context, String name,
    {int? gender, int? timeout}) async {
  Map<String, String> params = {"name": name};
  if (gender != null) {
    params["gender"] = gender.toString();
  }
  final response = await httpGet(context, "profile/search",
      params: params, timeout: timeout);
  if (response.isNotEmpty) {
    try {
      final j = json.decode(response);
      return j;
    } catch (e) {
      final j = <String, dynamic>{
        "success": false,
        "msg": "Error: $e",
      };
      return j;
    } finally {}
  }
  final j = <String, dynamic>{
    "success": false,
    "msg": "Error: Get NULL",
  };
  return j;
}

// 读取官方排名top10
Future<dynamic> officialRankTop10(BuildContext context, String gender,
    {int? timeout, bool? disableLoading}) async {
  Object body = {
    "association": gender,
    "sd": "s",
    "period": "year",
    "start": 0,
    "length": 5,
    "draw": 2,
    "date": "2023-10-23"
  };
  final loadingProvider = Provider.of<LoadingProvider>(context, listen: false);
  if (disableLoading != true) {
    loadingProvider.setText("loading...");
    loadingProvider.loading();
  }
  final response = await httpPost(context, "official/paginate",
      body: body, timeout: timeout);
  if (response.isNotEmpty) {
    try {
      final j = json.decode(response);
      return j;
    } catch (e) {
      final j = <String, dynamic>{
        "success": false,
        "msg": "Error: $e",
      };
      if (disableLoading != true) {
        loadingProvider.setErrorText(j["msg"]);
        loadingProvider.loading();
      }
      return j;
    } finally {
      if (disableLoading != true) {
        loadingProvider.deloading();
      }
    }
  }
  final j = <String, dynamic>{
    "success": false,
    "msg": "Error: Get NULL",
  };
  if (disableLoading != true) {
    loadingProvider.setErrorText(j["msg"]);
    loadingProvider.loading();
  }
  return j;
}
