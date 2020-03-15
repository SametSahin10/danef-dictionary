import 'package:danef_dictionary/api/api.dart';
import 'package:danef_dictionary/models/word.dart';
import 'package:easy_localization/public.dart';
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
  List<Word> wordsToSuggest = List();

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
          hintText: tr("search_field_page.search_a_word"))),
      suggestionsBoxDecoration: SuggestionsBoxDecoration(
        borderRadius: BorderRadius.circular(18)
      ),
      suggestionsCallback: (pattern) {
        return pattern.isEmpty ? null : getWords(pattern.toLowerCase());
      },
      noItemsFoundBuilder: (_) => _buildNoItemsFoundWidget(),
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

  Future<List<String>> getWords(String pattern) async {
    final matchingTurkishWords =
              await Api.retrieveTurkishWordsByPattern(pattern);
    final matchingAdigeWords =
              await Api.retrieveAdigeWordsByPattern(pattern);
    wordsToSuggest.addAll(matchingTurkishWords);
    wordsToSuggest.addAll(matchingAdigeWords);
    List<String> wordsAsStrings = new List();
    matchingTurkishWords.forEach(
      (matchingTurkishWord) {
        wordsAsStrings.add(matchingTurkishWord.turkish);
      }
    );
    matchingAdigeWords.forEach(
      (matchingAdigeWord) {
        wordsAsStrings.add(matchingAdigeWord.adige);
      }
    );
    return wordsAsStrings;
  }

  getMeaning(String word) {
    for (final wordToSuggest in wordsToSuggest) {
      if (wordToSuggest.adige == word) {
        return wordToSuggest.turkish;
      }
      if (wordToSuggest.turkish == word) {
        return wordToSuggest.adige;
      }
    }
    return tr("search_field_page.no_meaning_desc_text");
  }
}

Widget _buildNoItemsFoundWidget() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      width: double.infinity,
      child: Text(
        tr("search_field_page.no_match_found_desc_text"),
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 22,
        ),
      ),
    ),
  );
}
