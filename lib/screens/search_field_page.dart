import 'dart:convert';

import 'package:danef_dictionary/api/word_api.dart';
import 'package:danef_dictionary/models/word.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

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
    getWordData();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 60,
        margin: EdgeInsets.only(left: 16.0, right: 16.0),
        child: TypeAheadField(
          textFieldConfiguration: TextFieldConfiguration(
            controller: _textEditingController,
            onChanged: (newValue) {
              setState(() {
                if (newValue.length == 0) {
                  _isClearIconVisible = false;
                } else {
                  _isClearIconVisible = true;
                }
              });
            },
            textAlign: TextAlign.center,
            style: DefaultTextStyle.of(context).style.copyWith(fontSize: 18),
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              suffixIcon: Visibility(
                visible: _isClearIconVisible,
                child: IconButton(
                  icon: Icon(Icons.cancel),
                  color: Colors.green,
                  disabledColor: Colors.green,
                  onPressed: () => _textEditingController.clear(),
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(18)),
                borderSide: BorderSide(
                  color: Colors.green
                )
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(18)),
                borderSide: BorderSide(
                  color: Colors.green
                )
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(18)),
                borderSide: BorderSide(
                  color: Colors.green,
                  width: 1.5
                )
              ),
              hintStyle: TextStyle(fontSize: 18),
              hintText: 'Search a word...')),
          suggestionsBoxDecoration: SuggestionsBoxDecoration(
            borderRadius: BorderRadius.circular(18)
          ),
          suggestionsCallback: (pattern) {
            return pattern.isEmpty ? null : getWordData();
          },
          itemBuilder: (context, suggestion) {
            return ListTile(
              leading: Icon(
                Icons.input,
                color: Colors.green,
              ),
              title: Text(suggestion),
            );
          },
          onSuggestionSelected: (suggestion) {
            print(suggestion);
          },
        )),
    );
  }

//  List<String> _getSuggestions(String pattern) {
//
//  }

  Future<List<String>> getWordData() async {
    var result = await WordAPI().getWords();
    var wordMap = json.decode(result);
    print('wordMap: $wordMap');
    WordList wordList = WordList.fromJson(wordMap);
    List<String> wordsAsStrings = new List();
    List<Word> words = wordList.words;
    for (final word in words) {
      wordsAsStrings.add(word.adige);
      wordsAsStrings.add(word.turkish);
    }
    return wordsAsStrings;
  }
}