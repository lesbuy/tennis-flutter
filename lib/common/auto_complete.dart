// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'dart:async';
import 'package:coric_tennis/base/http.dart';
import 'package:coric_tennis/common/image.dart';
import 'package:coric_tennis/common/iconfont.dart';

class AutoComplete extends StatefulWidget {
  final Function(dynamic) callback;

  const AutoComplete({Key? key, required this.callback}) : super(key: key);
  @override
  State<AutoComplete> createState() => _AutoCompleteState();
}

class _AutoCompleteState extends State<AutoComplete> {
  final Map<String, List<dynamic>> _cache = {};
  List<dynamic> _candidates = [];
  bool _typing = false; // 上屏之后是false,从focus到输入时一直是true
  final _textDelayController = TextEditingController();
  Timer? _textDelayTimer;
  final FocusNode _focusNode = FocusNode();

  void callCandidate(String query) async {
    if (query == "") {
      query = "-";
    }
    if (_cache.containsKey(query)) {
      // print("从cache中读取");
      _candidates = _cache[query]!;
      // print(_candidates);
      // print("这里的代码会在状态更新1后执行");
      _textDelayController.removeListener(_onTextChanged);
      var t = _textDelayController.text;
      _textDelayController.text = "fiehfjldlskajdlksajdl";
      _textDelayController.text = t;
      _textDelayController.addListener(_onTextChanged);
    } else {
      // print("发起http请求");
      await getPlayerList(context, query).then((data) {
        if (data["success"]) {
          _cache[query] = data["players"];
          _candidates = _cache[query]!;
          // print(_candidates);
          // print("这里的代码会在状态更新2后执行");
          _textDelayController.removeListener(_onTextChanged);
          var t = _textDelayController.text;
          _textDelayController.text = "fiehfjldlskajdlksajdl";
          _textDelayController.text = t;
          _textDelayController.addListener(_onTextChanged);
        }
      });
    }
  }

  void _onTextChanged() {
    // print("执行监听器");
    if (_textDelayTimer?.isActive == true) {
      _textDelayTimer!.cancel();
    }
    _textDelayTimer = Timer(const Duration(milliseconds: 500), () {
      if (_typing) {
        // 不在输入模式时不显示下拉列表
        callCandidate(_textDelayController.text);
      }
    });
  }

  void _onTextFocused() {
    if (_focusNode.hasFocus) {
      // 焦点获得，清空输入框，进入输入模式
      _textDelayController.clear();
      setState(() {
        _typing = true;
      });
      widget.callback(null);
    }
  }

  @override
  void initState() {
    super.initState();
    _textDelayController.addListener(_onTextChanged);
    _focusNode.addListener(_onTextFocused);
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _textDelayController.dispose();
    _textDelayTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: TypeAheadField<dynamic>(
        suggestionsBoxVerticalOffset: 10,
        suggestionsBoxDecoration: const SuggestionsBoxDecoration(
          hasScrollbar: true, // 启用滚动条
        ),
        textFieldConfiguration: TextFieldConfiguration(
          controller: _textDelayController,
          focusNode: _focusNode,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            fillColor: Colors.black12,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50.0), // 设置边框圆角
              borderSide: BorderSide.none, // 去掉默认的边框
            ),
            prefixIcon: const Icon(IconFont.query),
          ),
        ),
        suggestionsCallback: (pattern) {
          return _candidates;
        },
        itemBuilder: (context, suggestion) {
          return ListTile(
            dense: true,
            title: Wrap(
              spacing: 3,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                IocFlag(
                  suggestion["i"],
                  height: 20,
                ),
                Text(
                  suggestion["lo"],
                  style: const TextStyle(fontSize: 15),
                ),
                if (suggestion["lo"] != suggestion["le"])
                  Text(
                    "(${suggestion["le"]})",
                    style: const TextStyle(fontSize: 12),
                  ),
              ],
            ),
          );
        },
        onSuggestionSelected: (suggestion) {
          // 上屏时，清除输入模式
          setState(() {
            _typing = false;
          });
          Future.microtask(() {
            _textDelayController.text = suggestion["le"];
            widget.callback(suggestion);
          });
        },
      ),
    );
  }
}
