import 'dart:convert';

import 'package:danef_dictionary/api/word_api.dart';
import 'package:danef_dictionary/models/word.dart';
import 'package:danef_dictionary/widgets/search_field.dart';
import 'package:flutter/material.dart';

class SearchFieldPage extends StatefulWidget {
  @override
  _SearchFieldPageState createState() => _SearchFieldPageState();
}

class _SearchFieldPageState extends State<SearchFieldPage> {
  final _textEditingController = TextEditingController();
  bool _isClearIconVisible = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 60,
        margin: EdgeInsets.only(left: 16.0, right: 16.0),
        child: SearchField(
          isClearIconVisible: _isClearIconVisible,
          textEditingController: _textEditingController,
        )
      ),
    );
  }

//  List<String> _getSuggestions(String pattern) {
//
//  }
}