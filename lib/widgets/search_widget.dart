import 'dart:convert';

import 'package:danef_dictionary/api/word_api.dart';
import 'package:danef_dictionary/models/word.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class SearchField extends StatefulWidget {
  TextEditingController textEditingController;
  FocusNode focusNode;
  bool isClearIconVisible;
  Function clearMeaning;
  Function showMeaning;
  Function setWordAndMeaning;

  SearchField({this.textEditingController,
               this.focusNode,
               this.isClearIconVisible,
               this.clearMeaning,
               this.showMeaning,
               this.setWordAndMeaning});

  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  List<Word> words;

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
        return pattern.isEmpty ? null : getWordData(pattern);
      },
      keepSuggestionsOnLoading: false,
      itemBuilder: (context, suggestion) {
        return ListTile(
          leading: Icon(
            Icons.input,
          ),
          title: Text(
            suggestion,
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'OpenSans'
            ),
          ),
        );
      },
      onSuggestionSelected: (suggestion) {
        widget.setWordAndMeaning(suggestion, getMeaning(suggestion));
        widget.clearMeaning();
        widget.showMeaning();
      },
    );
  }

  Future<List<String>> getWordData(String pattern) async {
    var result = await WordAPI().getWords();
    var wordMap = json.decode(result);
    print('wordMap: $wordMap');
    WordList wordList = WordList.fromJson(wordMap);
    List<String> wordsAsStrings = new List();
    words = wordList.words;
    for (final word in words) {
      if (word.adige.contains(pattern)) {
        wordsAsStrings.add(word.adige);
      }
      if (word.turkish.contains(pattern)) {
        wordsAsStrings.add(word.turkish);
      }
    }
    return wordsAsStrings;
  }

  getMeaning(String word) {
    for (final element in words) {
      if (element.adige == word) {
        return element.turkish;
      }
      if (element.turkish == word) {
        return element.adige;
      }
    }
    return "Could not find meaning";
  }
}
