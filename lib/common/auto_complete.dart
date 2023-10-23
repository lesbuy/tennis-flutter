import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'dart:async';
import 'package:coric_tennis/base/http.dart';

class AutoComplete extends StatefulWidget {
  const AutoComplete({Key? key}) : super(key: key);
  @override
  State<AutoComplete> createState() => _AutoCompleteState();
}

class _AutoCompleteState extends State<AutoComplete> {
  Map<String, List<dynamic>> _cache = {};
  List<dynamic> _candidates = [];
  String _inputed = "";
  bool _typing = false;

  final _textDelayController = TextEditingController();
  Timer? _textDelayTimer;

  void callCandidate(String query) {
    if (query == "") {
      query = "-";
    }
    if (_cache.containsKey(query)) {
      _candidates = _cache[query]!;
    } else {
      print("一次新的请求");
      getPlayerList(context, query).then((data) {
        if (data["success"]) {
          _cache[query] = data["players"];
          setState(() {
            _candidates = _cache[query]!;
            print(_candidates);
          });
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _textDelayController.addListener(() {
      if (_textDelayTimer?.isActive == true) {
        _textDelayTimer!.cancel();
      }
      _textDelayTimer = Timer(const Duration(milliseconds: 500), () {
        callCandidate(_textDelayController.text);
      });
    });
  }

  @override
  void dispose() {
    _textDelayController.dispose();
    _textDelayTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(12),
        child: Builder(
          builder: (context) {
            print("构建一次TypeAheadField");
            return TypeAheadField(
              suggestionsBoxVerticalOffset: 10,
              suggestionsBoxDecoration: SuggestionsBoxDecoration(
                hasScrollbar: true, // 启用滚动条
              ),
              textFieldConfiguration: TextFieldConfiguration(
                controller: _textDelayController,
                decoration: InputDecoration(
                    labelText: 'Input', border: OutlineInputBorder()),
              ),
              suggestionsCallback: (pattern) {
                print("suggestionsCallback触发");
                return _candidates.where((candidate) => candidate["le"]
                    .toLowerCase()
                    .contains(pattern.toLowerCase()));
              },
              itemBuilder: (context, suggestion) {
                return ListTile(
                  title: Text(suggestion["lo"]),
                );
              },
              onSuggestionSelected: (suggestion) {
                print('Selected: $suggestion');
              },
            );
          },
        ));
  }
}
