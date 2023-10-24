import 'package:coric_tennis/base/global.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';

String apiRoot = "https://api.live-tennis.cn";
String apiTestRoot = "https://api-test.live-tennis.cn";
String staticRoot = "https://static.live-tennis.cn";

String apiVersion = "v1";

Future<String> httpGet(BuildContext context, String route,
    {Map<String, String>? params,
    Map<String, String>? headers,
    int? timeout}) async {
  timeout ??= 10;
  try {
    var glob = Provider.of<GlobalProvider>(context, listen: false);
    var url = glob.isTest ? apiTestRoot : apiRoot;
    url = [url, "api", apiVersion, glob.lang, route].join("/");
    if (params != null && params.isNotEmpty) {
      final uri = Uri.https(Uri.parse(url).host, Uri.parse(url).path, params);
      url = uri.toString();
    }
    // print(url);
    final response = await http
        .get(Uri.parse(url), headers: headers)
        .timeout(Duration(seconds: timeout));
    if (response.statusCode == 200) {
      return utf8.decode(response.bodyBytes);
    } else {
      return json.encode(<String, dynamic>{
        "success": false,
        "msg": "Error: Code = ${response.statusCode.toString()}",
      });
    }
  } catch (e) {
    return json.encode(<String, dynamic>{
      "success": false,
      "msg": "Error: ${e.toString()}",
    });
  }
}

Future<String> httpPost(BuildContext context, String route,
    {Map<String, String>? params,
    Map<String, String>? headers,
    Object? body,
    int? timeout}) async {
  timeout ??= 10;
  try {
    var glob = Provider.of<GlobalProvider>(context, listen: false);
    var url = glob.isTest ? apiTestRoot : apiRoot;
    url = [url, "api", apiVersion, glob.lang, route].join("/");
    if (params != null && params.isNotEmpty) {
      final uri = Uri.https(Uri.parse(url).host, Uri.parse(url).path, params);
      url = uri.toString();
    }
    headers ??= <String, String>{};
    headers["Content-Type"] = "application/json";
    final response = await http
        .post(Uri.parse(url), headers: headers, body: json.encode(body))
        .timeout(Duration(seconds: timeout));
    if (response.statusCode == 200) {
      return utf8.decode(response.bodyBytes);
    } else {
      return json.encode(<String, dynamic>{
        "success": false,
        "msg": "Error: Code = ${response.statusCode.toString()}",
      });
    }
  } catch (e) {
    return json.encode(<String, dynamic>{
      "success": false,
      "msg": "Error: ${e.toString()}",
    });
  }
}
