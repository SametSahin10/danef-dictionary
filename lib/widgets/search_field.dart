import 'dart:convert';

import 'package:danef_dictionary/api/word_api.dart';
import 'package:danef_dictionary/models/word.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class SearchField extends StatefulWidget {
  TextEditingController textEditingController;
  FocusNode focusNode;
  bool isClearIconVisible;


  SearchField({this.textEditingController,
               this.focusNode,
               this.isClearIconVisible});

  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  @override
  Widget build(BuildContext context) {
    return TypeAheadField(
      textFieldConfiguration: TextFieldConfiguration(
        controller: widget.textEditingController,
        focusNode: widget.focusNode,
        onChanged: (newValue) {
          setState(() {
            if (newValue.length == 0) {
              widget.isClearIconVisible = false;
            } else {
              widget.isClearIconVisible = true;
            }
          });
        },
        textAlign: TextAlign.center,
        style: DefaultTextStyle.of(context).style.copyWith(fontSize: 20),
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
          suffixIcon: Visibility(
            visible: widget.isClearIconVisible,
            child: IconButton(
              icon: Icon(Icons.cancel),
              onPressed: () => widget.textEditingController.clear(),
            ),
          ),
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
          ),
          title: Text(suggestion),
        );
      },
      onSuggestionSelected: (suggestion) {
        print(suggestion);
      },
    );
  }

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
