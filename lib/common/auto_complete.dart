import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'dart:async';
import 'package:coric_tennis/base/http.dart';

class AutoComplete extends StatefulWidget {
  dynamic _selected;
  dynamic get selected => _selected;
  final Function(dynamic) callback;

  AutoComplete({Key? key, required this.callback}) : super(key: key);
  @override
  State<AutoComplete> createState() => _AutoCompleteState();
}

class _AutoCompleteState extends State<AutoComplete> {
  Map<String, List<dynamic>> _cache = {};
  List<dynamic> _candidates = [];
  bool _typing = false;

  final _textDelayController = TextEditingController();
  Timer? _textDelayTimer;
  FocusNode _focusNode = FocusNode();


  void callCandidate(String query) async {
    if (query == "") {
      query = "-";
    }
    if (_cache.containsKey(query)) {
      setState(() {
        _candidates = _cache[query]!;
        print(_candidates);
      });
      Future.microtask(() {
        print("这里的代码会在状态更新1后执行");
      });
    } else {
      print("一次新的请求");
      await getPlayerList(context, query).then((data) {
        if (data["success"]) {
          _cache[query] = data["players"];
          setState(() {
            _candidates = _cache[query]!;
            print(_candidates);
          });
          Future.microtask(() {
            print("这里的代码会在状态更新2后执行");
          });
        }
      });
    }
  }

  void _onTextChanged (String pattern) {
    if (_textDelayTimer?.isActive == true) {
      _textDelayTimer!.cancel();
    }
    _textDelayTimer = Timer(const Duration(milliseconds: 500), () {
      if (_typing) {  // 不在输入模式时不显示下拉列表
        callCandidate(pattern);
      }
    });
  }

  @override
  void initState() {
    super.initState();

    // _textDelayController.addListener();

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        // 焦点获得，清空输入框，进入输入模式
        _textDelayController.clear();
        setState(() {
          _typing = true;
        });
        widget.callback(null);
      }
    });
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
        child: TypeAheadField(
          suggestionsBoxVerticalOffset: 10,
          suggestionsBoxDecoration: SuggestionsBoxDecoration(
            hasScrollbar: true, // 启用滚动条
          ),
          textFieldConfiguration: TextFieldConfiguration(
            controller: _textDelayController,
            focusNode: _focusNode,
            decoration: InputDecoration(
                labelText: 'Input', border: OutlineInputBorder()),
          ),
          suggestionsCallback: (pattern) {
            return [];
          },
          itemBuilder: (context, suggestion) {
            return ListTile(
              title: Row(
                children: [
                  Text(suggestion["lo"]),
                  if (suggestion["lo"] != suggestion["le"])
                    Text(" (" + suggestion["le"] + ")"),
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
              _textDelayController.text = suggestion["lo"];
              widget.callback(suggestion);
            });
          },
        ),
    );
  }
}
