import 'package:coric_tennis/components/http_base.dart';
import 'dart:convert';

// 读取官方排名top10
Future<dynamic> officialRankTop10(String gender) async {
  Object body = {
    "association": gender,
    "sd": "s",
    "period": "year",
    "start": 0,
    "length": 10,
    "draw": 2,
    "date": "2023-10-16"
  };
  String url = "$httpRoot/api/v1/zh/official/paginate";
  final response = await httpPost(url, body: body);
  if (response.isNotEmpty) {
    try {
      final j = json.decode(response);
      // print(response);
      if (j["success"]) {
        print(j["data"]);
        return j["data"];
      }
    } catch (e) {
      print("捕捉异常：$e");
    }
  }
  return null;
}
