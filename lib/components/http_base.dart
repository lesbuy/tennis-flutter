import 'package:http/http.dart' as http;
import 'dart:convert';

String httpRoot = "https://api.live-tennis.cn";
String staticRoot = "https://static.live-tennis.cn";

Future<String> httpGet(String url,
    {Map<String, String>? params, Map<String, String>? headers}) async {
  try {
    if (params != null && params.isNotEmpty) {
      final uri = Uri.https(Uri.parse(url).host, Uri.parse(url).path, params);
      url = uri.toString();
    }
    final response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      // 处理错误的HTTP响应
      print(
          "Failed to fetch data from $url. Status code: ${response.statusCode}");
      return ""; // 返回空字符串
    }
  } catch (e) {
    // 处理HTTP请求期间的异常
    print("An error occurred while fetching data from $url: $e");
    return ""; // 返回空字符串
  }
}

Future<String> httpPost(String url,
    {Map<String, String>? params,
    Map<String, String>? headers,
    Object? body}) async {
  try {
    if (params != null && params.isNotEmpty) {
      final uri = Uri.https(Uri.parse(url).host, Uri.parse(url).path, params);
      url = uri.toString();
    }
    headers ??= <String, String>{};
    headers["Content-Type"] = "application/json";
    final response = await http.post(Uri.parse(url),
        headers: headers, body: json.encode(body));
    if (response.statusCode == 200) {
      return utf8.decode(response.bodyBytes);
    } else {
      // 处理错误的HTTP响应
      print(
          "Failed to fetch data from $url. Status code: ${response.statusCode}");
      return ""; // 返回空字符串
    }
  } catch (e) {
    // 处理HTTP请求期间的异常
    print("An error occurred while fetching data from $url: $e");
    return ""; // 返回空字符串
  }
}
